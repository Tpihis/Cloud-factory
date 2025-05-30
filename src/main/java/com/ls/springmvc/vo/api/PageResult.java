package com.ls.springmvc.vo.api;

import lombok.Data;

import java.util.List;

@Data
public class PageResult<T> {
    private long total;
    private List<T> list;

    public PageResult(long total, List<T> list) {
        this.total = total;
        this.list = list;
    }

}
