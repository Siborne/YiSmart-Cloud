<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="被访老人ID" prop="elderId">
        <el-input
          v-model="queryParams.elderId"
          placeholder="请输入被访老人ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="访客姓名" prop="visitorName">
        <el-input
          v-model="queryParams.visitorName"
          placeholder="请输入访客姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="访客手机号" prop="visitorPhone">
        <el-input
          v-model="queryParams.visitorPhone"
          placeholder="请输入访客手机号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="预计到访时间" prop="visitTime">
        <el-date-picker clearable
          v-model="queryParams.visitTime"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择预计到访时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="来访事由" prop="visitReason">
        <el-input
          v-model="queryParams.visitReason"
          placeholder="请输入来访事由"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="审批状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择审批状态" clearable style="width: 180px">
          <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['serve:visitRecord:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:visitRecord:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:visitRecord:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:visitRecord:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch="showSearch" @update:showSearch="showSearch = $event" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="被访老人ID" align="center" prop="elderId" />
      <el-table-column label="访客姓名" align="center" prop="visitorName" />
      <el-table-column label="访客手机号" align="center" prop="visitorPhone" />
      <el-table-column label="预计到访时间" align="center" prop="visitTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.visitTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="来访事由" align="center" prop="visitReason" />
      <el-table-column label="审批状态" align="center" prop="status">
        <template #default="scope">
          <span>{{ getStatusLabel(scope.row.status) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:visitRecord:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:visitRecord:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page="queryParams.pageNum"
      :limit="queryParams.pageSize"
      @update:page="queryParams.pageNum = $event"
      @update:limit="queryParams.pageSize = $event"
      @pagination="getList"
    />

    <!-- 添加或修改访客预约记录对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="recordRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="被访老人ID" prop="elderId">
          <el-input v-model="form.elderId" placeholder="请输入被访老人ID" />
        </el-form-item>
        <el-form-item label="访客姓名" prop="visitorName">
          <el-input v-model="form.visitorName" placeholder="请输入访客姓名" />
        </el-form-item>
        <el-form-item label="访客手机号" prop="visitorPhone">
          <el-input v-model="form.visitorPhone" placeholder="请输入访客手机号" />
        </el-form-item>
        <el-form-item label="预计到访时间" prop="visitTime">
          <el-date-picker clearable
            v-model="form.visitTime"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择预计到访时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="来访事由" prop="visitReason">
          <el-input v-model="form.visitReason" placeholder="请输入来访事由" />
        </el-form-item>
        <el-form-item label="审批状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择审批状态" style="width: 100%">
            <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
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

<script setup name="Record">
import { listRecord, getRecord, delRecord, addRecord, updateRecord } from "@/api/serve/record"

const { proxy } = getCurrentInstance()

const recordList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const statusOptions = [
  { value: 0, label: "待审批" },
  { value: 1, label: "准许" },
  { value: 2, label: "拒绝" },
  { value: 3, label: "已结束" }
]

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    elderId: null,
    visitorName: null,
    visitorPhone: null,
    visitTime: null,
    visitReason: null,
    status: null,
  },
  rules: {
    elderId: [
      { required: true, message: "被访老人ID不能为空", trigger: "blur" }
    ],
    visitorName: [
      { required: true, message: "访客姓名不能为空", trigger: "blur" }
    ],
    visitorPhone: [
      { required: true, message: "访客手机号不能为空", trigger: "blur" }
    ],
    visitTime: [
      { required: true, message: "预计到访时间不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "审批状态: 0-待审批, 1-准许, 2-拒绝, 3-已结束不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询访客预约记录列表 */
function getList() {
  loading.value = true
  listRecord(queryParams.value).then(response => {
    recordList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    elderId: null,
    visitorName: null,
    visitorPhone: null,
    visitTime: null,
    visitReason: null,
    status: 0,
    createTime: null,
    updateTime: null,
    isDeleted: null
  }
  proxy.resetForm("recordRef")
}

function getStatusLabel(status) {
  const target = statusOptions.find(item => Number(item.value) === Number(status))
  return target ? target.label : `未知(${status ?? '-'})`
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

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加访客预约记录"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getRecord(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改访客预约记录"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["recordRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateRecord(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addRecord(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value
  proxy.$modal.confirm('是否确认删除访客预约记录编号为"' + _ids + '"的数据项？').then(function() {
    return delRecord(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('serve/visitRecord/export', {
    ...queryParams.value
  }, `record_${new Date().getTime()}.xlsx`)
}

getList()
</script>
