package com.ls.springmvc.vo;

import lombok.Data;

@Data
public class Task {
    private Integer taskid;  //任务ID
    private Integer userid;  //用户ID
    private String taskname;    //任务名称
    private String taskdescription;//任务描述
    private String taskdate;//任务发布日期
    private String completiontime;//完成时间
    private String taskstatus;  //任务状态    待完成/已完成/已取消
    private String subtasks;    //子任务列表，用逗号分隔
    private Integer categoryid; //任务分类ID  1: '设备任务', 2: '工艺任务',3: '设计任务',4: '制造任务'
    private String auditstatus; //审核状态    驳回/通过/待审
    private String orderids; //订单ID列表，用逗号分隔
    /* <!--
    taskid;  //任务ID
    userid;  //用户ID
    taskname;    //任务名称
    taskdescription;//任务描述
    taskdate;//任务发布日期
    completiontime;//完成时间
    taskstatus;  //任务状态    待完成/已完成/已取消
    subtasks;    //子任务列表，用逗号分隔
    categoryid; //任务分类ID  1: '设备任务', 2: '工艺任务',3: '设计任务',4: '制造任务'
    auditstatus; //审核状态    驳回/通过/待审
    orderids; //订单ID列表，用逗号分隔
    -->*/
}    