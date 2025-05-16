package com.ls.springmvc.service;

import com.ls.springmvc.vo.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrderService {
    public int createOrder(Order order);
    public Order findOrderById(Integer orderid);
    List<Order> getOrdersByUserId( Integer userId);
}
