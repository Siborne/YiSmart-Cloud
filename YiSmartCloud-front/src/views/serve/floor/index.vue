<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="楼层编号" prop="floorNo">
        <el-input-number
          v-model="queryParams.floorNo"
          :min="1"
          :step="1"
          controls-position="right"
          clearable
          placeholder="楼层编号"
          style="width: 160px"
        />
      </el-form-item>
      <el-form-item label="楼层名称" prop="floorName">
        <el-input
          v-model="queryParams.floorName"
          placeholder="请输入楼层名称"
          clearable
          @keyup.enter="handleQuery"
        />
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
          v-hasPermi="['serve:floor:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:floor:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:floor:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:floor:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch="showSearch" @update:showSearch="showSearch = $event" @queryTable="getList" />
    </el-row>
    <el-table v-loading="loading" :data="floorList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="楼层编号" align="center" prop="floorNo" min-width="100" />
      <el-table-column label="楼层名称" align="center" prop="floorName" min-width="120" />
      <el-table-column label="排序" align="center" prop="sortNo" width="100" />
      <el-table-column label="状态" align="center" prop="status" width="100">
        <template #default="scope">
          <dict-tag :options="room_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.createTime, "{y}-{m}-{d} {h}:{i}:{s}") }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="160" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:floor:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:floor:remove']">删除</el-button>
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
    <el-dialog :title="title" v-model="open" width="480px" append-to-body>
      <el-form ref="floorRef" :model="form" :rules="rules" label-width="96px">
        <el-form-item label="楼层编号" prop="floorNo">
          <el-input-number v-model="form.floorNo" :min="1" :step="1" controls-position="right" style="width: 100%" />
        </el-form-item>
        <el-form-item label="楼层名称" prop="floorName">
          <el-input v-model="form.floorName" placeholder="请输入楼层名称（如：一层）" />
        </el-form-item>
        <el-form-item label="排序" prop="sortNo">
          <el-input-number v-model="form.sortNo" :min="1" :step="1" controls-position="right" style="width: 100%" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in room_status"
              :key="dict.value"
              :label="Number(dict.value)"
            >{{ dict.label }}</el-radio>
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

<script setup name="Floor">
import { listFloor, getFloor, delFloor, addFloor, updateFloor } from "@/api/serve/floor"
const { proxy } = getCurrentInstance()
const { room_status } = proxy.useDict("room_status")
const floorList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    floorNo: null,
    floorName: null
  },
  rules: {
    floorNo: [{ required: true, message: "请输入楼层编号", trigger: "blur" }],
    floorName: [{ required: true, message: "请输入楼层名称", trigger: "blur" }],
    sortNo: [{ required: true, message: "请输入排序号", trigger: "blur" }],
    status: [{ required: true, message: "请选择状态", trigger: "change" }]
  }
})
const { queryParams, form, rules } = toRefs(data)
function getList() {
  loading.value = true
  listFloor(queryParams.value).then(response => {
    floorList.value = response.rows || []
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
    floorNo: null,
    floorName: null,
    sortNo: 1,
    status: 1
  }
  proxy.resetForm("floorRef")
}
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}
function resetQuery() {
  queryParams.value.floorNo = null
  queryParams.value.floorName = null
  proxy.resetForm("queryRef")
  handleQuery()
}
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)
  single.value = selection.length !== 1
  multiple.value = !selection.length
}

function handleAdd() {
  reset()
  open.value = true
  title.value = "添加楼层"
}
function handleUpdate(row) {
  reset()
  const _id = row?.id ?? ids.value[0]
  if (_id == null) {
    proxy.$modal.msgWarning("请先选择要操作的数据")
    return
  }
  getFloor(_id).then(response => {
    form.value = response.data || {}
    form.value.floorNo = form.value.floorNo != null ? Number(form.value.floorNo) : null
    form.value.sortNo = form.value.sortNo != null ? Number(form.value.sortNo) : 1
    form.value.status = form.value.status != null ? Number(form.value.status) : 1
    open.value = true
    title.value = "修改楼层"
  })
}


function submitForm() {
  proxy.$refs["floorRef"].validate(valid => {
    if (!valid) {
      return
    }
    const payload = {
      ...form.value,
      floorNo: form.value.floorNo != null ? Number(form.value.floorNo) : null,
      sortNo: form.value.sortNo != null ? Number(form.value.sortNo) : 1,
      status: form.value.status != null ? Number(form.value.status) : 1
    }
    const request = form.value.id != null ? updateFloor(payload) : addFloor(payload)
    request.then(() => {
      proxy.$modal.msgSuccess(form.value.id != null ? "修改成功" : "新增成功")
      open.value = false
      getList()
    })
  })
}




function handleDelete(row) {
  const _ids = row?.id != null ? row.id : ids.value
  const idStr = Array.isArray(_ids) ? _ids.join(",") : String(_ids)
  if (!idStr) {
    proxy.$modal.msgWarning("请先选择要操作的数据")
    return
  }
  proxy.$modal.confirm("是否确认删除所选楼层数据？").then(() => {
    return delFloor(idStr)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}
function handleExport() {
  proxy.download("serve/floor/export", {
    ...queryParams.value
  }, `floor_${new Date().getTime()}.xlsx`)
}
getList()
</script>

