package com.ls.springmvc.controller.admin;

import com.ls.springmvc.Utils.TimeUtil;
import com.ls.springmvc.service.TaskService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;
import com.ls.springmvc.vo.api.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller(value = "adminTaskController")
@RequestMapping(value = "/admin/task")
public class TaskController {

    @Autowired
    private TaskService taskService;
    @Autowired
    private UserService userService;

    @GetMapping(value = "/list")
    public String taskList() {
        return "admin/task/taskList";
    }

    //增删改查
    @PostMapping(value = "/addTask")
    @ResponseBody
    public Result<Task> addTask(Task task, Principal principal) {
        if (task.getUserid() == null) {
            Integer userid = userService.getCurrentUserId(principal);
            task.setUserid(userid);
        }
        int taskid = taskService.addTask(task);
        if (taskid > 0) {
            return Result.success(null);
        }
        return Result.error("添加失败");
    }
    @PostMapping(value = "/deleteTask")
    @ResponseBody
    public Result<Task> deleteTask(Task task) {
        if (task.getTaskid() != null) {
            int result = taskService.deleteTask(task.getTaskid());
            if (result > 0) {
                return Result.success(null);
            }else {
                return Result.error("删除失败");
            }
        }
        return Result.error("没有taskId");
    }
    @PostMapping(value = "/updateTask")
    @ResponseBody
    public Result<Task> updateTask(Task task) {
        if (task.getTaskid() == null) {
            return Result.error("没有taskId");
        }
        int result = taskService.updateTask(task);
        if (result > 0) {
            return Result.success(null);
        }else {
            return Result.error("修改失败");
        }
    }
    @PostMapping(value = "/findTaskById")
    @ResponseBody
    public Result<Task> findTaskById(Task task) {
        if (task.getTaskid()!= null) {
            task = taskService.findTaskById(task.getTaskid());
            if (task != null) {
                return Result.success(task);
            }else {
                return Result.error("查询失败");
            }
        }
        return Result.error("没有taskId");
    }
    //    分页查询
    @PostMapping(value = "/getTaskList")
    @ResponseBody
    public Result<PageResult<Task>> getTaskList(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size",defaultValue = "0") int size) {
        PageResult<Task> pageResult = taskService.getTaskList(page, size);
        if (pageResult!= null) {
            return Result.success(pageResult);
        }else {
            return Result.error("查询失败");
        }
    }
}
