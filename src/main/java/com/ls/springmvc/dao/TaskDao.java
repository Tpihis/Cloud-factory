package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Task;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TaskDao {
//增删改查
    public int addTask(Task task);
    public int deleteTask(int id);
    public int updateTask(Task task);
    public Task findTaskById(int id);
    //分页查询
    public List<Task> getTaskList();
}
