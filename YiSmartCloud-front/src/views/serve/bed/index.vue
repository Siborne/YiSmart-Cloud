<template>
  <div class="app-container bed-preview-page">
    <div class="preview-header">
      <div class="floor-tabs">
        <span
          class="floor-tab"
          :class="{ active: currentFloor === 'all' }"
          @click="selectFloor('all')"
        >
          全部
        </span>
        <span
          v-for="floor in floorOptions"
          :key="floor"
          class="floor-tab"
          :class="{ active: currentFloor === String(floor) }"
          @click="selectFloor(String(floor))"
        >
          {{ floor }}楼
        </span>
      </div>
      <div class="header-actions">
        <el-button plain class="theme-btn-plain" @click="goRoomPage">新增房间</el-button>
        <el-button class="theme-btn" @click="handleAdd()" v-hasPermi="['serve:bed:add']">新增床位</el-button>
      </div>
    </div>

    <div class="bed-toolbar">
      <div class="legend">
        <span class="legend-item"><el-icon class="legend-icon free"><CircleCheckFilled /></el-icon>{{ getBedStatusLabel(0) }}</span>
        <span class="legend-item"><el-icon class="legend-icon occupied"><UserFilled /></el-icon>{{ getBedStatusLabel(1) }}</span>
        <span class="legend-item"><el-icon class="legend-icon leave"><WarningFilled /></el-icon>{{ getBedStatusLabel(2) }}</span>
      </div>
      <el-radio-group v-model="viewMode" size="small" @change="onViewModeChange">
        <el-radio-button label="available">仅可预约</el-radio-button>
        <el-radio-button label="all">全部床位</el-radio-button>
      </el-radio-group>
      <right-toolbar :showSearch="showSearch" @update:showSearch="showSearch = $event" @queryTable="getList" />
    </div>

    <el-empty v-if="!loading && roomPreviewList.length === 0" description="暂无床位数据" />
    <div v-else class="room-grid" v-loading="loading">
      <div v-for="room in roomPreviewList" :key="room.id" class="room-card">
        <div class="room-card-header">
          <div class="room-title-wrap">
            <div class="room-title">{{ room.roomNo || `房间${room.id}` }}</div>
            <div class="room-header-actions">
              <el-button link type="primary" icon="Edit" @click="goRoomPage" />
            </div>
          </div>
          <el-button circle link type="success" icon="Plus" @click="handleAdd(room.id)" v-hasPermi="['serve:bed:add']" />
        </div>
        <div class="bed-list">
          <div v-for="bed in room.beds" :key="bed.id" class="bed-item" :class="getBedStatusClass(bed.bedStatus)">
            <div class="bed-info">
              <div class="bed-no"><i class="bed-icon"></i>{{ bed.bedNo }}</div>
              <div class="bed-status">
                <el-icon class="status-icon" :class="getBedStatusClass(bed.bedStatus)">
                  <CircleCheckFilled v-if="Number(bed.bedStatus) === 0" />
                  <UserFilled v-else-if="Number(bed.bedStatus) === 1" />
                  <WarningFilled v-else />
                </el-icon>
                {{ getBedStatusLabel(bed.bedStatus) }}
              </div>
            </div>
            <div class="bed-actions">
              <el-button link type="primary" icon="Edit" @click="handleUpdate(bed)" v-hasPermi="['serve:bed:edit']" />
              <el-button link type="primary" icon="Delete" @click="handleDelete(bed)" v-hasPermi="['serve:bed:remove']" />
            </div>
          </div>
          <el-empty v-if="room.beds.length === 0" description="暂无床位" :image-size="56" />
        </div>
      </div>
    </div>

    <el-dialog :title="title" v-model="open" width="520px" append-to-body>
      <el-form ref="bedRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="所属房间" prop="roomId">
          <el-select v-model="form.roomId" placeholder="请选择所属房间" style="width: 100%">
            <el-option v-for="room in roomOptions" :key="room.id" :label="room.roomNo || `房间${room.id}`" :value="room.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="床位编号" prop="bedNo">
          <el-input v-model="form.bedNo" placeholder="请输入床位编号（例：101-1）" />
        </el-form-item>
        <el-form-item label="床位状态" prop="bedStatus">
          <el-radio-group v-model="form.bedStatus">
            <el-radio
              v-for="dict in bedStatusOptions"
              :key="dict.value"
              :value="Number(dict.value)"
              :label="dict.label"
            />
          </el-radio-group>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Bed">
