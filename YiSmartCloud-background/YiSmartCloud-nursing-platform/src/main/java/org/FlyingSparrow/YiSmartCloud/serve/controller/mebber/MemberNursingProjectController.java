package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.common.core.page.TableDataInfo;
import org.FlyingSparrow.YiSmartCloud.serve.domain.NursingProject;
import org.FlyingSparrow.YiSmartCloud.serve.service.INursingProjectService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 小程序端护理项目（服务下单）只读接口
 *
 * @author agent
 */
@RestController
@RequestMapping("/member/orders/project")
@Api(tags = "小程序-护理项目")
@RequiredArgsConstructor
public class MemberNursingProjectController extends BaseController {

    private final INursingProjectService nursingProjectService;

    @GetMapping("/page")
    @ApiOperation("分页查询护理项目列表")
    @SuppressWarnings("rawtypes")
    public TableDataInfo page(NursingProject nursingProject) {
        if (nursingProject.getStatus() == null) {
            nursingProject.setStatus(1);
        }
        startPage();
        List<NursingProject> list = nursingProjectService.selectNursingProjectList(nursingProject);
        return getDataTable(list);
    }

    @GetMapping("/{id}")
    @ApiOperation("根据编号查询护理项目信息")
    public AjaxResult getById(@ApiParam(value = "护理项目ID", required = true) @PathVariable("id") Long id) {
        return success(nursingProjectService.selectNursingProjectById(id));
    }
}
