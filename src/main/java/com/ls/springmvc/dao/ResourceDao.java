package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

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
}
