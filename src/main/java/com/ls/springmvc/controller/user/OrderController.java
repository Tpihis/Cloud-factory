package com.ls.springmvc.controller.user;

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

    @PostMapping("/list")
    @ResponseBody
    public AjaxResponse listOrders(Principal principal) {
        Integer userId = userService.findUserByUsername(principal.getName()).getUserid();
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
                model.addAttribute("error", "订单不存在");
                return "error/error"; // 订单不存在
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
            model.addAttribute("error", "服务器错误: " + e.getMessage());
            return "error/error"; // 服务器错误
        }
    }
    // 分页模糊查询
    @PostMapping("/page_Search")
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
    @PostMapping("/status_counts")
    @ResponseBody
    public AjaxResponse getAllOrderStatusCounts(OrderSearchParam param) {
        List<Map<String, Integer>> counts = orderService.getAllOrderStatusCounts(param);
        Map<String, Object> result = new HashMap<>();
        result.put("data", counts);
        return new AjaxResponse(0, "查询成功", result);
    }
    // 支付订单
    // 支付订单 - 修改后
    @PostMapping("/pay")
    @ResponseBody
    public AjaxResponse payOrder(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            Integer orderId = (Integer) params.get("orderId");
            if(orderId == null) {
                return new AjaxResponse(400, "订单ID不能为空", null);
            }

            // 获取当前用户ID
            User currentUser = userService.findUserByUsername(principal.getName());
            if(currentUser == null) {
                return new AjaxResponse(401, "用户未登录", null);
            }
            Integer userId = currentUser.getUserid();

            // 验证订单归属和状态
            Order order = orderService.findOrderById(orderId);
            if(order == null) {
                return new AjaxResponse(404, "订单不存在", null);
            }

            if(!order.getUserid().equals(userId)) {
                return new AjaxResponse(403, "无权操作此订单", null);
            }

            if(!"待支付".equals(order.getOrderstatus())) {
                return new AjaxResponse(400, "订单状态不允许支付", null);
            }

            // 执行支付逻辑
            boolean success = orderService.payOrder(orderId);
            if(success) {
                return new AjaxResponse(200, "支付成功", null);
            } else {
                return new AjaxResponse(500, "支付失败", null);
            }
        } catch (Exception e) {
            return new AjaxResponse(500, "支付处理失败: " + e.getMessage(), null);
        }
    }

    // 取消订单 - 修改后
    @PostMapping("/cancel")
    @ResponseBody
    public AjaxResponse cancelOrder(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            Integer orderId = (Integer) params.get("orderId");
            if(orderId == null) {
                return new AjaxResponse(400, "订单ID不能为空", null);
            }

            // 获取当前用户ID
            User currentUser = userService.findUserByUsername(principal.getName());
            if(currentUser == null) {
                return new AjaxResponse(401, "用户未登录", null);
            }
            Integer userId = currentUser.getUserid();

            // 验证订单归属和状态
            Order order = orderService.findOrderById(orderId);
            if(order == null) {
                return new AjaxResponse(404, "订单不存在", null);
            }

            if(!order.getUserid().equals(userId)) {
                return new AjaxResponse(403, "无权操作此订单", null);
            }

            if(!"待支付".equals(order.getOrderstatus())) {
                return new AjaxResponse(400, "订单状态不允许取消", null);
            }

            // 执行取消逻辑
            boolean success = orderService.cancelOrder(orderId);
            if(success) {
                // 恢复库存
                restoreStock(order);
                return new AjaxResponse(200, "订单已取消", null);
            } else {
                return new AjaxResponse(500, "取消失败", null);
            }
        } catch (Exception e) {
            return new AjaxResponse(500, "取消处理失败: " + e.getMessage(), null);
        }
    }

    // 恢复库存的私有方法
    private void restoreStock(Order order) {
        try {
            for (String resourceId : order.getResourceids().split(",")) {
                if (!resourceId.trim().isEmpty()) {
                    resourceService.restoreStock(Integer.parseInt(resourceId.trim()), order.getQuantity());
                }
            }
        } catch (Exception e) {
            // 记录错误日志，但不影响主流程
            System.err.println("恢复库存失败: " + e.getMessage());
        }
    }
}
