package com.ls.springmvc.service;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.api.PageResult;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.springframework.transaction.annotation.Transactional;


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
    boolean updateResource(Resource resource);
    public boolean updateResourceStatus(Integer resourceId, Integer status);
    List<Resource> getResourcesByUserId(Integer userId);
    // 新增方法：恢复库存
    boolean restoreStock(Integer resourceId, int quantity);
    public PageResult<Resource> list(int page, int size);
    public Resource getById(Integer id);
    public void update(Resource resource);
    public void delete(Integer id);
}
