package com.ls.springmvc.controller.api;

import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/order")
public class OrderApiController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private ResourceService resourceService;
    @Autowired
    private UserService userService;
    @Autowired
    private AjaxResponse ajaxResponse;

    @GetMapping("/detail")
    public AjaxResponse getOrderDetail(@RequestParam("id") Integer orderId) {
        try {
            // 1. 查询订单基本信息
            Order order = orderService.findOrderById(orderId);
            if (order == null) {
                return new AjaxResponse(404, "订单不存在", null);
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

            // 4. 准备返回数据
            Map<String, Object> data = new HashMap<>();
            data.put("order", order);
            data.put("user", user);
            data.put("resources", resources);

            return new AjaxResponse(200, "获取订单详情成功", data);
        } catch (Exception e) {
            return new AjaxResponse(500, "获取订单详情失败: " + e.getMessage(), null);
        }
    }
}
