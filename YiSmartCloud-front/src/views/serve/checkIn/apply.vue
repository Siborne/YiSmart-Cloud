<template>
  <div class="app-container apply-container">
    <el-form ref="checkInApplyRef" :model="form" :rules="rules" label-width="110px">
      <section class="section-card">
        <div class="section-title"><span class="num">1</span> 基本信息</div>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="老人姓名" prop="elder.name">
              <el-input v-model="form.elder.name" placeholder="请输入" maxlength="10" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="身份证号" prop="elder.idCardNo">
              <el-input v-model="form.elder.idCardNo" placeholder="请输入" maxlength="18" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="出生日期">
              <el-date-picker
                v-model="form.elder.birthday"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="出生日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="年龄">
              <el-input-number v-model="form.elder.age" :min="0" :max="130" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="性别">
              <el-radio-group v-model="form.elder.gender">
                <el-radio label="男">男</el-radio>
                <el-radio label="女">女</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="联系方式">
              <el-input v-model="form.elder.phone" placeholder="请输入" maxlength="11" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="家庭住址">
              <el-input
                v-model="form.elder.address"
                type="textarea"
                :rows="8"
                placeholder="请输入"
                maxlength="100"
                show-word-limit
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="一寸照片">
              <image-upload v-model="form.elder.image" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="身份证人像面">
              <image-upload v-model="form.elder.idCardPortraitImg" :limit="1" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="身份证国徽面">
              <image-upload v-model="form.elder.idCardNationalEmblemImg" :limit="1" />
            </el-form-item>
          </el-col>
        </el-row>
      </section>

      <section class="section-card">
        <div class="section-title"><span class="num">2</span> 家属信息</div>
        <el-table :data="form.families" border>
          <el-table-column label="家属姓名" min-width="180">
            <template #default="{ row }">
              <el-input v-model="row.name" placeholder="请输入" maxlength="10" show-word-limit />
            </template>
          </el-table-column>
          <el-table-column label="家属联系方式" min-width="210">
            <template #default="{ row }">
              <el-input v-model="row.phone" placeholder="请输入" maxlength="11" show-word-limit />
            </template>
          </el-table-column>
          <el-table-column label="与老人关系" min-width="170">
            <template #default="{ row }">
              <el-select v-model="row.relation" placeholder="请选择">
                <el-option v-for="item in relationOptions" :key="item" :label="item" :value="item" />
              </el-select>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="110" align="center">
            <template #default="{ $index }">
              <el-button link type="primary" icon="Plus" @click="addFamilyRow" />
              <el-button link type="danger" icon="Delete" @click="removeFamilyRow($index)" :disabled="form.families.length === 1" />
            </template>
          </el-table-column>
        </el-table>
      </section>

      <section class="section-card">
        <div class="section-title"><span class="num">3</span> 入住配置</div>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="入住期限" prop="config.startDate">
              <el-date-picker
                v-model="configDateRange"
                type="daterange"
                value-format="YYYY-MM-DD"
                range-separator="至"
                start-placeholder="请选择开始日期"
                end-placeholder="请选择结束日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="费用期限">
              <el-date-picker
                v-model="feeDateRange"
                type="daterange"
                value-format="YYYY-MM-DD"
                range-separator="至"
                start-placeholder="请选择开始日期"
                end-placeholder="请选择结束日期"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="护理等级" prop="config.nursingLevelName">
              <el-select
                v-model="form.config.nursingLevelName"
                placeholder="请选择护理等级"
                clearable
                filterable
                style="width: 100%"
              >
                <el-option
                  v-for="item in nursingLevelOptions"
                  :key="item.id"
                  :label="item.name"
                  :value="item.name"
                />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="入住床位" prop="config.bedNumber">
              <el-cascader
                v-model="selectedBedPath"
                :options="bedOptions"
                placeholder="请选择入住床位"
                clearable
                filterable
                :show-all-levels="false"
                style="width: 100%"
                @change="handleBedChange"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="押金">
              <div class="fee-item">
                <span class="symbol plus">+</span>
                <el-input-number v-model="form.config.deposit" :precision="2" :min="0" :step="100" />
                <span class="unit">元</span>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="护理费用">
              <div class="fee-item">
                <span class="symbol plus">+</span>
                <el-input-number v-model="form.config.nursingFee" :precision="2" :min="0" />
                <span class="unit">元/月</span>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="床位费用">
              <div class="fee-item">
                <span class="symbol plus">+</span>
                <el-input-number v-model="form.config.bedFee" :precision="2" :min="0" />
                <span class="unit">元/月</span>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="其他费用">
              <div class="fee-item">
                <span class="symbol plus">+</span>
                <el-input-number v-model="form.config.otherFees" :precision="2" :min="0" />
                <span class="unit">元/月</span>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="医保费用">
              <div class="fee-item">
                <span class="symbol minus">-</span>
                <el-input-number v-model="form.config.insurancePayment" :precision="2" :min="0" />
                <span class="unit">元/月</span>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="政府补贴">
              <div class="fee-item">
                <span class="symbol minus">-</span>
                <el-input-number v-model="form.config.governmentSubsidy" :precision="2" :min="0" />
                <span class="unit">元/月</span>
              </div>
            </el-form-item>
          </el-col>
        </el-row>
      </section>

      <section class="section-card">
        <div class="section-title"><span class="num">4</span> 签约办理</div>
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="合同名称">
              <el-input v-model="form.contract.contractName" placeholder="请输入" maxlength="20" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="签约日期">
              <el-date-picker
                v-model="form.contract.signDate"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择"
                style="width: 100%"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="丙方姓名">
              <el-input v-model="form.contract.thirdPartyName" placeholder="请输入" maxlength="10" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="丙方联系方式">
              <el-input v-model="form.contract.thirdPartyPhone" placeholder="请输入" maxlength="11" show-word-limit />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="入住合同">
              <file-upload v-model="form.contract.agreementPath" :limit="1" />
            </el-form-item>
          </el-col>
        </el-row>
      </section>
    </el-form>

    <div class="footer-actions">
      <el-button @click="goBack">返回</el-button>
      <el-button type="primary" :loading="submitting" @click="submitForm">提交</el-button>
      <el-button type="primary" plain @click="openFeePreview">费用预览</el-button>
    </div>

    <el-dialog title="费用预览" v-model="feePreviewOpen" width="460px" append-to-body>
      <div class="fee-preview-row"><span>押金：</span><span>{{ formatMoney(form.config.deposit) }} 元</span></div>
      <div class="fee-preview-row"><span>护理费用：</span><span>{{ formatMoney(form.config.nursingFee) }} 元/月</span></div>
      <div class="fee-preview-row"><span>床位费用：</span><span>{{ formatMoney(form.config.bedFee) }} 元/月</span></div>
      <div class="fee-preview-row"><span>其他费用：</span><span>{{ formatMoney(form.config.otherFees) }} 元/月</span></div>
      <div class="fee-preview-row"><span>医保费用：</span><span>- {{ formatMoney(form.config.insurancePayment) }} 元/月</span></div>
      <div class="fee-preview-row"><span>政府补贴：</span><span>- {{ formatMoney(form.config.governmentSubsidy) }} 元/月</span></div>
      <div class="fee-preview-row total"><span>月度应收：</span><span>{{ formatMoney(monthlyTotalFee) }} 元/月</span></div>
    </el-dialog>
  </div>
