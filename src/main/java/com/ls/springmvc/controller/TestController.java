package com.ls.springmvc.controller;

import com.ls.springmvc.Utils.LogUtil;
import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;

import com.ls.springmvc.vo.page.OrderSearchParam;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
//@RequestMapping("/user")
@RequestMapping("/test")
public class TestController {

    @Autowired
    private UserService userService;

    @Autowired
    private OrderService orderService;
    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AjaxResponse ajaxResponse;
    @GetMapping(value = "/list")
    public String userList() {
        return "admin/user/userList";
    }
    @GetMapping(value = "/error")
    public String error() {
        if (true) {
            LogUtil.error("这是一个测试异常");
            throw new RuntimeException("这是一个测试异常");
        }
        return "success";
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
    @PostMapping("/order/list")
    public AjaxResponse listOrders() {
        Integer userId = 1;
        if(userId == null) {
            return new AjaxResponse(401, "用户未登录", null);
        }
        try {
            List<Order> orders = orderService.getOrdersByUserId(userId);
            return new AjaxResponse( 200,"获取订单列表成功",orders);
        } catch (Exception e) {
            return new AjaxResponse(500, "获取订单列表失败: " + e.getMessage(),null);
        }
    }
    @GetMapping("/order/page_Search")
    @ResponseBody
    public AjaxResponse pageSearch(OrderSearchParam param) {
        PageData<Order> pageData = orderService.pageSearch(param);
        if (pageData == null) {
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("查询失败");
            ajaxResponse.setObj(null);
        }else {
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("查询成功");
            ajaxResponse.setObj(pageData);
        }
        return ajaxResponse;
    }
    @GetMapping("/order/status_counts")
    @ResponseBody
    public AjaxResponse getAllOrderStatusCounts( OrderSearchParam param) {
        List<Map<String, Integer>> counts = orderService.getAllOrderStatusCounts(param);
        Map<String, Object> result = new HashMap<>();
        result.put("data", counts);
        return new AjaxResponse(0, "查询成功", result);
    }
    @GetMapping("/resource/category_counts")
    @ResponseBody
    public AjaxResponse getAllResourceCategoryCounts(ResourceSearchParam param) {
        List<Map<String, Integer>> counts = resourceService.getAllResourceCategoryCounts(param);
        Map<String, Object> result = new HashMap<>();
        result.put("data", counts);
        return new AjaxResponse(0, "查询成功", result);
    }
    @GetMapping("/page_Search")
    @ResponseBody
    public AjaxResponse pageSearch(ResourceSearchParam param) {
        PageData<Resource> pageData = resourceService.pageSearch(param);
        if (pageData == null) {
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("查询失败");
            ajaxResponse.setObj(null);
        }else {
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("查询成功");
            ajaxResponse.setObj(pageData);
        }
        return ajaxResponse;
    }
}