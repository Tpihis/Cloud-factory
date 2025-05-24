package com.ls.springmvc.service.impl;

import com.ls.springmvc.dao.OrderDao;
import com.ls.springmvc.dao.ResourceDao;
import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.page.OrderSearchParam;
import com.ls.springmvc.vo.page.PageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Service("orderService")
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;
    @Autowired
    private ResourceDao resourceDao;

    @Transactional
    public int createOrder(Order order) {
        orderDao.insert(order); // 调用XML配置的insert

        // 返回生成的订单ID
        return order.getOrderid();
    }
    public Order findOrderById(Integer orderid) {
        return orderDao.findOrderById(orderid);
    }
    @Override
    public List<Order> getOrdersByUserId(Integer userId) {
        return orderDao.selectByUserId(userId);
    }

    public List<Order> pageSearch(){
        return orderDao.pageSearch();
    }
    @Override
    public PageData<Order> pageSearch(OrderSearchParam param) {
        // 参数校验
        if (param.getPageNum() == null || param.getPageNum() < 1) {
            param.setPageNum(1);
        }
        if (param.getPageSize() == null || param.getPageSize() <= 0) {
            param.setPageSize(6);
        }

        // 计算偏移量（pageNum从1开始）
        int offset = (param.getPageNum() - 1) * param.getPageSize();
        param.setPageNum(offset);

        List<Order> list = orderDao.pageListOrder(param);
        int total = orderDao.totalOrderCount(param);

        return new PageData<>(list, total, param.getPageNum(), param.getPageSize());
    }
    public List<Map<String, Integer>> getAllOrderStatusCounts(OrderSearchParam param) {
        List<Map<String, Integer>> countsList = new ArrayList<Map<String, Integer>>();
        try {
            countsList = orderDao.getAllOrderStatusCounts(param);
            System.out.println("查询订单状态数量成功"+countsList);
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("查询订单状态数量失败"+e.getMessage());
//            return new HashMap<>();
        }
        // 计算全部订单数量（更健壮地实现）
        int totalCount =  0 ;
        for (Map<String, Integer> countMap : countsList) {
            totalCount +=  countMap.get("count");
        }

        Map<String, Integer> totalMap = new HashMap<>();
        totalMap.put("orderstatus", -1);
        totalMap.put("count", totalCount);
        countsList.add(totalMap);
        return countsList;
    }
    @Override
    @Transactional
    public boolean payOrder(Integer orderId) {
        Order order = orderDao.findOrderById(orderId);
        if(order != null && "待支付".equals(order.getOrderstatus())) {
            // 更新订单状态为已支付
            order.setOrderstatus("已支付");
            order.setOrdertime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            return orderDao.update(order) > 0;
        }
        return false;
    }

    @Override
    @Transactional
    public boolean cancelOrder(Integer orderId) {
        Order order = orderDao.findOrderById(orderId);
        if(order != null && "待支付".equals(order.getOrderstatus())) {
            // 更新订单状态为已取消
            order.setOrderstatus("已取消");
            return orderDao.update(order) > 0;
        }
        return false;
    }
}
