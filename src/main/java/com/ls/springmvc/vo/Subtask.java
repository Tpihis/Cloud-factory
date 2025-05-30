package com.ls.springmvc.vo;

import lombok.Data;

import java.util.List;

@Data
public class Subtask {
    private Integer subtaskid;  //子任务ID
    private Integer taskid;     //任务ID
    private String subtaskname; //子任务名称
    private String subtaskstatus;   //子任务状态 1: "待完成", 2: "已完成", 3: "已取消"
    private String resourcerequirements;    //资源要求
    private String estimatedtime;    //预计完成时间
    private String resourceids;    //对应资源列表，用逗号分隔
}    