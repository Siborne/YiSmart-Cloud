<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="入住表ID" prop="checkInId">
        <el-input
          v-model="queryParams.checkInId"
          placeholder="请输入入住表ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="护理等级ID" prop="nursingLevelId">
        <el-input
          v-model="queryParams.nursingLevelId"
          placeholder="请输入护理等级ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="护理等级名称" prop="nursingLevelName">
        <el-input
          v-model="queryParams.nursingLevelName"
          placeholder="请输入护理等级名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="费用开始时间" prop="feeStartDate">
        <el-date-picker clearable
          v-model="queryParams.feeStartDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择费用开始时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="费用结束时间" prop="feeEndDate">
        <el-date-picker clearable
          v-model="queryParams.feeEndDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择费用结束时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="押金" prop="deposit">
        <el-input
          v-model="queryParams.deposit"
          placeholder="请输入押金"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="护理费用" prop="nursingFee">
        <el-input
          v-model="queryParams.nursingFee"
          placeholder="请输入护理费用"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="床位费用" prop="bedFee">
        <el-input
          v-model="queryParams.bedFee"
          placeholder="请输入床位费用"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="医保支付" prop="insurancePayment">
        <el-input
          v-model="queryParams.insurancePayment"
          placeholder="请输入医保支付"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="政府补贴" prop="governmentSubsidy">
        <el-input
          v-model="queryParams.governmentSubsidy"
          placeholder="请输入政府补贴"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="其他费用" prop="otherFees">
        <el-input
          v-model="queryParams.otherFees"
          placeholder="请输入其他费用"
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
          v-hasPermi="['serve:checkInConfig:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:checkInConfig:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:checkInConfig:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:checkInConfig:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="checkInConfigList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="入住表ID" align="center" prop="checkInId" />
      <el-table-column label="护理等级ID" align="center" prop="nursingLevelId" />
      <el-table-column label="护理等级名称" align="center" prop="nursingLevelName" />
      <el-table-column label="费用开始时间" align="center" prop="feeStartDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.feeStartDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="费用结束时间" align="center" prop="feeEndDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.feeEndDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="押金" align="center" prop="deposit" />
      <el-table-column label="护理费用" align="center" prop="nursingFee" />
      <el-table-column label="床位费用" align="center" prop="bedFee" />
      <el-table-column label="医保支付" align="center" prop="insurancePayment" />
      <el-table-column label="政府补贴" align="center" prop="governmentSubsidy" />
      <el-table-column label="其他费用" align="center" prop="otherFees" />
      <el-table-column label="排序编号" align="center" prop="sortOrder" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:checkInConfig:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:checkInConfig:remove']">删除</el-button>
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

    <!-- 添加或修改入住配置对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="checkInConfigRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="入住表ID" prop="checkInId">
          <el-input v-model="form.checkInId" placeholder="请输入入住表ID" />
        </el-form-item>
        <el-form-item label="护理等级ID" prop="nursingLevelId">
          <el-input v-model="form.nursingLevelId" placeholder="请输入护理等级ID" />
        </el-form-item>
        <el-form-item label="护理等级名称" prop="nursingLevelName">
          <el-input v-model="form.nursingLevelName" placeholder="请输入护理等级名称" />
        </el-form-item>
        <el-form-item label="费用开始时间" prop="feeStartDate">
          <el-date-picker clearable
            v-model="form.feeStartDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择费用开始时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="费用结束时间" prop="feeEndDate">
          <el-date-picker clearable
            v-model="form.feeEndDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择费用结束时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="押金" prop="deposit">
          <el-input v-model="form.deposit" placeholder="请输入押金" />
        </el-form-item>
        <el-form-item label="护理费用" prop="nursingFee">
          <el-input v-model="form.nursingFee" placeholder="请输入护理费用" />
        </el-form-item>
        <el-form-item label="床位费用" prop="bedFee">
          <el-input v-model="form.bedFee" placeholder="请输入床位费用" />
        </el-form-item>
        <el-form-item label="医保支付" prop="insurancePayment">
          <el-input v-model="form.insurancePayment" placeholder="请输入医保支付" />
        </el-form-item>
        <el-form-item label="政府补贴" prop="governmentSubsidy">
          <el-input v-model="form.governmentSubsidy" placeholder="请输入政府补贴" />
        </el-form-item>
        <el-form-item label="其他费用" prop="otherFees">
          <el-input v-model="form.otherFees" placeholder="请输入其他费用" />
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

<script setup name="CheckInConfig">
import { listCheckInConfig, getCheckInConfig, delCheckInConfig, addCheckInConfig, updateCheckInConfig } from "@/api/serve/checkInConfig"

const { proxy } = getCurrentInstance()

const checkInConfigList = ref([])
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
    checkInId: null,
    nursingLevelId: null,
    nursingLevelName: null,
    feeStartDate: null,
    feeEndDate: null,
    deposit: null,
    nursingFee: null,
    bedFee: null,
    insurancePayment: null,
    governmentSubsidy: null,
    otherFees: null,
    sortOrder: null,
  },
  rules: {
    checkInId: [
      { required: true, message: "入住表ID不能为空", trigger: "blur" }
    ],
    nursingLevelId: [
      { required: true, message: "护理等级ID不能为空", trigger: "blur" }
    ],
    nursingLevelName: [
      { required: true, message: "护理等级名称不能为空", trigger: "blur" }
    ],
    feeStartDate: [
      { required: true, message: "费用开始时间不能为空", trigger: "blur" }
    ],
    deposit: [
      { required: true, message: "押金不能为空", trigger: "blur" }
    ],
    nursingFee: [
      { required: true, message: "护理费用不能为空", trigger: "blur" }
    ],
    bedFee: [
      { required: true, message: "床位费用不能为空", trigger: "blur" }
    ],
    insurancePayment: [
      { required: true, message: "医保支付不能为空", trigger: "blur" }
    ],
    governmentSubsidy: [
      { required: true, message: "政府补贴不能为空", trigger: "blur" }
    ],
    otherFees: [
      { required: true, message: "其他费用不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询入住配置列表 */
function getList() {
  loading.value = true
  listCheckInConfig(queryParams.value).then(response => {
    checkInConfigList.value = response.rows
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
    checkInId: null,
    nursingLevelId: null,
    nursingLevelName: null,
    feeStartDate: null,
    feeEndDate: null,
    deposit: null,
    nursingFee: null,
    bedFee: null,
    insurancePayment: null,
    governmentSubsidy: null,
    otherFees: null,
    sortOrder: null,
    createTime: null,
    updateTime: null,
    createBy: null,
    updateBy: null,
    remark: null
  }
  proxy.resetForm("checkInConfigRef")
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
  title.value = "添加入住配置"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getCheckInConfig(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改入住配置"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["checkInConfigRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateCheckInConfig(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addCheckInConfig(form.value).then(response => {
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
  proxy.$modal.confirm('是否确认删除入住配置编号为"' + _ids + '"的数据项？').then(function() {
    return delCheckInConfig(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('serve/checkInConfig/export', {
    ...queryParams.value
  }, `checkInConfig_${new Date().getTime()}.xlsx`)
}

getList()
</script>
