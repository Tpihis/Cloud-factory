package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ResourceDao {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
    boolean addResource(Resource resource);

    Resource getResourceById(Integer resourceid);
    // 分页模糊查询
    List<Resource> pageListResource(ResourceSearchParam param);

    // 查询总数
    int totalResourceCount(ResourceSearchParam param);
    int deductStock(@Param(value = "resourceid")Integer resourceid, @Param(value = "quantity") Integer quantity);
    boolean checkStock(@Param(value = "resourceid")Integer resourceid, @Param(value = "quantity") Integer quantity);
    List<Resource> selectByIds(List<Integer> ids);
    List<Map<String, Integer>> getAllResourceCategoryCounts( ResourceSearchParam  param);

}
