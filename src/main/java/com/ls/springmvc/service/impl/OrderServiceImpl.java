package com.ls.springmvc.service.impl;

import com.ls.springmvc.dao.OrderDao;
import com.ls.springmvc.dao.ResourceDao;
import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.Date;

@Service("orderService")
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderdao;
    @Autowired
    private ResourceDao resourceDao;

    @Transactional
    public int createOrder(Order order) {
        orderdao.insert(order); // 调用XML配置的insert

        // 返回生成的订单ID
        return order.getOrderid();
    }
    public Order findOrderById(Integer orderid) {
        return orderdao.findOrderById(orderid);
    }
}
