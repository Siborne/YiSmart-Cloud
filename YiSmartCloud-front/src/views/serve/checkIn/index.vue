<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="老人姓名" prop="elderName">
        <el-input
          v-model="queryParams.elderName"
          placeholder="请输入老人姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="老人ID" prop="elderId">
        <el-input
          v-model="queryParams.elderId"
          placeholder="请输入老人ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="身份证号" prop="idCardNo">
        <el-input
          v-model="queryParams.idCardNo"
          placeholder="请输入身份证号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入住开始时间" prop="startDate">
        <el-date-picker clearable
          v-model="queryParams.startDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择入住开始时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="入住结束时间" prop="endDate">
        <el-date-picker clearable
          v-model="queryParams.endDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择入住结束时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="护理等级名称" prop="nursingLevelName">
        <el-input
          v-model="queryParams.nursingLevelName"
          placeholder="请输入护理等级名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="入住床位" prop="bedNumber">
        <el-input
          v-model="queryParams.bedNumber"
          placeholder="请输入入住床位"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="排序编号" prop="sortOrder">
        <el-input
          v-model="queryParams.sortOrder"
          placeholder="请输入排序编号"
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
          v-hasPermi="['serve:checkIn:add']"
        >发起入住申请</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:checkIn:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:checkIn:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:checkIn:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="checkInList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="老人姓名" align="center" prop="elderName" />
      <el-table-column label="老人ID" align="center" prop="elderId" />
      <el-table-column label="身份证号" align="center" prop="idCardNo" />
      <el-table-column label="入住开始时间" align="center" prop="startDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="入住结束时间" align="center" prop="endDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="护理等级名称" align="center" prop="nursingLevelName" />
      <el-table-column label="入住床位" align="center" prop="bedNumber" />
      <el-table-column label="状态 (0: 已入住, 1: 已退住)" align="center" prop="status" />
      <el-table-column label="排序编号" align="center" prop="sortOrder" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:checkIn:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:checkIn:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改入住登记对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="checkInRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="老人姓名" prop="elderName">
          <el-input v-model="form.elderName" placeholder="请输入老人姓名" />
        </el-form-item>
        <el-form-item label="老人ID" prop="elderId">
          <el-input v-model="form.elderId" placeholder="请输入老人ID" />
        </el-form-item>
        <el-form-item label="身份证号" prop="idCardNo">
          <el-input v-model="form.idCardNo" placeholder="请输入身份证号" />
        </el-form-item>
        <el-form-item label="入住开始时间" prop="startDate">
          <el-date-picker clearable
            v-model="form.startDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择入住开始时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="入住结束时间" prop="endDate">
          <el-date-picker clearable
            v-model="form.endDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择入住结束时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="护理等级名称" prop="nursingLevelName">
          <el-input v-model="form.nursingLevelName" placeholder="请输入护理等级名称" />
        </el-form-item>
        <el-form-item label="入住床位" prop="bedNumber">
          <el-input v-model="form.bedNumber" placeholder="请输入入住床位" />
        </el-form-item>
        <el-form-item label="排序编号" prop="sortOrder">
          <el-input v-model="form.sortOrder" placeholder="请输入排序编号" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" placeholder="请输入备注" />
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

<script setup name="CheckIn">
import { listCheckIn, getCheckIn, delCheckIn, addCheckIn, updateCheckIn } from "@/api/serve/checkIn"

const { proxy } = getCurrentInstance()
const router = useRouter()

const checkInList = ref([])
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
    elderName: null,
    elderId: null,
    idCardNo: null,
    startDate: null,
    endDate: null,
    nursingLevelName: null,
    bedNumber: null,
    status: null,
    sortOrder: null,
  },
  rules: {
    elderName: [
      { required: true, message: "老人姓名不能为空", trigger: "blur" }
    ],
    elderId: [
      { required: true, message: "老人ID不能为空", trigger: "blur" }
    ],
    idCardNo: [
      { required: true, message: "身份证号不能为空", trigger: "blur" }
    ],
    startDate: [
      { required: true, message: "入住开始时间不能为空", trigger: "blur" }
    ],
    nursingLevelName: [
      { required: true, message: "护理等级名称不能为空", trigger: "blur" }
    ],
    bedNumber: [
      { required: true, message: "入住床位不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "状态 (0: 已入住, 1: 已退住)不能为空", trigger: "change" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询入住登记列表 */
function getList() {
  loading.value = true
  listCheckIn(queryParams.value).then(response => {
    checkInList.value = response.rows
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
    elderName: null,
    elderId: null,
    idCardNo: null,
    startDate: null,
    endDate: null,
    nursingLevelName: null,
    bedNumber: null,
    status: null,
    sortOrder: null,
    createTime: null,
    updateTime: null,
    createBy: null,
    updateBy: null,
    remark: null
  }
  proxy.resetForm("checkInRef")
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
  router.push("/serve/checkIn-apply/index")
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getCheckIn(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改入住登记"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["checkInRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateCheckIn(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addCheckIn(form.value).then(response => {
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
  proxy.$modal.confirm('是否确认删除入住登记编号为"' + _ids + '"的数据项？').then(function() {
    return delCheckIn(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('serve/checkIn/export', {
    ...queryParams.value
  }, `checkIn_${new Date().getTime()}.xlsx`)
}

getList()
</script>
