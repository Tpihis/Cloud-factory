package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Resource;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ResourceDao {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
    boolean addResource(Resource resource);
}
