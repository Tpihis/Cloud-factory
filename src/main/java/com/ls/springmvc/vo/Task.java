package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Task {
    private Integer taskid;
    private Integer userid;
    private String taskname;
    private String taskdescription;
    private String taskdate;
    private String completiontime;
    private String taskstatus;
    private String subtasks;
    private Integer categoryid;
    private String auditstatus;
}    