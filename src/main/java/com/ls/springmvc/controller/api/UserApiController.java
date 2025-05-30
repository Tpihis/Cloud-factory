package com.ls.springmvc.controller.api;

import com.ls.springmvc.vo.api.Result;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/api/user")
public class UserApiController {

    @RequestMapping("/getCurrentUser")
    public Result getCurrentUser(Principal principal){
        if(principal != null){

            return Result.success(principal.getName());
        }
        return Result.error("未登录");
    }
}
