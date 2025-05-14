package com.ls.springmvc.controller.user;

import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller(value = "userOrderController")
@RequestMapping(value = "/user/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private ResourceService resourceService;
    @Autowired
    private UserService userService;
    @Autowired
    private AjaxResponse ajaxResponse;
    @GetMapping("/details")
    public String orderDetails(){
        return "/user/orderDetails";
    }

    @PostMapping(value = "/create")
    @ResponseBody
    public AjaxResponse createOrder(@RequestBody Order order, HttpSession session, Principal principal) {

        //获取到登录的用户名 这里的User对象是Spring-Security提供的User
        // 设置当前用户ID（假设用户已登录）
        Integer userid = userService.findUserByUsername(principal.getName()).getUserid();
        if(userid == null) {
            return new AjaxResponse(401, "用户未登录", null);
        }

        try {
            // 设置订单其他信息
            order.setOrdertime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            order.setOrderstatus("待支付");
            order.setUserid(userid);

            //检查库存
            for (String resourceId : order.getResourceids().split(",")) {
                boolean checkStock = resourceService.checkStock(Integer.parseInt(resourceId), order.getQuantity());
                if (!checkStock) {
                    return new AjaxResponse(400, "库存不足", null);
                }
            }

            // 创建订单
            int orderId = orderService.createOrder(order);
            // 扣减库存
            for (String resourceId : order.getResourceids().split(",")) {
                resourceService.deductStock(Integer.parseInt(resourceId), order.getQuantity());
            }

            // 创建返回数据
            Map<String, Object> data = new HashMap<>();
            data.put("orderid", orderId);

            return new AjaxResponse(200, "订单创建成功", data);
        } catch (Exception e) {
            return new AjaxResponse(500, "创建订单失败: " + e.getMessage(), null);
        }
    }

    @GetMapping("/detail")
    public String getOrderDetail(@RequestParam("id") Integer orderId, Model model) {
        try {
            // 1. 查询订单基本信息
            Order order = orderService.findOrderById(orderId);
            if (order == null) {
                return "error/404"; // 订单不存在
            }

            // 2. 查询用户信息
            User user = userService.findUserById(order.getUserid());

            // 3. 查询资源信息列表
            List<Resource> resources = new ArrayList<>();
            String[] resourceIds = order.getResourceids().split(",");
            for (String resourceId : resourceIds) {
                if (!resourceId.trim().isEmpty()) {
                    Resource resource = resourceService.getResourceById(Integer.parseInt(resourceId.trim()));
                    if (resource != null) {
                        resources.add(resource);
                    }
                }
            }

            // 4. 准备模型数据
            model.addAttribute("order", order);
            model.addAttribute("user", user);
            model.addAttribute("resources", resources);

            return "/user/orderDetails"; // 返回订单详情页面
        } catch (Exception e) {
            return "error/500"; // 服务器错误
        }
    }
}
