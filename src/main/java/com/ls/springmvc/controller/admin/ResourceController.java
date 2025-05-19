package com.ls.springmvc.controller.admin;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller(value = "adminResourceController")
@RequestMapping(value = "/admin/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AjaxResponse ajaxResponse;

    @GetMapping(value = "/list")
    public String resourceList() {
        return "admin/resource/resourceList";
    }
    @GetMapping(value = "/add")
    public String resourceAdd() {
        return "admin/resource/resourceAdd";
    }

    @PostMapping(value = "/pageSearch")
    @ResponseBody
    public List<Resource> pageSearch() {
        return resourceService.pageSearch();
    }

    @PostMapping(value="/delete")
    @ResponseBody
    public AjaxResponse delete(@RequestBody Resource resource) {
        boolean delete = resourceService.deleteResource(resource.getResourceid());
        if(delete){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("删除成功");
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("删除失败");
        }
        return ajaxResponse;
    }

    @PostMapping(value="/add")
    @ResponseBody
    public AjaxResponse add( @RequestBody Resource resource) {
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
        int Add = resourceService.addResource(resource);
        if(Add>0){
            ajaxResponse.setCode(0);
            ajaxResponse.setMsg("添加成功");
            ajaxResponse.setObj(Add);
//            return "admin/resource/resourceList";
        }else{
            ajaxResponse.setCode(-1);
            ajaxResponse.setMsg("添加失败");
//            return "admin/resource/resourceAdd";
        }
        return ajaxResponse;
    }
}
