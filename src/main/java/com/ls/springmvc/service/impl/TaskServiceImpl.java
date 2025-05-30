package com.ls.springmvc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ls.springmvc.dao.TaskDao;
import com.ls.springmvc.service.TaskService;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskDao taskDao;
    @Override
    public int addTask(Task task) {
        taskDao.addTask(task);
        return task.getTaskid();
    }

    @Override
    public int deleteTask(int id) {
        return taskDao.deleteTask(id);
    }

    @Override
    public int updateTask(Task task) {
        return taskDao.updateTask(task);
    }

    @Override
    public Task findTaskById(int id) {
        return taskDao.findTaskById(id);
    }

    @Override
    public PageResult<Task> getTaskList(int pageNum, int pageSize) {
//        启用pagehelper分页插件
        PageHelper.startPage(pageNum, pageSize);
        List<Task> tasks = taskDao.getTaskList();
        // 通过 PageInfo 获取分页信息
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);
        return new PageResult<Task>(pageInfo.getTotal(), pageInfo.getList());

    }
}
