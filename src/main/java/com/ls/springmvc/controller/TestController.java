package com.ls.springmvc.controller;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.User;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Controller
//@RequestMapping("/user")
@RequestMapping("/test")
public class TestController {

    @Autowired
    private UserService userService;
    @Autowired
    private AjaxResponse ajaxResponse;
    @GetMapping(value = "/list")
    public String userList() {
        return "admin/user/userList";
    }


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
    //    @PostMapping(value = "/pageSearch")
    @GetMapping(value = "/pageSearch")
    @ResponseBody
    public List<User> pageSearch() {
        return userService.pageSearch();
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        User user = (User) session.getAttribute("loginUser");
        if(user != null){
            session.removeAttribute("loginUser");
        }
        return "index";
    }
    @GetMapping(value="/add")
    @ResponseBody
    public AjaxResponse add(@RequestBody User user) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode("123456"));
        // 获取当前时间
        LocalDateTime now = LocalDateTime.now();
        // 定义时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        // 格式化时间
        String formattedDateTime = now.format(formatter);
        user.setTime(formattedDateTime);
        boolean register = userService.registerUser(user);
        if(register){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("登录成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("登录失败");
        }
        return ajaxResponse;
    }

    @PostMapping(value="/delete")
    @ResponseBody
    public AjaxResponse delete(@RequestBody
                               @RequestParam("userid") Integer userid) {
        boolean delete = userService.deleteUser(userid);
        if(delete){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("删除成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("删除失败");
        }
        return ajaxResponse;
    }

}