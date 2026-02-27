<template>
  <!-- 页面容器 -->
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <!-- 名称搜索输入框 -->
      <el-form-item label="名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入名称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <!-- 搜索和重置按钮 -->
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 工具栏按钮组 -->
    <el-row :gutter="10" class="mb8">
      <!-- 新增按钮 -->
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['serve:project:add']"
        >新增</el-button>
      </el-col>
      <!-- 修改按钮 -->
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['serve:project:edit']"
        >修改</el-button>
      </el-col>
      <!-- 删除按钮 -->
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['serve:project:remove']"
        >删除</el-button>
      </el-col>
      <!-- 导出按钮 -->
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['serve:project:export']"
        >导出</el-button>
      </el-col>
      <!-- 右侧工具栏 -->
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 数据表格 -->
    <el-table v-loading="loading" :data="projectList" @selection-change="handleSelectionChange">
      <!-- 多选列 -->
      <el-table-column type="selection" width="55" align="center" />
      <!-- 编号列 -->
      <el-table-column label="编号" align="center" prop="id" />
      <!-- 名称列 -->
      <el-table-column label="名称" align="center" prop="name" />
      <!-- 排序号列 -->
      <el-table-column label="排序号" align="center" prop="orderNo" />
      <!-- 单位列 -->
      <el-table-column label="单位" align="center" prop="unit" />
      <!-- 价格列 -->
      <el-table-column label="价格" align="center" prop="price" />
      <!-- 图片列 -->
      <el-table-column label="图片" align="center" prop="image" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.image" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <!-- 护理要求列 -->
      <el-table-column label="护理要求" align="center" prop="nursingRequirement" />
      <!-- 状态列 -->
      <el-table-column label="状态" align="center" prop="status" />
      <!-- 备注列 -->
      <el-table-column label="备注" align="center" prop="remark" />
      <!-- 操作列 -->
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['serve:project:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['serve:project:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <!-- 分页组件 -->
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改护理项目对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="projectRef" :model="form" :rules="rules" label-width="80px">
        <!-- 名称输入框 -->
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <!-- 排序号输入框 -->
        <el-form-item label="排序号" prop="orderNo">
          <el-input v-model="form.orderNo" placeholder="请输入排序号" />
        </el-form-item>
        <!-- 单位输入框 -->
        <el-form-item label="单位" prop="unit">
          <el-input v-model="form.unit" placeholder="请输入单位" />
        </el-form-item>
        <!-- 价格输入框 -->
        <el-form-item label="价格" prop="price">
          <el-input v-model="form.price" placeholder="请输入价格" />
        </el-form-item>
        <!-- 图片上传组件 -->
        <el-form-item label="图片" prop="image">
          <image-upload v-model="form.image"/>
        </el-form-item>
        <!-- 护理要求输入框 -->
        <el-form-item label="护理要求" prop="nursingRequirement">
          <el-input v-model="form.nursingRequirement" placeholder="请输入护理要求" />
        </el-form-item>
      </el-form>
      <!-- 对话框底部按钮 -->
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Project">
// 引入API接口函数
import { listProject, getProject, delProject, addProject, updateProject } from "@/api/serve/project"

// 获取当前实例的代理对象
const { proxy } = getCurrentInstance()

// 响应式数据定义
const projectList = ref([])        // 项目列表数据
const open = ref(false)            // 对话框显示状态
const loading = ref(true)          // 加载状态
const showSearch = ref(true)       // 搜索区域显示状态
const ids = ref([])                // 选中的ID数组
const single = ref(true)           // 是否单选状态
const multiple = ref(true)         // 是否多选状态
const total = ref(0)               // 总数据条数
const title = ref("")              // 对话框标题

// 响应式数据对象
const data = reactive({
  form: {},                        // 表单数据对象
  queryParams: {                   // 查询参数对象
    pageNum: 1,                    // 当前页码
    pageSize: 10,                  // 每页显示条数
    name: null,                    // 名称查询条件
    status: null,                  // 状态查询条件
  },
  rules: {                         // 表单验证规则
  }
})

// 解构获取响应式数据
const { queryParams, form, rules } = toRefs(data)

/** 查询护理项目列表 */
function getList() {
  loading.value = true             // 设置加载状态为true
  listProject(queryParams.value).then(response => {
    projectList.value = response.rows   // 设置项目列表数据
    total.value = response.total        // 设置总数据条数
    loading.value = false               // 设置加载状态为false
  })
}

// 取消按钮处理函数
function cancel() {
  open.value = false               // 关闭对话框
  reset()                          // 重置表单
}

// 表单重置函数
function reset() {
  form.value = {                   // 重置表单数据
    id: null,
    name: null,
    orderNo: null,
    unit: null,
    price: null,
    image: null,
    nursingRequirement: null,
    status: null,
    createBy: null,
    updateBy: null,
    remark: null,
    createTime: null,
    updateTime: null
  }
  proxy.resetForm("projectRef")    // 重置表单验证状态
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1    // 重置页码为第一页
  getList()                        // 重新获取列表数据
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")      // 重置搜索表单
  handleQuery()                    // 执行搜索
}

// 多选框选中数据处理
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id)  // 获取选中项的ID数组
  single.value = selection.length != 1        // 控制单选按钮状态
  multiple.value = !selection.length          // 控制多选按钮状态
}

/** 新增按钮操作 */
function handleAdd() {
  reset()                          // 重置表单
  open.value = true                // 显示对话框
  title.value = "添加护理项目"     // 设置对话框标题
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()                          // 重置表单
  const _id = row.id || ids.value  // 获取要修改的ID
  getProject(_id).then(response => {
    form.value = response.data     // 设置表单数据
    open.value = true              // 显示对话框
    title.value = "修改护理项目"   // 设置对话框标题
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["projectRef"].validate(valid => {  // 表单验证
    if (valid) {
      if (form.value.id != null) {               // 判断是修改还是新增
        updateProject(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")     // 显示成功消息
          open.value = false                     // 关闭对话框
          getList()                              // 刷新列表
        })
      } else {
        addProject(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")     // 显示成功消息
          open.value = false                     // 关闭对话框
          getList()                              // 刷新列表
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value               // 获取要删除的ID
  proxy.$modal.confirm('是否确认删除护理项目编号为"' + _ids + '"的数据项？').then(function() {
    return delProject(_ids)                      // 调用删除接口
  }).then(() => {
    getList()                                    // 刷新列表
    proxy.$modal.msgSuccess("删除成功")          // 显示成功消息
  }).catch(() => {})                             // 错误处理
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('serve/project/export', {       // 调用下载方法
    ...queryParams.value
  }, `project_${new Date().getTime()}.xlsx`)     // 设置下载文件名
}

// 初始化加载数据
getList()
</script>