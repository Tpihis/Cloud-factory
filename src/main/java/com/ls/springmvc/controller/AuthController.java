package com.ls.springmvc.controller;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;


@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/noAuthority")
    public String noAuthorityPage(){
        return "noAuthority";
    }

    @GetMapping("/loginPage")
    public String loginPage(@RequestParam(value = "error",required = false)
                            boolean error, Model model){
        if(error){
            model.addAttribute("msg","用户名和密码错误");
        }
        return "login";
    }


    @GetMapping("/register")
    public String registerPage(){
        return "register";
    }

    @PostMapping("/register")
    public String register(User user){
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode(user.getPassword()));
        if(userService.registerUser(user)){
            return "login";
        }

        return "register";
    }

    @GetMapping("/getUserInfo")
    public void getUserInfo(){
        Authentication authentication =
                SecurityContextHolder.getContext()
                        .getAuthentication();
        UserDetails user = (UserDetails) authentication.getPrincipal();
        String Username =  authentication.getName();
        String username = user.getUsername();
        // 用户名，如 "admin"
        String password = user.getPassword();
        // 加密后的密码（认证后可能为空）
        // 权限列表，如 ["ROLE_ADMIN"]
        Collection<? extends GrantedAuthority> authorities =
                user.getAuthorities();
        System.out.println(username);
        System.out.println(Username);
        System.out.println(password);
        for (GrantedAuthority authority:authorities) {
            System.out.println(authority.getAuthority());
        }
    }
    @GetMapping("/getCurrentUser")
    @ResponseBody
    public AjaxResponse getCurrentUser(){
        Authentication authentication =
                SecurityContextHolder.getContext()
                        .getAuthentication();


        Collection<? extends GrantedAuthority> authorities =
                authentication.getAuthorities();
        boolean isAnonymous = false;
        for (GrantedAuthority authority:authorities) {
                if(authority.getAuthority().equals("ROLE_ANONYMOUS")){
                    isAnonymous = true;
                    break;
                }
        }
        String username = authentication.getName();
        if(username == "anonymousUser" && isAnonymous){
            return new AjaxResponse(-1,"未登录",null);
        }
        User user = userService.getCurrentUser(authentication);
        return new  AjaxResponse(0,"获取用户信息成功",user);
    }
}

