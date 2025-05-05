package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Order {
    private Integer orderid;
    private Integer taskid;
    private String resourceids;
    private Float totalprice;
    private String orderstatus;
    private String ordertime;
    private String completiontime;
}