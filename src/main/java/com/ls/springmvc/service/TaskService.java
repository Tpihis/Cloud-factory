package com.ls.springmvc.service;

import com.ls.springmvc.vo.Subtask;
import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;

import java.util.List;
import java.util.Map;

public interface TaskService {
//    增删改查
    public int addTask(Task task);
    public int deleteTask(int id);
    public int updateTask(Task task);
    public Task findTaskById(int id);
    //分页查询
    public PageResult<Task> getTaskList(int pageNum, int pageSize);

    int cancelTask(int taskId);

    // 接受任务
    int acceptTask(int taskId, int userId);

    PageResult<Task> getTaskListByParams(int pageNum, int pageSize, Map<String, Object> params);

    Map<String, Object> getTaskStatistics(Map<String, Object> params);

    List<Map<String, Object>> getStatusCounts(Map<String, Object> params);

    List<Task> getTaskListByUserId(Integer userId);

     void decomposeAndSaveTask(Integer taskid);

    /**
     * 根据任务ID获取子任务列表
     * @param taskId 任务ID
     * @return 子任务列表
     */
    List<Subtask> getSubtasksByTaskId(Integer taskId);

//    更新子任务
    int updateSubtask(Subtask subtask);
}
