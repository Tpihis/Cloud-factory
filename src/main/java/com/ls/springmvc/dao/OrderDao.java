package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface OrderDao {
    // 插入订单并返回主键
    int insert(Order order);

    // 根据ID查询订单
    Order findOrderById(Integer orderid);

    // 更新订单状态
    int updateStatus(Integer orderid, String status);
}
