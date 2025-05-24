package com.ls.springmvc.controller.user;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller(value = "userResourceController")
@RequestMapping(value = "/user/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AjaxResponse ajaxResponse;
    @Autowired
    private UserService userService;

    @GetMapping("/display")
    public String resourceDisplay(){
        return "/user/resourceDisplay";
    }

    @GetMapping("/details")
    public String resourceDetails(){
        return "/user/resourceDetails";
    }
    @GetMapping("/publish")
    public String resourcePublish(){
        return "/user/resourcePublishing";
    }

    @PostMapping(value = "/pageSearch")
    @ResponseBody
    public List<Resource> pageSearch() {
        return resourceService.pageSearch();
    }

    // 分页模糊查询
    @PostMapping("/page_Search")
    @ResponseBody
    public AjaxResponse pageSearch(ResourceSearchParam param) {
        PageData<Resource> pageData = resourceService.pageSearch(param);
        if (pageData == null) {
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("查询失败");
            ajaxResponse.setObj(null);
        }else {
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("查询成功");
            ajaxResponse.setObj(pageData);
        }
        return ajaxResponse;
    }
    @GetMapping("/{resourceId}")
    @ResponseBody
    public AjaxResponse getResourceDetail(@PathVariable("resourceId") Integer resourceId) {
        Resource resource = resourceService.getResourceById(resourceId);
        if (resource == null) {
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("资源不存在");
            ajaxResponse.setObj(null);
        }else{
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("获取资源成功");
            ajaxResponse.setObj(resource);
        }
        return ajaxResponse;
    }

    @PostMapping(value="/publish")
    @ResponseBody
    public AjaxResponse resourcePublish(@RequestBody Resource resource, Principal principal) {

        //获取到登录的用户名 这里的User对象是Spring-Security提供的User
        // 设置当前用户ID（假设用户已登录）
        Integer userid = userService.getCurrentUserId(principal);
        if(userid == null) {
            return new AjaxResponse(401, "用户未登录", null);
        }

        if(resource.getResourcedate() == null || resource.getResourcedate().isEmpty()) {
            // 获取当前时间
            LocalDateTime now = LocalDateTime.now();
            // 定义时间格式
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            // 格式化时间
            String formattedDateTime = now.format(formatter);
            resource.setResourcedate(formattedDateTime);
        }
        resource.setAuditstatus("待审");
        resource.setUserid(userid);
        int Add = resourceService.addResource(resource);
        if(Add > 0){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("添加成功");
            ajaxResponse.setObj(Add);//返回资源id
//            return "admin/resource/resourceList";
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("添加失败");
//            return "admin/resource/resourceAdd";
        }
        return ajaxResponse;
    }
    // 统计所有资源分类的数量
    @PostMapping("/category_counts")
    @ResponseBody
    public AjaxResponse getAllResourceCategoryCounts( ResourceSearchParam param) {
        List<Map<String, Integer>> counts = resourceService.getAllResourceCategoryCounts(param);
        Map<String, Object> result = new HashMap<>();
        result.put("data", counts);
        return new AjaxResponse(0, "查询成功", result);
    }
    @PostMapping("/batch")
    @ResponseBody
    public AjaxResponse getResourcesBatch(@RequestParam String ids) {
       try {
            List<Integer> resourceIds = Arrays.stream(ids.split(","))
                .map(Integer::parseInt)
                .collect(Collectors.toList());
            List<Resource> resources = resourceService.getResourcesByIds(resourceIds);
            return  new AjaxResponse(200,"获取资源详情成功",resources);
        } catch (Exception e) {
            return new AjaxResponse(500, "获取资源详情失败: " + e.getMessage(),null);
        }
    }

    @PostMapping("/updateStatus")
    @ResponseBody
    public AjaxResponse updateStatus(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            Integer resourceId = (Integer) params.get("resourceId");
            Integer status = (Integer) params.get("status");

            // 验证资源所有者
            Resource resource = resourceService.getResourceById(resourceId);
            Integer currentUserId = userService.findUserByUsername(principal.getName()).getUserid();

            if (!resource.getUserid().equals(currentUserId)) {
                return new AjaxResponse(403, "无权操作此资源", null);
            }

            boolean success = resourceService.updateResourceStatus(resourceId, status);
            return success ? new AjaxResponse(0, "状态更新成功", null)
                    : new AjaxResponse(-1, "状态更新失败", null);
        } catch (Exception e) {
            return new AjaxResponse(500, "服务器错误: " + e.getMessage(), null);
        }
    }
    @PostMapping("/delete")
    @ResponseBody
    public AjaxResponse deleteResource(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            Integer resourceId = (Integer) params.get("resourceId");

            // 验证资源所有者
            Resource resource = resourceService.getResourceById(resourceId);
            Integer currentUserId = userService.findUserByUsername(principal.getName()).getUserid();

            if (!resource.getUserid().equals(currentUserId)) {
                return new AjaxResponse(403, "无权操作此资源", null);
            }

            boolean success = resourceService.deleteResource(resourceId);
            return success ? new AjaxResponse(0, "删除成功", null)
                    : new AjaxResponse(-1, "删除失败", null);
        } catch (Exception e) {
            return new AjaxResponse(500, "服务器错误: " + e.getMessage(), null);
        }
    }
    @GetMapping("/byUser")
    @ResponseBody
    public AjaxResponse getUserResources(Principal principal) {
        try {
            // 获取当前登录用户
            String username = principal.getName();
            User user = userService.findUserByUsername(username);
            if (user == null) {
                return new AjaxResponse(404, "用户不存在", null);
            }

            // 查询资源
            List<Resource> resources = resourceService.getResourcesByUserId(user.getUserid());

            // 返回标准响应
            return new AjaxResponse(0, "查询成功", resources);
        } catch (Exception e) {
            return new AjaxResponse(500, "查询失败: " + e.getMessage(), null);
        }
    }
}
