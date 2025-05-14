package com.ls.springmvc.service;

import com.ls.springmvc.vo.Order;

public interface OrderService {
    public int createOrder(Order order);
    public Order findOrderById(Integer orderid);
}