import { listBed, getBed, delBed, addBed, updateBed } from "@/api/serve/bed"
import { listRoom } from "@/api/serve/room"
import { useRouter } from "vue-router"
import { CircleCheckFilled, UserFilled, WarningFilled } from "@element-plus/icons-vue"

const { proxy } = getCurrentInstance()
const router = useRouter()

const bedList = ref([])
const roomOptions = ref([])
const roomPreviewList = ref([])
const currentFloor = ref("all")
const open = ref(false)
const loading = ref(true)
const showSearch = ref(false)
const title = ref("")
const viewMode = ref("available")
const { bed_status } = proxy.useDict("bed_status")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 500,
    roomId: null,
    bedNo: null,
    bedStatus: null
  },
  rules: {
    roomId: [{ required: true, message: "所属房间不能为空", trigger: "change" }],
    bedNo: [{ required: true, message: "床位编号不能为空", trigger: "blur" }],
    bedStatus: [{ required: true, message: "请选择床位状态", trigger: "change" }]
  }
})

const { queryParams, form, rules } = toRefs(data)

const floorOptions = computed(() => {
  const floorSet = new Set(roomOptions.value.map(item => item.floorId).filter(item => item !== null && item !== undefined))
  return Array.from(floorSet).sort((a, b) => Number(a) - Number(b))
})

const bedStatusOptions = computed(() => {
  return bed_status.value || []
})

function getList() {
  applyViewModeFilter()
  loading.value = true
  Promise.all([
    listRoom({ pageNum: 1, pageSize: 500 }),
    listBed(queryParams.value)
  ]).then(([roomRes, bedRes]) => {
    roomOptions.value = roomRes.rows || []
    bedList.value = bedRes.rows || []
    buildRoomPreviewList()
  }).finally(() => {
    loading.value = false
  })
}

function buildRoomPreviewList() {
  const bedMap = new Map()
  bedList.value.forEach(item => {
    const group = bedMap.get(item.roomId) || []
    group.push(item)
    bedMap.set(item.roomId, group)
  })
  const selectedFloor = currentFloor.value === "all" ? null : Number(currentFloor.value)
  roomPreviewList.value = roomOptions.value
    .filter(room => selectedFloor === null || Number(room.floorId) === selectedFloor)
    .map(room => {
      const beds = (bedMap.get(room.id) || []).sort((a, b) => String(a.bedNo).localeCompare(String(b.bedNo)))
      return { ...room, beds }
    })
}

watch(currentFloor, () => {
  buildRoomPreviewList()
})

function selectFloor(floor) {
  currentFloor.value = floor
}

function onViewModeChange() {
  getList()
}

function applyViewModeFilter() {
  queryParams.value.bedStatus = viewMode.value === "available" ? 0 : null
}

function goRoomPage() {
  router.push("/serve/room")
}

function getBedStatusLabel(status) {
  const dict = bedStatusOptions.value.find(item => Number(item.value) === Number(status))
  return dict ? dict.label : "未知"
}

function getBedStatusClass(status) {
  if (Number(status) === 0) return "status-free"
  if (Number(status) === 1) return "status-occupied"
  if (Number(status) === 2) return "status-repair"
  return ""
}

function reset() {
  form.value = {
    id: null,
    roomId: null,
    bedNo: null,
    bedStatus: 0
  }
  proxy.resetForm("bedRef")
}

