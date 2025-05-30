package com.ls.springmvc.vo.api;

import lombok.Data;

@Data
public class Result<T> {
    private int code;
    private String msg;
    private T obj;

    public Result(int code, String msg, T obj) {
        this.code = code;
        this.msg = msg;
        this.obj = obj;
    }

    // 成功静态方法
    public static <T> Result<T> success(T data) {
        return new Result<>(200, "success", data);
    }

    // 失败静态方法
    public static <T> Result<T> error(String msg) {
        return new Result<>(500, msg, null);
    }

}