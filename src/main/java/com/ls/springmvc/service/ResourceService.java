package com.ls.springmvc.service;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;


import java.util.List;
import java.util.Map;

public interface ResourceService {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
    int addResource(Resource resource);

    Resource getResourceById(Integer resourceId);
    // 分页模糊查询
    PageData<Resource> pageSearch(ResourceSearchParam param);
    //扣减库存
    int deductStock(Integer resourceId,  Integer quantity);
    //检查库存
    boolean checkStock(Integer resourceId, Integer quantity);
    List<Resource> getResourcesByIds(List<Integer> ids);
    List<Map<String, Integer>> getAllResourceCategoryCounts(ResourceSearchParam  param);
}