</template>

<script setup name="CheckInApply">
import { addCheckIn } from "@/api/serve/checkIn"
import { listAllLevel } from "@/api/serve/level"
import { getRoomAndBedByBedStatus } from "@/api/serve/floor"

const { proxy } = getCurrentInstance()
const router = useRouter()
const checkInApplyRef = ref()
const submitting = ref(false)
const feePreviewOpen = ref(false)
const nursingLevelOptions = ref([])
const bedOptions = ref([])
const selectedBedPath = ref([])

const relationOptions = ["子女", "配偶", "亲属", "朋友", "监护人", "其他"]

function createFamilyRow() {
  return {
    name: "",
    phone: "",
    relation: "",
  }
}

const form = reactive({
  elder: {
    name: "",
    idCardNo: "",
    birthday: "",
    age: null,
    gender: "男",
    phone: "",
    address: "",
    image: "",
    idCardPortraitImg: "",
    idCardNationalEmblemImg: "",
  },
  families: [createFamilyRow()],
  config: {
    startDate: "",
    endDate: "",
    feeStartDate: "",
    feeEndDate: "",
    nursingLevelName: "",
    bedNumber: "",
    deposit: 3000,
    nursingFee: 0,
    bedFee: 0,
    otherFees: 0,
    insurancePayment: 0,
    governmentSubsidy: 0,
  },
  contract: {
    contractName: "",
    signDate: "",
    thirdPartyName: "",
    thirdPartyPhone: "",
    agreementPath: "",
  },
  remark: "",
})

const configDateRange = computed({
  get() {
    if (!form.config.startDate || !form.config.endDate) {
      return []
    }
    return [form.config.startDate, form.config.endDate]
  },
  set(val) {
    form.config.startDate = val?.[0] || ""
    form.config.endDate = val?.[1] || ""
  },
})

const feeDateRange = computed({
  get() {
    if (!form.config.feeStartDate || !form.config.feeEndDate) {
      return []
    }
    return [form.config.feeStartDate, form.config.feeEndDate]
  },
  set(val) {
    form.config.feeStartDate = val?.[0] || ""
    form.config.feeEndDate = val?.[1] || ""
  },
})

