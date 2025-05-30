package com.ls.springmvc.controller.api;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.api.PageResult;
import com.ls.springmvc.vo.api.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/resources")
public class ResourceApiController {
    @Autowired
    private ResourceService resourceService;

    @GetMapping
    public Result<PageResult<Resource>> list(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size",defaultValue = "10") int size) {
        PageResult<Resource> pageResult = resourceService.list(page, size);
        return Result.success(pageResult);
    }
    // 查看单个
    @GetMapping("/{id}")
    public Result<Resource> get(@PathVariable(name = "id") Integer id) {
        Resource resource = resourceService.getById(id);
        return Result.success(resource);
    }

    // 编辑
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable(name = "id") Integer id,
                               @RequestBody Resource resource) {
        resource.setResourceid(id);
        resourceService.update(resource);
        return Result.success(null);
    }

    // 删除
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable(name = "id") Integer id) {
        resourceService.delete(id);
        return Result.success(null);
    }
}

