package org.FlyingSparrow.YiSmartCloud.serve.controller.mebber;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.FlyingSparrow.YiSmartCloud.common.core.controller.BaseController;
import org.FlyingSparrow.YiSmartCloud.common.core.domain.AjaxResult;
import org.FlyingSparrow.YiSmartCloud.serve.dto.UserLoginRequestDto;
import org.FlyingSparrow.YiSmartCloud.serve.service.IFamilyMemberService;
import org.FlyingSparrow.YiSmartCloud.serve.vo.LoginVo;

/**
 * Family member (mini-program) API.
 */
@RestController
@RequestMapping("/serve/member/user")
@Api(tags = "Family member (mini-program)")
public class FamilyMemberController extends BaseController {

    @Autowired
    private IFamilyMemberService familyMemberService;

    @PostMapping("/login")
    @ApiOperation("Mini-program login")
    public AjaxResult login(@RequestBody UserLoginRequestDto userLoginRequestDto) {
        LoginVo loginVo = familyMemberService.login(userLoginRequestDto);
        return success(loginVo);
    }
}
