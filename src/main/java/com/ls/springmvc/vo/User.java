package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class User {
    private Integer userid;
    private String username;
    private String password;
    private String phone;
    private String email;
    private int role; // 0: 普通用户, 1: 管理员
    private int age;
    private String time;//注册时间
    private int gender;//性别 1: 男, 2: 女,3:保密
    private String address;
    private int status;//状态 0: 正常, 1: 封禁
}
