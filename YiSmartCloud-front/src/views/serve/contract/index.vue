<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="老人ID" prop="elderId">
        <el-input
          v-model="queryParams.elderId"
          placeholder="请输入老人ID"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="合同名称" prop="contractName">
        <el-input
          v-model="queryParams.contractName"
          placeholder="请输入合同名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="合同编号" prop="contractNumber">
        <el-input
          v-model="queryParams.contractNumber"
          placeholder="请输入合同编号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="协议地址" prop="agreementPath">
        <el-input
          v-model="queryParams.agreementPath"
          placeholder="请输入协议地址"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="丙方手机号" prop="thirdPartyPhone">
        <el-input
          v-model="queryParams.thirdPartyPhone"
          placeholder="请输入丙方手机号"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="丙方姓名" prop="thirdPartyName">
        <el-input
          v-model="queryParams.thirdPartyName"
          placeholder="请输入丙方姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="老人姓名" prop="elderName">
        <el-input
          v-model="queryParams.elderName"
          placeholder="请输入老人姓名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="开始时间" prop="startDate">
        <el-date-picker clearable
          v-model="queryParams.startDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择开始时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="结束时间" prop="endDate">
        <el-date-picker clearable
          v-model="queryParams.endDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择结束时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="签约日期" prop="signDate">
        <el-date-picker clearable
          v-model="queryParams.signDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择签约日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="解除提交人" prop="terminationSubmitter">
        <el-input
          v-model="queryParams.terminationSubmitter"
          placeholder="请输入解除提交人"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="解除日期" prop="terminationDate">
        <el-date-picker clearable
          v-model="queryParams.terminationDate"
          type="datetime"
          value-format="YYYY-MM-DD HH:mm:ss"
          placeholder="请选择解除日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="解除协议地址" prop="terminationAgreementPath">
        <el-input
          v-model="queryParams.terminationAgreementPath"
          placeholder="请输入解除协议地址"
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
          v-hasPermi="['serve:contract:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:contract:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:contract:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:contract:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="contractList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="老人ID" align="center" prop="elderId" />
      <el-table-column label="合同名称" align="center" prop="contractName" />
      <el-table-column label="合同编号" align="center" prop="contractNumber" />
      <el-table-column label="协议地址" align="center" prop="agreementPath" />
      <el-table-column label="丙方手机号" align="center" prop="thirdPartyPhone" />
      <el-table-column label="丙方姓名" align="center" prop="thirdPartyName" />
      <el-table-column label="老人姓名" align="center" prop="elderName" />
      <el-table-column label="开始时间" align="center" prop="startDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.startDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="结束时间" align="center" prop="endDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.endDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态 (0: 未生效, 1: 已生效, 2: 已过期, 3: 已失效)" align="center" prop="status" />
      <el-table-column label="签约日期" align="center" prop="signDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.signDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="解除提交人" align="center" prop="terminationSubmitter" />
      <el-table-column label="解除日期" align="center" prop="terminationDate" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.terminationDate, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="解除协议地址" align="center" prop="terminationAgreementPath" />
      <el-table-column label="排序编号" align="center" prop="sortOrder" />
      <el-table-column label="备注" align="center" prop="remark" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:contract:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:contract:remove']">删除</el-button>
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

    <!-- 添加或修改合同对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="contractRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="老人ID" prop="elderId">
          <el-input v-model="form.elderId" placeholder="请输入老人ID" />
        </el-form-item>
        <el-form-item label="合同名称" prop="contractName">
          <el-input v-model="form.contractName" placeholder="请输入合同名称" />
        </el-form-item>
        <el-form-item label="合同编号" prop="contractNumber">
          <el-input v-model="form.contractNumber" placeholder="请输入合同编号" />
        </el-form-item>
        <el-form-item label="协议地址" prop="agreementPath">
          <el-input v-model="form.agreementPath" placeholder="请输入协议地址" />
        </el-form-item>
        <el-form-item label="丙方手机号" prop="thirdPartyPhone">
          <el-input v-model="form.thirdPartyPhone" placeholder="请输入丙方手机号" />
        </el-form-item>
        <el-form-item label="丙方姓名" prop="thirdPartyName">
          <el-input v-model="form.thirdPartyName" placeholder="请输入丙方姓名" />
        </el-form-item>
        <el-form-item label="老人姓名" prop="elderName">
          <el-input v-model="form.elderName" placeholder="请输入老人姓名" />
        </el-form-item>
        <el-form-item label="开始时间" prop="startDate">
          <el-date-picker clearable
            v-model="form.startDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择开始时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="结束时间" prop="endDate">
          <el-date-picker clearable
            v-model="form.endDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择结束时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="签约日期" prop="signDate">
          <el-date-picker clearable
            v-model="form.signDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择签约日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="解除提交人" prop="terminationSubmitter">
          <el-input v-model="form.terminationSubmitter" placeholder="请输入解除提交人" />
        </el-form-item>
        <el-form-item label="解除日期" prop="terminationDate">
          <el-date-picker clearable
            v-model="form.terminationDate"
            type="datetime"
            value-format="YYYY-MM-DD HH:mm:ss"
            placeholder="请选择解除日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="解除协议地址" prop="terminationAgreementPath">
          <el-input v-model="form.terminationAgreementPath" placeholder="请输入解除协议地址" />
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

