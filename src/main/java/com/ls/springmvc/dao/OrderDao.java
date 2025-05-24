package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Order;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.OrderSearchParam;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderDao {
    // 插入订单并返回主键
    int insert(Order order);
    List<Order> pageSearch();

    // 根据ID查询订单
    Order findOrderById(Integer orderid);

    // 更新订单状态
    int updateStatus(Integer orderid, String status);
    // 根据用户ID查询订单
    List<Order> selectByUserId(@Param("userId")Integer userId);

    // 分页模糊查询
    List<Order> pageListOrder(OrderSearchParam param);

    // 查询总数
    int totalOrderCount(OrderSearchParam param);
    /**
     * 查询所有订单状态的数量
     * @return 包含订单状态和对应数量的 Map
     */
    List<Map<String, Integer>> getAllOrderStatusCounts(OrderSearchParam param);
    int update(Order order);
}
