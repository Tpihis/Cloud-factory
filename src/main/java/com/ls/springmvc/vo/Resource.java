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
    private String      resourcestatus;      //资源状态
    private Integer     categoryid;         //资源分类id
    private String      resourcedate;       //资源发布日期
    private String      auditstatus;        //审核状态
}