function cancel() {
  open.value = false
  reset()
}

function handleAdd(roomId) {
  reset()
  if (roomId) {
    form.value.roomId = roomId
  }
  open.value = true
  title.value = "新增床位"
}

function handleUpdate(row) {
  reset()
  getBed(row.id).then(response => {
    form.value = response.data
    form.value.roomId = Number(form.value.roomId)
    form.value.bedStatus = Number(form.value.bedStatus)
    open.value = true
    title.value = "修改床位"
  })
}

function submitForm() {
  proxy.$refs["bedRef"].validate(valid => {
    if (!valid) {
      return
    }
    const payload = {
      ...form.value,
      roomId: Number(form.value.roomId),
      bedStatus: Number(form.value.bedStatus)
    }
    const request = payload.id ? updateBed(payload) : addBed(payload)
    request.then(() => {
      proxy.$modal.msgSuccess(payload.id ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}

function handleDelete(row) {
  proxy.$modal.confirm(`是否确认删除床位“${row.bedNo}”？`).then(() => {
    return delBed(row.id)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

getList()
</script>

<style scoped>
.preview-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
  gap: 12px;
}

.floor-tabs {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 14px;
}

.floor-tab {
  font-size: 13px;
  color: #606266;
  cursor: pointer;
  padding-bottom: 6px;
  border-bottom: 2px solid transparent;
}

.floor-tab.active {
  color: #00a884;
  border-bottom-color: #00a884;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}

.theme-btn {
  background: #00a884;
  border-color: #00a884;
  color: #fff;
}

.theme-btn:hover,
.theme-btn:focus {
  background: #12b993;
  border-color: #12b993;
  color: #fff;
}

.theme-btn-plain {
  border-color: #b9ebdf;
  color: #00a884;
  background: #f2fbf8;
}

.theme-btn-plain:hover,
.theme-btn-plain:focus {
  border-color: #00a884;
  color: #00a884;
  background: #e8f8f3;
}

.bed-toolbar {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  margin-bottom: 16px;
  gap: 12px;
}

.legend {
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: 13px;
  color: #606266;
}

.legend-item {
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.legend-icon {
  font-size: 14px;
}

.legend-icon.free {
  color: #67c23a;
}

.legend-icon.occupied {
  color: #409eff;
}

.legend-icon.leave {
  color: #e6a23c;
}

.room-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 12px;
}

.room-card {
  border: 1px solid #ebeef5;
  border-radius: 6px;
  padding: 10px 12px;
  background: #fff;
}

.room-card-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.room-title-wrap {
  display: inline-flex;
  align-items: center;
  gap: 8px;
}

.room-title {
  font-size: 17px;
  font-weight: 700;
  color: #303133;
}

.room-header-actions {
  display: inline-flex;
  align-items: center;
}

.bed-list {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 8px;
}

.bed-item {
  border-radius: 2px;
  border: 1px solid #f0f0f0;
  padding: 8px 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.bed-info {
  min-width: 0;
}

.bed-no {
  font-size: 13px;
  color: #303133;
  margin-bottom: 4px;
  display: inline-flex;
  align-items: center;
  gap: 6px;
}

.bed-status {
  font-size: 12px;
  color: #909399;
  display: inline-flex;
  align-items: center;
  gap: 4px;
}

.bed-icon {
  width: 12px;
  height: 10px;
  border-radius: 1px;
  background: linear-gradient(180deg, #5ac8a8 0%, #2fb18e 100%);
  display: inline-block;
}

.bed-actions {
  display: inline-flex;
  align-items: center;
  gap: 2px;
}

.status-free {
  background: #f0f9eb;
}

.status-occupied {
  background: #fdf6ec;
}

.status-repair {
  background: #fdf6ec;
}

.status-icon.status-free {
  color: #67c23a;
}

.status-icon.status-occupied {
  color: #409eff;
}

.status-icon.status-repair {
  color: #e6a23c;
}
</style>
