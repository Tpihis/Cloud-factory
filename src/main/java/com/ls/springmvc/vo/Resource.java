package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Resource {
//    resource
    private Integer resourceid;
    private Integer userid;
    private String resourcename;
    private String resourcedescription;
    private Integer quantity;
    private Float resourceprice;
    private String resourcestatus;
    private Integer categoryid;
    private String resourcedate;
    private String auditstatus;
}