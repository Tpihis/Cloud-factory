package com.ls.springmvc.service;

import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;

import java.util.List;

public interface TaskService {
//    增删改查
    public int addTask(Task task);
    public int deleteTask(int id);
    public int updateTask(Task task);
    public Task findTaskById(int id);
    //分页查询
    public PageResult<Task> getTaskList(int pageNum, int pageSize);
}
