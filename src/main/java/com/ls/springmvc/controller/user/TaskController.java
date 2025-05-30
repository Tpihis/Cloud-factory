package com.ls.springmvc.controller.user;

import com.ls.springmvc.Utils.TimeUtil;
import com.ls.springmvc.service.TaskService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;
import com.ls.springmvc.vo.api.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller(value = "userTaskController")
@RequestMapping(value = "/user/task")
public class TaskController {

    @Autowired
    private TaskService taskService;
    @Autowired
    private UserService userService;

    @GetMapping("/publish")
    public String taskPublishing(){
        return "/user/taskPublishing";
    }
//    增删改查
    @RequestMapping(value = "/addTask")
    @ResponseBody
    public Result<Task> addTask(Task task, Principal principal) {
        Integer userid = userService.getCurrentUserId(principal);
        task.setUserid(userid);
        task.setTaskstatus("待完成");
        task.setAuditstatus("待审");
        task.setTaskdate(TimeUtil.getCurrentDateTime());
        int taskid = taskService.addTask(task);
    if (taskid > 0) {
    return Result.success(null);
    }
         return Result.error("添加失败");
    }
    @RequestMapping(value = "/deleteTask")
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
    @RequestMapping(value = "/updateTask")
    @ResponseBody
    public Result<Task> updateTask(Task task) {
        int result = taskService.updateTask(task);
        if (result > 0) {
            return Result.success(null);
        }else {
            return Result.error("修改失败");
        }
    }
    @RequestMapping(value = "/findTaskById")
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
    @GetMapping(value = "/getTaskList")
    @ResponseBody
    public Result<PageResult<Task>> getTaskList(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size",defaultValue = "10") int size) {
        PageResult<Task> pageResult = taskService.getTaskList(page, size);
        if (pageResult!= null) {
            return Result.success(pageResult);
        }else {
            return Result.error("查询失败");
        }
    }
}
