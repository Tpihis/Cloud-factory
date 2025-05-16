package com.ls.springmvc.controller.user;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.xml.transform.Result;
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
    public AjaxResponse resourcePublish(@RequestBody Resource resource) {
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
        boolean Add = resourceService.addResource(resource);
        if(Add){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("添加成功");
//            return "admin/resource/resourceList";
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("添加失败");
//            return "admin/resource/resourceAdd";
        }
        return ajaxResponse;
    }
//    // 新增分类统计接口
//    @GetMapping("/category-stats")
//    public Result getCategoryStats(
//            @RequestParam(required = false) String keyword) {
//
//        Map<String, Integer> stats = new HashMap<>();
//
//        // 全部资源数（受搜索关键词影响）
//        stats.put("all", resourceMapper.countByKeyword(keyword));
//
//        // 各分类资源数
//        stats.put("1", resourceMapper.countByCategoryAndKeyword(1, keyword));
//        stats.put("2", resourceMapper.countByCategoryAndKeyword(2, keyword));
//        stats.put("3", resourceMapper.countByCategoryAndKeyword(3, keyword));
//        stats.put("4", resourceMapper.countByCategoryAndKeyword(4, keyword));
//
//        return Result.success().put("data", stats);
//    }
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
}
