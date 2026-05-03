<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" label-width="100px">
      <el-form-item label="老人姓名" prop="elderName">
        <el-input
          v-model="queryParams.elderName"
          placeholder="请输入老人姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="老人身份证号" prop="idCardNo">
        <el-input
          v-model="queryParams.idCardNo"
          placeholder="请输入老人身份证号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button @click="resetQuery">重置</el-button>
        <el-button type="primary" @click="handleQuery">搜索</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8" justify="start">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['serve:checkIn:add']"
        >发起入住申请</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="checkInList">
      <el-table-column
        label="序号"
        type="index"
        width="60"
        align="center"
        :index="tableIndex"
      />
      <el-table-column label="老人姓名" align="center" prop="elderName" min-width="100" />
      <el-table-column label="老人身份证号" align="center" prop="idCardNo" min-width="170" />
      <el-table-column label="入住床位" align="center" prop="bedNumber" min-width="100" />
      <el-table-column label="护理等级" align="center" prop="nursingLevelName" min-width="120" />
      <el-table-column label="入住期限" align="center" min-width="200">
        <template #default="scope">
          <span>{{ formatStayPeriod(scope.row.startDate, scope.row.endDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="170">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="90" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="handleView(scope.row)"
            v-hasPermi="['serve:checkIn:query']"
          >查看</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </div>
</template>

<script setup name="CheckIn">
import { listCheckIn } from "@/api/serve/checkIn"

const { proxy } = getCurrentInstance()
const router = useRouter()

const checkInList = ref([])
const loading = ref(true)
const total = ref(0)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    elderName: null,
    idCardNo: null,
  },
})

const { queryParams } = toRefs(data)

function tableIndex(index) {
  return (queryParams.value.pageNum - 1) * queryParams.value.pageSize + index + 1
}

function formatStayPeriod(start, end) {
  const a = proxy.parseTime(start, "{y}-{m}-{d}")
  const b = proxy.parseTime(end, "{y}-{m}-{d}")
  if (!a && !b) {
    return "—"
  }
  return `${a || "—"} ~ ${b || "—"}`
}

/** 查询入住登记列表 */
function getList() {
  loading.value = true
  const q = { ...queryParams.value }
  if (typeof q.elderName === "string") {
    q.elderName = q.elderName.trim() || null
  }
  if (typeof q.idCardNo === "string") {
    q.idCardNo = q.idCardNo.trim() || null
  }
  listCheckIn(q).then(response => {
    checkInList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

/** 新增：发起入住申请 */
function handleAdd() {
  router.push("/serve/checkIn-apply/index")
}

/** 查看：进入与申请页相同的只读页面 */
function handleView(row) {
  router.push({ name: "CheckInView", params: { id: String(row.id) } })
}

getList()
</script>
