<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="80px">
      <el-form-item label="老人姓名" prop="elderName">
        <el-input
          v-model="queryParams.elderName"
          placeholder="请输入老人姓名"
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
          icon="Plus"
          @click="openUploadDialog"
          v-hasPermi="['serve:assessment:add']"
        >+ 上传体检报告</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="assessmentList">
      <el-table-column type="index" label="序号" width="60" align="center" :index="indexMethod" />
      <el-table-column label="老人姓名" align="center" prop="elderName" min-width="100" />
      <el-table-column label="总检日期" align="center" prop="totalCheckDate" min-width="120" />
      <el-table-column label="评估时间" align="center" prop="assessmentTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.assessmentTime, '{y}-{m}-{d} {h}:{i}:{s}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="100" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="View" @click="goDetail(scope.row.id)" v-hasPermi="['serve:assessment:query']">查看</el-button>
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

    <el-dialog title="上传体检报告" v-model="uploadOpen" width="520px" append-to-body @close="resetUploadForm">
      <el-form ref="uploadRef" :model="uploadForm" :rules="uploadRules" label-width="120px">
        <el-form-item label="老人姓名" prop="elderName">
          <el-input v-model="uploadForm.elderName" placeholder="请输入老人姓名" maxlength="32" show-word-limit />
        </el-form-item>
        <el-form-item label="老人身份证号" prop="idCard">
          <el-input v-model="uploadForm.idCard" placeholder="18位身份证号" maxlength="18" show-word-limit />
        </el-form-item>
        <el-form-item label="体检单位" prop="physicalExamInstitution">
          <el-input v-model="uploadForm.physicalExamInstitution" placeholder="请输入体检单位" maxlength="64" show-word-limit />
        </el-form-item>
        <el-form-item label="体检报告" prop="physicalReportUrl">
          <el-upload
            :http-request="handlePdfUpload"
            :show-file-list="true"
            :limit="1"
            accept=".pdf,application/pdf"
            :before-upload="beforePdfUpload"
            :on-remove="handleUploadRemove"
          >
            <el-button type="primary">点击上传</el-button>
            <template #tip>
              <div class="el-upload__tip">请上传 pdf 文件，大小在 60M 以内；选择文件后将自动上传。</div>
            </template>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" :loading="analyzeLoading" @click="submitAnalyze">确 定</el-button>
          <el-button @click="uploadOpen = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Assessment">
import { listAssessment, uploadAssessmentReport, analyzeAssessment } from '@/api/serve/assessment'

const { proxy } = getCurrentInstance()
const router = useRouter()

const assessmentList = ref([])
const uploadOpen = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const total = ref(0)
const analyzeLoading = ref(false)

const data = reactive({
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    elderName: null
  },
  uploadForm: {
    elderName: '',
    idCard: '',
    physicalExamInstitution: '',
    physicalReportUrl: ''
  },
  uploadRules: {
    elderName: [{ required: true, message: '老人姓名不能为空', trigger: 'blur' }],
    idCard: [
      { required: true, message: '身份证号不能为空', trigger: 'blur' },
      { pattern: /^[1-9]\d{16}[\dXx]$/i, message: '请输入18位合法身份证号', trigger: 'blur' }
    ],
    physicalExamInstitution: [{ required: true, message: '体检单位不能为空', trigger: 'blur' }],
    physicalReportUrl: [{ required: true, message: '请先上传 PDF 报告', trigger: 'change' }]
  }
})

const { queryParams, uploadForm, uploadRules } = toRefs(data)

function indexMethod(index) {
  return (queryParams.value.pageNum - 1) * queryParams.value.pageSize + index + 1
}

function getList() {
  loading.value = true
  listAssessment(queryParams.value).then(response => {
    assessmentList.value = response.rows
    total.value = response.total
    loading.value = false
  }).catch(() => {
    loading.value = false
  })
}

function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

function resetQuery() {
  proxy.resetForm('queryRef')
  handleQuery()
}

function openUploadDialog() {
  resetUploadForm()
  uploadOpen.value = true
}

function resetUploadForm() {
  uploadForm.value = {
    elderName: '',
    idCard: '',
    physicalExamInstitution: '',
    physicalReportUrl: ''
  }
  nextTick(() => proxy.resetForm('uploadRef'))
}

const MAX_PDF_BYTES = 60 * 1024 * 1024

function beforePdfUpload(file) {
  const isPdf = file.type === 'application/pdf' || (file.name && file.name.toLowerCase().endsWith('.pdf'))
  if (!isPdf) {
    proxy.$modal.msgError('仅支持上传 PDF 文件')
    return false
  }
  if (file.size > MAX_PDF_BYTES) {
    proxy.$modal.msgError('文件大小不能超过 60MB')
    return false
  }
  if (!uploadForm.value.idCard || uploadForm.value.idCard.length !== 18) {
    proxy.$modal.msgWarning('请先填写完整、正确的18位身份证号后再选择文件')
    return false
  }
  return true
}

function handlePdfUpload(options) {
  const formData = new FormData()
  formData.append('file', options.file)
  formData.append('idCardNo', uploadForm.value.idCard.trim())
  return uploadAssessmentReport(formData).then(res => {
    const url = res.url || res.fileName
    if (url) {
      uploadForm.value.physicalReportUrl = url
      proxy.$modal.msgSuccess('上传成功')
      nextTick(() => {
        proxy.$refs.uploadRef?.validateField('physicalReportUrl')
      })
    }
    options.onSuccess(res)
  }).catch(err => {
    options.onError(err)
  })
}

function handleUploadRemove() {
  uploadForm.value.physicalReportUrl = ''
}

function submitAnalyze() {
  proxy.$refs.uploadRef.validate(valid => {
    if (!valid) {
      return
    }
    analyzeLoading.value = true
    analyzeAssessment({
      elderName: uploadForm.value.elderName.trim(),
      idCard: uploadForm.value.idCard.trim(),
      physicalExamInstitution: uploadForm.value.physicalExamInstitution.trim(),
      physicalReportUrl: uploadForm.value.physicalReportUrl
    }).then(res => {
      const id = res.data && res.data.id
      proxy.$modal.msgSuccess('分析完成')
      uploadOpen.value = false
      getList()
      if (id) {
        router.push('/serve/assessment-view/index/' + id)
      }
    }).finally(() => {
      analyzeLoading.value = false
    })
  })
}

function goDetail(id) {
  router.push('/serve/assessment-view/index/' + id)
}

getList()
</script>
