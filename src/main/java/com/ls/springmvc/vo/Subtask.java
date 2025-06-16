package com.ls.springmvc.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Subtask {
    private Integer subtaskid;  //子任务ID
    private Integer taskid;     //任务ID
    private String subtaskname; //子任务名称
    private String subtaskstatus;   //子任务状态 1: "待完成", 2: "已完成", 3: "已取消"
    private String resourcerequirements;    //资源要求
    private String estimatedtime;    //预计完成时间
    private String resourceids;    //对应资源列表，用逗号分隔
    private String resourcequantities;  //对应资源数量列表，用逗号分隔,与资源列表顺序一致

//    用于分解任务生成子任务的构造方法
    public Subtask(Integer taskid,
                   String subtaskname,
                   String subtaskstatus,
                   String resourcerequirements,
                   String estimatedtime,
                   String resourcequantities) {
        this.taskid = taskid;
        this.subtaskname = subtaskname;
        this.subtaskstatus = subtaskstatus;
        this.resourcerequirements = resourcerequirements;
        this.estimatedtime = estimatedtime;
        this.resourcequantities = resourcequantities;
    }
}    