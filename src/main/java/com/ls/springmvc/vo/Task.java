package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Task {
    private Integer taskid;
    private Integer userid;
    private String taskname;
    private String taskdescription;//任务描述
    private String taskdate;//任务发布日期
    private String completiontime;//完成时间
    private String taskstatus;
    private String subtasks;
    private Integer categoryid;
    private String auditstatus;
}    