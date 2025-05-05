package com.ls.springmvc.controller.admin;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.AjaxResponse;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller(value = "adminResourceController")
@RequestMapping(value = "/admin/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AjaxResponse ajaxResponse;

    @RequestMapping(value = "/list")
    public String resourceList() {
        return "admin/resource/resourceList";
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
}
