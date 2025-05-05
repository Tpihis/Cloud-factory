package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Subtask {
    private Integer subtaskid;
    private Integer taskid;
    private String subtaskname;
    private String subtaskstatus;
    private String resourcerequirements;
    private String estimatedtime;
    private String assignedresources;
}    