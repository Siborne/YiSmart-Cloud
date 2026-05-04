<template>
  <div class="app-container room-preview-page">
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['serve:room:add']"
        >新增</el-button>
      </el-col>
      <right-toolbar :showSearch="showSearch" @update:showSearch="showSearch = $event" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="roomList" row-key="id">
      <el-table-column type="index" label="序号" width="70" align="center" />
      <el-table-column label="房间图片" width="110" align="center">
        <template #default="scope">
          <image-preview v-if="scope.row.roomImage" class="room-thumb" :src="scope.row.roomImage" :width="56" :height="56" />
          <span v-else>-</span>
        </template>
      </el-table-column>
      <el-table-column label="房型类型" align="center" min-width="140">
        <template #default="scope">
          <dict-tag :options="room_type" :value="scope.row.roomType" />
        </template>
      </el-table-column>
      <el-table-column label="楼层" align="center" min-width="100">
        <template #default="scope">
          <span>{{ getFloorLabel(scope.row.floorId) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="床位费用" align="center" min-width="120">
        <template #default="scope">
          <span>{{ scope.row.bedFee ?? "-" }}</span>
        </template>
      </el-table-column>
      <el-table-column label="房型介绍" align="left" min-width="220" show-overflow-tooltip>
        <template #default="scope">
          <span>{{ scope.row.roomDesc || "-" }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, "{y}-{m}-{d} {h}:{i}:{s}") }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" width="100">
        <template #default="scope">
          <el-tag size="small" effect="light" :type="Number(scope.row.status) === 1 ? 'success' : 'info'">
            {{ getStatusLabel(scope.row.status) }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="220" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:room:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:room:remove']">删除</el-button>
          <el-button link type="primary" icon="VideoPlay" @click="handleToggleStatus(scope.row)" v-hasPermi="['serve:room:edit']">
            {{ scope.row.status === 1 ? "停用" : "启用" }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page="queryParams.pageNum"
      :limit="queryParams.pageSize"
      @update:page="queryParams.pageNum = $event"
      @update:limit="queryParams.pageSize = $event"
      @pagination="getList"
    />

    <el-dialog :title="title" v-model="open" width="520px" append-to-body>
      <el-form ref="roomRef" :model="form" :rules="rules" label-width="95px">
        <el-form-item label="房间编号" prop="roomNo">
          <el-input v-model="form.roomNo" placeholder="请输入房间编号（例：101）" />
        </el-form-item>
        <el-form-item label="所属楼层" prop="floorId">
          <el-select v-model="form.floorId" placeholder="请选择所属楼层" style="width: 100%">
            <el-option
              v-for="floor in floorOptions"
              :key="floor.id"
              :label="floor.floorName || `${floor.floorNo}楼`"
              :value="Number(floor.id)"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="房型类型" prop="roomType">
          <el-select v-model="form.roomType" placeholder="请选择房型类型" style="width: 100%">
            <el-option v-for="item in room_type" :key="item.value" :label="item.label" :value="Number(item.value)" />
          </el-select>
        </el-form-item>
        <el-form-item label="床位费用" prop="bedFee">
          <el-input-number v-model="form.bedFee" :min="0" :precision="2" :step="100" controls-position="right" style="width: 100%" />
        </el-form-item>
        <el-form-item label="房间介绍" prop="roomDesc">
          <el-input v-model="form.roomDesc" type="textarea" :rows="3" placeholder="请输入房间介绍" />
        </el-form-item>
        <el-form-item label="房间图片" prop="roomImage">
          <image-upload v-model="form.roomImage" :limit="1" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in room_status"
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

<script setup name="Room">
import { listRoom, getRoom, delRoom, addRoom, updateRoom } from "@/api/serve/room"
import { listFloorOptions } from "@/api/serve/floor"

const { proxy } = getCurrentInstance()

const roomList = ref([])
const floorOptions = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(false)
const total = ref(0)
const title = ref("")
const { room_status, room_type } = proxy.useDict("room_status", "room_type")

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10
  },
  rules: {
    roomNo: [{ required: true, message: "房间编号不能为空", trigger: "blur" }],
    floorId: [{ required: true, message: "请选择所属楼层", trigger: "change" }],
    roomType: [{ required: true, message: "请选择房型类型", trigger: "change" }],
    bedFee: [{ required: true, message: "请输入床位费用", trigger: "blur" }],
    roomDesc: [{ required: true, message: "请输入房间介绍", trigger: "blur" }],
    roomImage: [{ required: true, message: "请上传房间图片", trigger: "blur" }],
    status: [{ required: true, message: "请选择状态", trigger: "change" }]
  },
})

