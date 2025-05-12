package com.ls.springmvc.vo.page;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class PageData<T> {
    private List<T> list;         // 当前页数据
    private int total;            // 总记录数
    private int pageNum;          // 当前页码（原始值）
    private int pageSize;         // 每页条数

    // 计算总页数
    public int getTotalPages() {
        return (int) Math.ceil((double) total / pageSize);
    }
}