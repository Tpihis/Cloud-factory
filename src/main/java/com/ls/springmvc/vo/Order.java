package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Order {
    private Integer orderid;//订单ID
    private Integer userid;//用户ID
    private Integer taskid;//任务ID
    private String resourceids;//资源ID列表，用逗号分隔
    private Float totalprice;//总价
    private Integer quantity;//购买数量
    private String orderstatus;//订单状态（待支付、已支付、已取消、已完成）
    private String ordertime;//下单时间
    private String completiontime;//完成时间
}