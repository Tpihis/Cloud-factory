package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Resource {
//    resource
    private Integer     resourceid;             //资源id
    private Integer     userid;              //用户id
    private String      resourcename;        //资源名称
    private String      resourcedescription; //资源描述
    private Integer     quantity;            //资源数量
    private Float       resourceprice;       //资源价格
    private String      resourcestatus;      //资源状态 1: "繁忙",2: "空闲",3: "损坏",
    private Integer     categoryid;         //资源分类id  1: '设备资源', 2: '工艺知识',3: '设计模型',4: '制造服务'
    private String      resourcedate;       //资源发布日期
    private String      auditstatus;        //审核状态 驳回/通过/待审
    private User        user;                //用户信息
}