package org.FlyingSparrow.YiSmartCloud.serve.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

import java.io.ByteArrayInputStream;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import lombok.AllArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.utils.PDFUtil;
import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;
import org.FlyingSparrow.YiSmartCloud.common.utils.file.FileUtils;
import org.FlyingSparrow.YiSmartCloud.oss.AliyunOSSOperator;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.FlyingSparrow.YiSmartCloud.common.annotation.Log;
import org.FlyingSparrow.YiSmartCloud.common.annotation.RepeatSubmit;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.enums.BusinessType;
import org.FlyingSparrow.YiSmartCloud.serve.domain.HealthAssessment;
import org.FlyingSparrow.YiSmartCloud.serve.dto.HealthAssessmentAnalyzeRequest;
import org.FlyingSparrow.YiSmartCloud.serve.service.IHealthAssessmentService;
import org.FlyingSparrow.YiSmartCloud.common.utils.poi.ExcelUtil;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.springframework.web.multipart.MultipartFile;

/**
 * 健康评估Controller
 *
 * @author Siborne
 * @date 2026-05-04
 */
@RestController
@RequestMapping("/serve/assessment")
@Api(tags = "健康评估相关接口")
@AllArgsConstructor
public class HealthAssessmentController extends BaseController {

    private final IHealthAssessmentService healthAssessmentService;

    private final AliyunOSSOperator aliyunOSSOperator;

    private final RedisTemplate<String, String> redisTemplate;

    private static final long MAX_UPLOAD_BYTES = 60L * 1024 * 1024;

    /**
     * 查询健康评估列表
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:list')")
    @GetMapping("/list")
    @ApiOperation("查询健康评估列表")
    public TableDataInfo list(HealthAssessment healthAssessment) {
        startPage();
        List<HealthAssessment> list = healthAssessmentService.selectHealthAssessmentList(healthAssessment);
        return getDataTable(list);
    }

    /**
     * 导出健康评估列表
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:export')")
    @Log(title = "健康评估", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    @ApiOperation("导出健康评估列表")
    public void export(HttpServletResponse response, HealthAssessment healthAssessment) {
        List<HealthAssessment> list = healthAssessmentService.selectHealthAssessmentList(healthAssessment);
        ExcelUtil<HealthAssessment> util = new ExcelUtil<HealthAssessment>(HealthAssessment.class);
        util.exportExcel(response, list, "健康评估数据");
    }

    /**
     * 获取健康评估详细信息
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:query')")
    @GetMapping(value = "/{id}")
    @ApiOperation("获取健康评估详细信息")
    public AjaxResult getInfo(@ApiParam(value = "健康评估ID", required = true)
                              @PathVariable("id") Long id) {
        return success(healthAssessmentService.selectHealthAssessmentById(id));
    }

    /**
     * 新增健康评估
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:add')")
    @Log(title = "健康评估", businessType = BusinessType.INSERT)
    @PostMapping
    @ApiOperation("新增健康评估")
    public AjaxResult add(@ApiParam(value = "健康评估实体", required = true) @RequestBody HealthAssessment healthAssessment) {
        return toAjax(healthAssessmentService.insertHealthAssessment(healthAssessment));
    }

    /**
     * 修改健康评估
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:edit')")
    @Log(title = "健康评估", businessType = BusinessType.UPDATE)
    @PutMapping
    @ApiOperation("修改健康评估")
    public AjaxResult edit(@ApiParam(value = "健康评估实体", required = true) @RequestBody HealthAssessment healthAssessment) {
        return toAjax(healthAssessmentService.updateHealthAssessment(healthAssessment));
    }

    /**
     * 删除健康评估
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:remove')")
    @Log(title = "健康评估", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    @ApiOperation("删除健康评估")
    public AjaxResult remove(@PathVariable Long[] ids) {
        return toAjax(healthAssessmentService.deleteHealthAssessmentByIds(ids));
    }

    /**
     * 体检报告智能分析：读取 Redis 正文、调用千帆、解析 JSON 并落库。
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:add')")
    @Log(title = "健康评估", businessType = BusinessType.INSERT)
    @PostMapping("/analyze")
    @ApiOperation("体检报告智能分析并入库")
    @RepeatSubmit(interval = 8000, message = "分析请求处理中，请勿重复提交")
    public AjaxResult analyze(@ApiParam(value = "分析请求", required = true) @RequestBody HealthAssessmentAnalyzeRequest body) {
        HealthAssessment saved = healthAssessmentService.analyzeAndSave(body);
        return AjaxResult.success(saved);
    }

    /**
     * 健康文档上传（OSS），PDF 时解析正文并写入 Redis（hash：healthReport，field：身份证号）
     */
    @PreAuthorize("@ss.hasPermi('serve:assessment:add')")
    @ApiOperation("健康文档上传")
    @PostMapping("/upload")
    public AjaxResult uploadFile(
            @ApiParam(value = "上传文件", required = true) MultipartFile file,
            @ApiParam(value = "身份证号", required = true) @RequestParam("idCardNo") String idCardNo) {
        try {
            if (file == null || file.isEmpty()) {
                return AjaxResult.error("上传文件不能为空");
            }
            if (file.getSize() > MAX_UPLOAD_BYTES) {
                return AjaxResult.error("文件大小不能超过 60MB");
            }
            if (StringUtils.isEmpty(idCardNo)) {
                return AjaxResult.error("身份证号不能为空");
            }
            String originalFilename = file.getOriginalFilename();
            if (StringUtils.isEmpty(originalFilename)) {
                return AjaxResult.error("文件名无效");
            }
            if (!originalFilename.toLowerCase().endsWith(".pdf")) {
                return AjaxResult.error("仅支持上传 PDF 文件");
            }

            byte[] bytes = file.getBytes();
            String url = aliyunOSSOperator.upload(bytes, originalFilename);

            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", url);
            ajax.put("newFileName", FileUtils.getName(url));
            ajax.put("originalFilename", originalFilename);

            String content = PDFUtil.pdfToString(new ByteArrayInputStream(bytes));
            if (StringUtils.isEmpty(content)) {
                return AjaxResult.error("未能从 PDF 中提取文本，请检查文件是否加密或扫描版无文本层");
            }
            redisTemplate.opsForHash().put("healthReport", idCardNo, content);

            return ajax;
        } catch (Exception e) {
            return AjaxResult.error(e.getMessage());
        }
    }
}