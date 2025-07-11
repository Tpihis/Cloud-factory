package com.ls.springmvc.controller.admin;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.User;
import com.ls.springmvc.vo.page.UserPageParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller(value = "adminUserController")
@RequestMapping(value = "/admin/user")
public class UserController {
    @Autowired
    private UserService userService;
    /*异步请求的返回值*/
    @Autowired
    private AjaxResponse ajaxResponse;
    /**
     * 跳转到adminpage页面
     *
     */
    @GetMapping(value = "/list")
    public String userList() {
        return "admin/user/userList";
    }

    @GetMapping(value="/search_pager")
    public String search_pager() {
        return "admin/user/searchPager";
    }

    @PostMapping(value = "/pageSearch")
    @ResponseBody
    public List<User> pageSearch() {
        return userService.pageSearch();
    }


    @PostMapping(value="/add")
    @ResponseBody
    public AjaxResponse add(@RequestBody User user) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode("123456"));
        // 获取当前时间
        LocalDateTime now = LocalDateTime.now();
        // 定义时间格式
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        // 格式化时间
        String formattedDateTime = now.format(formatter);
        user.setTime(formattedDateTime);
        boolean register = userService.registerUser(user);
        if(register){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("注册成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("注册失败");
        }
        return ajaxResponse;
    }

    @PostMapping(value="/delete")
    @ResponseBody
    public AjaxResponse delete(@RequestBody  User user) {
        boolean delete = userService.deleteUser(user.getUserid());
        if(delete){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("删除成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("删除失败");
        }
        return ajaxResponse;
    }
    @GetMapping(value="/findUserById")
    @ResponseBody
    public AjaxResponse findUserById(  User user) {
        user = userService.findUserById(user.getUserid());
        if(user != null){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("查询成功");
            ajaxResponse.setObj(user);
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("查询失败");
        }
        return ajaxResponse;
    }
    @PostMapping(value="/update")
    @ResponseBody
    public AjaxResponse update(@RequestBody  User user) {
        int update = userService.updateUser(user);
        if(update > 0){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("更新成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("更新失败");
        }
        return ajaxResponse;
    }
    // 停用或启用用户
    @PostMapping("/changeStatus")
    @ResponseBody
    public AjaxResponse changeUserStatus( User user) {

            // 调用Service方法进行停用/启用操作
            boolean success = userService.changeUserStatus(user);
            if (success) {
                ajaxResponse.setCode(0);
                ajaxResponse.setMsg("操作成功");
            } else {
                ajaxResponse.setCode(-1);
                ajaxResponse.setMsg("操作失败");
            }
        return ajaxResponse;
    }
    @PostMapping("/batchDelete")
    @ResponseBody
    public AjaxResponse batchDelete(@RequestBody Map<String, List<Long>> userids) {
        if (userids == null || userids.get("userids") == null || userids.get("userids").isEmpty()) {
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("请选择要删除的用户");
        }

        try {
            boolean deletedCount = userService.batchDelete(userids.get("userids"));
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("成功删除 " + deletedCount + " 条记录");
        } catch (Exception e) {
            ajaxResponse.setCode(-2);
            ajaxResponse.setMsg("批量删除失败: " + e.getMessage());
        }
        return ajaxResponse;
    }


    @PostMapping(value="/pageList")
    @ResponseBody
    public List<User> pageListUser(UserPageParam userPageParam) {
        userPageParam.setPageNum((userPageParam.getPageNum() == null || userPageParam.getPageNum()== 0)? 1 : userPageParam.getPageNum());
        userPageParam.setPageSize((userPageParam.getPageSize() == null || userPageParam.getPageSize()== 0)? 10000 : userPageParam.getPageSize());
        userPageParam.setPageNum((userPageParam.getPageNum()-1)*userPageParam.getPageSize());
        return userService.pageListUser(userPageParam);
    }

    @PostMapping(value="/totalCount")
    @ResponseBody
    public int totalUserCount(UserPageParam userPageParam) {
        return userService.totalUserCount(userPageParam);
    }

}
