package com.ls.springmvc.service;

import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.OrderSearchParam;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OrderService {
    public int createOrder(Order order);
    public Order findOrderById(Integer orderid);
    List<Order> getOrdersByUserId( Integer userId);
    // 分页模糊查询
    PageData<Order> pageSearch(OrderSearchParam param);
    List<Map<String, Integer>> getAllOrderStatusCounts(OrderSearchParam param);
}
