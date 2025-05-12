package com.ls.springmvc.vo.page;

import lombok.Data;

@Data
public class PageSearchParam {
    private Integer pageNum;//默认1
    private Integer pageSize;
    private String orderBy;
    private String orderDirect;
    private String searchKey;

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getOrderDirect() {
        return orderDirect;
    }

    public void setOrderDirect(String orderDirect) {
        this.orderDirect = orderDirect;
    }
    public String getSearchKey() {
        return searchKey;
    }
    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }
}
