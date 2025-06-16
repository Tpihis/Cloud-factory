package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TaskDao {
//增删改查
    public int addTask(Task task);
    public int deleteTask(int id);
    public int updateTask(Task task);
    public Task findTaskById(int id);
    //分页查询
    public List<Task> getTaskList();

    // 支持搜索和筛选的分页查询
    public List<Task> getTaskListByParams(Map<String, Object> params);
    // 获取符合条件的任务总数
    public int getTaskCountByParams(Map<String, Object> params);
    List<Task> getTaskList(Map<String, Object> params);

    int getTaskCount(Map<String, Object> params);

    List<Map<String, Object>> getTaskStatusCounts(Map<String, Object> params);
    int deleteTask(@Param("taskId") Integer taskId);
    List<Task> findByUserId(@Param("userId") Integer userId);

}
