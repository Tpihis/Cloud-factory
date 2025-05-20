package com.ls.springmvc.controller.user;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;


@Controller
//@RequestMapping("/user")
@RequestMapping("/user")
public class UserController {

    @Autowired
     private UserService userService;
    @Autowired
    private AjaxResponse ajaxResponse;


    @GetMapping("/register")
    public String registerPage(){
        return "register";
    }

    @GetMapping("/chat")
    public String chatPage(){
        return "chat";
    }

    @GetMapping("/index")
    public String iframe(){
        return "user/iframe_top";
    }

    @GetMapping("/orderList")
    public String orderList(){
        return "user/orderList";
    }

    @GetMapping("/personalCenter")
    public String personalCenter(){
        return "user/personalCenter";
    }


}