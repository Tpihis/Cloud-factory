package com.ls.springmvc.vo.page;

import lombok.Data;
import org.springframework.stereotype.Component;

@Data
public class ResourceSearchParam extends PageSearchParam{
    private Integer resourceid; //资源id
    private Integer userid; //用户id
    private String resourcename;    //资源名称
    private String resourcedescription; //资源描述
    private Integer quantity;    //资源数量
    private Float resourceprice;    //资源价格
    private String resourcestatus;    //资源状态
    private Integer categoryid;    //资源分类id
    private String resourcedate;    //资源发布日期
    private String auditstatus;    //审核状态

    public Integer getResourceid() {
        return resourceid;
    }

    public void setResourceid(Integer resourceid) {
        this.resourceid = resourceid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getResourcename() {
        return resourcename;
    }

    public void setResourcename(String resourcename) {
        this.resourcename = resourcename;
    }

    public String getResourcedescription() {
        return resourcedescription;
    }

    public void setResourcedescription(String resourcedescription) {
        this.resourcedescription = resourcedescription;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Float getResourceprice() {
        return resourceprice;
    }

    public void setResourceprice(Float resourceprice) {
        this.resourceprice = resourceprice;
    }

    public String getResourcestatus() {
        return resourcestatus;
    }

    public void setResourcestatus(String resourcestatus) {
        this.resourcestatus = resourcestatus;
    }

    public Integer getCategoryid() {
        return categoryid;
    }

    public void setCategoryid(Integer categoryid) {
        this.categoryid = categoryid;
    }

    public String getResourcedate() {
        return resourcedate;
    }

    public void setResourcedate(String resourcedate) {
        this.resourcedate = resourcedate;
    }

    public String getAuditstatus() {
        return auditstatus;
    }

    public void setAuditstatus(String auditstatus) {
        this.auditstatus = auditstatus;
    }

}