const { queryParams, form, rules } = toRefs(data)

function getStatusLabel(status) {
  const dict = room_status.value.find(item => Number(item.value) === Number(status))
  return dict ? dict.label : (Number(status) === 1 ? "启用" : "停用")
}

function getFloorLabel(floorId) {
  const floor = floorOptions.value.find(item => Number(item.id) === Number(floorId))
  if (!floor) {
    return floorId != null ? `楼层${floorId}` : "-"
  }
  return floor.floorName || `${floor.floorNo}楼`
}

function getFloorOptions() {
  return listFloorOptions().then(response => {
    floorOptions.value = response.data || []
  })
}

function getList() {
  loading.value = true
  listRoom(queryParams.value).then(response => {
    roomList.value = response.rows || []
    total.value = response.total || 0
  }).finally(() => {
    loading.value = false
  })
}

function cancel() {
  open.value = false
  reset()
}

function reset() {
  form.value = {
    id: null,
    roomNo: null,
    floorId: null,
    roomImage: null,
    bedFee: null,
    roomType: null,
    roomDesc: null,
    status: 1
  }
  proxy.resetForm("roomRef")
}

function handleAdd() {
  reset()
  if (floorOptions.value.length === 0) {
    proxy.$modal.msgWarning("请先在「楼层管理」菜单中维护楼层数据")
    return
  }
  open.value = true
  title.value = "添加房间"
}

function handleUpdate(row) {
  reset()
  getRoom(row.id).then(response => {
    form.value = response.data
    form.value.floorId = form.value.floorId != null ? Number(form.value.floorId) : null
    form.value.bedFee = form.value.bedFee != null ? Number(form.value.bedFee) : null
    form.value.roomType = form.value.roomType != null ? Number(form.value.roomType) : null
    form.value.status = form.value.status != null ? Number(form.value.status) : 1
    open.value = true
    title.value = "修改房间"
  })
}

function handleToggleStatus(row) {
  const nextStatus = row.status === 1 ? 0 : 1
  const actionText = nextStatus === 1 ? "启用" : "停用"
  proxy.$modal.confirm(`确认要${actionText}房间“${row.roomNo}”吗？`).then(() => {
    return updateRoom({
      ...row,
      status: nextStatus
    })
  }).then(() => {
    proxy.$modal.msgSuccess(`${actionText}成功`)
    getList()
  }).catch(() => {})
}

function submitForm() {
  proxy.$refs["roomRef"].validate(valid => {
    if (!valid) {
      return
    }
    const payload = {
      ...form.value,
      floorId: form.value.floorId != null ? Number(form.value.floorId) : null,
      roomType: form.value.roomType != null ? Number(form.value.roomType) : null,
      status: form.value.status != null ? Number(form.value.status) : null
    }
    const request = form.value.id != null ? updateRoom(payload) : addRoom(payload)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.id != null ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}

function handleDelete(row) {
  proxy.$modal.confirm(`是否确认删除房间“${row.roomNo}”？`).then(() => {
    return delRoom(row.id)
  }).then(() => {
    proxy.$modal.msgSuccess("删除成功")
    getList()
  }).catch(() => {})
}

getFloorOptions().finally(() => {
  getList()
})
</script>

<style scoped>
.room-preview-page :deep(.el-table .cell) {
  line-height: 18px;
}

.room-preview-page :deep(.el-table td),
.room-preview-page :deep(.el-table th) {
  padding: 8px 0;
}

.room-thumb {
  width: 48px;
  height: 48px;
  border-radius: 3px;
}
</style>