<script setup name="Contract">
import { listContract, getContract, delContract, addContract, updateContract } from "@/api/serve/contract"

const { proxy } = getCurrentInstance()

const contractList = ref([])
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
    elderId: null,
    contractName: null,
    contractNumber: null,
    agreementPath: null,
    thirdPartyPhone: null,
    thirdPartyName: null,
    elderName: null,
    startDate: null,
    endDate: null,
    status: null,
    signDate: null,
    terminationSubmitter: null,
    terminationDate: null,
    terminationAgreementPath: null,
    sortOrder: null,
  },
  rules: {
    elderId: [
      { required: true, message: "老人ID不能为空", trigger: "blur" }
    ],
    contractName: [
      { required: true, message: "合同名称不能为空", trigger: "blur" }
    ],
    contractNumber: [
      { required: true, message: "合同编号不能为空", trigger: "blur" }
    ],
    agreementPath: [
      { required: true, message: "协议地址不能为空", trigger: "blur" }
    ],
    thirdPartyPhone: [
      { required: true, message: "丙方手机号不能为空", trigger: "blur" }
    ],
    thirdPartyName: [
      { required: true, message: "丙方姓名不能为空", trigger: "blur" }
    ],
    elderName: [
      { required: true, message: "老人姓名不能为空", trigger: "blur" }
    ],
    startDate: [
      { required: true, message: "开始时间不能为空", trigger: "blur" }
    ],
    endDate: [
      { required: true, message: "结束时间不能为空", trigger: "blur" }
    ],
    status: [
      { required: true, message: "状态 (0: 未生效, 1: 已生效, 2: 已过期, 3: 已失效)不能为空", trigger: "change" }
    ],
    signDate: [
      { required: true, message: "签约日期不能为空", trigger: "blur" }
    ],
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询合同列表 */
function getList() {
  loading.value = true
  listContract(queryParams.value).then(response => {
    contractList.value = response.rows
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
    contractName: null,
    contractNumber: null,
    agreementPath: null,
    thirdPartyPhone: null,
    thirdPartyName: null,
    elderName: null,
    startDate: null,
    endDate: null,
    status: null,
    signDate: null,
    terminationSubmitter: null,
    terminationDate: null,
    terminationAgreementPath: null,
    sortOrder: null,
    createTime: null,
    updateTime: null,
    createBy: null,
    updateBy: null,
    remark: null
  }
  proxy.resetForm("contractRef")
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
  title.value = "添加合同"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _id = row.id || ids.value
  getContract(_id).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改合同"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["contractRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updateContract(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addContract(form.value).then(response => {
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
  proxy.$modal.confirm('是否确认删除合同编号为"' + _ids + '"的数据项？').then(function() {
    return delContract(_ids)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('serve/contract/export', {
    ...queryParams.value
  }, `contract_${new Date().getTime()}.xlsx`)
}

getList()
</script>
