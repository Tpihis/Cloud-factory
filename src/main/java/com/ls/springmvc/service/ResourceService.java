package com.ls.springmvc.service;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;


import java.util.List;

public interface ResourceService {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
    boolean addResource(Resource resource);

    Resource getResourceById(Integer resourceId);
    // 分页模糊查询
    PageData<Resource> pageSearch(ResourceSearchParam param);
}
