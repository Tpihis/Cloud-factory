package com.ls.springmvc.controller.user;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;

import com.ls.springmvc.vo.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Map;


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

    @GetMapping("/requestList")
    public String requestList(){
        return "user/requestList";
    }



    @GetMapping("/profileInfo")
    @ResponseBody
    public AjaxResponse getProfileInfo(Principal principal) {
        try {
            String username = principal.getName();
            User user = userService.findUserByUsername(username);

            if(user == null) {
                ajaxResponse.setCode(-1);
                ajaxResponse.setMsg("用户不存在");
                return ajaxResponse;
            }

            // 不返回密码等敏感信息
            user.setPassword(null);

            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("获取用户信息成功");
            ajaxResponse.setObj(user);
            return ajaxResponse;
        } catch (Exception e) {
            ajaxResponse.setCode(-2);
            ajaxResponse.setMsg("获取用户信息失败: " + e.getMessage());
            return ajaxResponse;
        }
    }
    @GetMapping("/profile")
    public String profile(Model model, Principal principal) {

        if (principal == null) {
            return "redirect:/login?error=not_logged_in";
        }
        String username = principal.getName();
        try {
            User user = userService.findUserByUsername(username);
            if (user != null) {
                model.addAttribute("user", user);
            }
            return "user/personalCenter";
        } catch (UsernameNotFoundException e) {
            return "redirect:/login?error=user_not_found";
        }
    }
    @PostMapping("/updateProfile")
    @ResponseBody
    public AjaxResponse updateProfile(@RequestBody User user, Principal principal) {
        try {
            Integer userId = userService.findUserByUsername(principal.getName()).getUserid();

            if(userId == null) {
                ajaxResponse.setCode(-1);
                ajaxResponse.setMsg("用户不存在");
                return ajaxResponse;
            }
            user.setUserid(userId);
            int result = userService.updateUser(user);

            if(result > 0) {
                ajaxResponse.setCode(0);
                ajaxResponse.setMsg("资料更新成功");
            } else {
                ajaxResponse.setCode(-2);
                ajaxResponse.setMsg("资料更新失败");
            }
        } catch (Exception e) {
            ajaxResponse.setCode(-3);
            ajaxResponse.setMsg("系统错误: " + e.getMessage());
        }
        return ajaxResponse;
    }

    @PostMapping("/changePassword")
    @ResponseBody
    public AjaxResponse changePassword(@RequestBody Map<String, String> params, Principal principal) {
        try {
            String username = principal.getName();
            User user = userService.findUserByUsername(username);

            if(user == null) {
                ajaxResponse.setCode(-1);
                ajaxResponse.setMsg("用户不存在");
                return ajaxResponse;
            }
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            String currentPassword = encoder.encode(params.get("currentPassword")) ;
            String newPassword = encoder.encode(params.get("newPassword"));

            // 验证当前密码是否正确
            if(!user.getPassword().equals(currentPassword)) {
                ajaxResponse.setCode(-2);
                ajaxResponse.setMsg("当前密码不正确");
                return ajaxResponse;
            }

            // 更新密码
            user.setPassword(newPassword);
            int result = userService.updateUser(user);

            if(result > 0) {
                ajaxResponse.setCode(0);
                ajaxResponse.setMsg("密码修改成功");
            } else {
                ajaxResponse.setCode(-3);
                ajaxResponse.setMsg("密码修改失败");
            }
        } catch (Exception e) {
            ajaxResponse.setCode(-4);
            ajaxResponse.setMsg("系统错误: " + e.getMessage());
        }
        return ajaxResponse;
    }
}