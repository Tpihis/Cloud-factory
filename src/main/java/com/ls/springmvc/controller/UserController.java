package com.ls.springmvc.controller;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
//@RequestMapping("/user")
@RequestMapping("/a")
public class UserController {

    @Autowired
     private UserService userService;

//    @GetMapping("/login")
//    public String loginPage(){
//        return "login";
//    }
//
//    @PostMapping("/login")
////    @RequestMapping(value = "/login",method = RequestMethod.POST)
//    public String login(User user,HttpSession session){
//
//        ServiceMessage serviceMessage = userService.loginUser(user);
//        if(serviceMessage.getCode()!=0){
//            session.setAttribute("msg", serviceMessage.getMsg());
//            return "login";
//        }else{
//             user = (User) serviceMessage.getObj();
//            session.setAttribute("loginUser",user);
//            return "index";
//        }
//    }
    @GetMapping("/register")
    public String registerPage(){
        return "register";
    }

    @PostMapping("/register")
    public String register(User user){
       if(userService.registerUser(user)){
           return "login";
       }

        return "register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session){
        User user = (User) session.getAttribute("loginUser");
        if(user != null){
            session.removeAttribute("loginUser");
        }
        return "index";
    }

}