const rules = {
  "elder.name": [{ required: true, message: "老人姓名不能为空", trigger: "blur" }],
  "elder.idCardNo": [{ required: true, message: "身份证号不能为空", trigger: "blur" }],
  "config.startDate": [{ required: true, message: "请选择入住期限", trigger: "change" }],
  "config.nursingLevelName": [{ required: true, message: "护理等级不能为空", trigger: "change" }],
  "config.bedNumber": [{ required: true, message: "入住床位不能为空", trigger: "change" }],
}

const monthlyTotalFee = computed(() => {
  return (
    toNumber(form.config.nursingFee) +
    toNumber(form.config.bedFee) +
    toNumber(form.config.otherFees) -
    toNumber(form.config.insurancePayment) -
    toNumber(form.config.governmentSubsidy)
  )
})

function toNumber(value) {
  return Number(value || 0)
}

function formatMoney(value) {
  return toNumber(value).toFixed(2)
}

function addFamilyRow() {
  form.families.push(createFamilyRow())
}

function removeFamilyRow(index) {
  if (form.families.length === 1) {
    return
  }
  form.families.splice(index, 1)
}

function openFeePreview() {
  feePreviewOpen.value = true
}

function goBack() {
  router.push("/serve/checkIn")
}

function loadNursingLevelOptions() {
  listAllLevel()
    .then((response) => {
      nursingLevelOptions.value = response.data || []
    })
    .catch(() => {
      nursingLevelOptions.value = []
    })
}

function loadBedOptions() {
  getRoomAndBedByBedStatus(0)
    .then((response) => {
      bedOptions.value = response.data || []
    })
    .catch(() => {
      bedOptions.value = []
    })
}

function findOptionPathByValues(options, values) {
  const path = []
  let currentOptions = options
  for (const value of values) {
    const matched = (currentOptions || []).find((item) => item.value === value)
    if (!matched) {
      return []
    }
    path.push(matched)
    currentOptions = matched.children
  }
  return path
}

function handleBedChange(values) {
  if (!values || !values.length) {
    form.config.bedNumber = ""
    return
  }
  const optionPath = findOptionPathByValues(bedOptions.value, values)
  form.config.bedNumber = optionPath[optionPath.length - 1]?.label || ""
}

function submitForm() {
  checkInApplyRef.value.validate((valid) => {
    if (!valid) {
      return
    }
    const payload = {
      elderName: form.elder.name,
      idCardNo: form.elder.idCardNo,
      startDate: `${form.config.startDate} 00:00:00`,
      endDate: form.config.endDate ? `${form.config.endDate} 23:59:59` : null,
      nursingLevelName: form.config.nursingLevelName,
      bedNumber: form.config.bedNumber,
      status: 0,
      sortOrder: 0,
      remark: form.remark,
    }
    submitting.value = true
    addCheckIn(payload)
      .then(() => {
        proxy.$modal.msgSuccess("申请提交成功")
        goBack()
      })
      .finally(() => {
        submitting.value = false
      })
  })
}

onMounted(() => {
  loadNursingLevelOptions()
  loadBedOptions()
})
</script>

<style scoped>
.apply-container {
  background: #f5f7fa;
  padding-bottom: 70px;
}

.section-card {
  margin-bottom: 16px;
  padding: 16px 18px 8px;
  background: #fff;
  border: 1px solid #ebeef5;
  border-radius: 4px;
}

.section-title {
  display: flex;
  align-items: center;
  margin-bottom: 14px;
  color: #303133;
  font-weight: 600;
  font-size: 15px;
}

.section-title .num {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 20px;
  height: 20px;
  margin-right: 8px;
  color: #fff;
  font-size: 12px;
  border-radius: 50%;
  background: #f56c6c;
}

.fee-item {
  display: inline-flex;
  align-items: center;
  width: 100%;
}

.fee-item :deep(.el-input-number) {
  flex: 1;
}

.symbol {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  margin-right: 4px;
  font-size: 18px;
  font-weight: 700;
}

.symbol.plus {
  color: #67c23a;
}

.symbol.minus {
  color: #f56c6c;
}

.unit {
  margin-left: 8px;
  color: #606266;
  white-space: nowrap;
}

.footer-actions {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 11;
  display: flex;
  justify-content: center;
  gap: 12px;
  padding: 14px 0;
  background: #fff;
  border-top: 1px solid #ebeef5;
}

.fee-preview-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
  color: #606266;
}

.fee-preview-row.total {
  margin-top: 14px;
  margin-bottom: 0;
  padding-top: 10px;
  color: #303133;
  font-weight: 700;
  border-top: 1px dashed #dcdfe6;
}
</style>
