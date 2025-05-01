package com.ls.springmvc.controller;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
//@RequestMapping("/user")
@RequestMapping("/user")
public class UserController {

    @Autowired
     private UserService userService;
    @Autowired
    private AjaxResponse ajaxResponse;


//    @GetMapping("/login")
//    public String loginPage(){
//        return "login";
//    }
//

    @GetMapping("/register")
    public String registerPage(){
        return "register";
    }

    @GetMapping("/chat")
    public String chatPage(){
        return "chat";
    }


    @GetMapping("/resourceDisplay")
    public String resourceDisplay(){
        return "/user/resourceDisplay";
    }

}