package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.page.ResourceSearchParam;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface ResourceDao {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
    int addResource(Resource resource);

    Resource getResourceById(Integer resourceid);
    // 分页模糊查询
    List<Resource> pageListResource(ResourceSearchParam param);

    // 查询总数
    int totalResourceCount(ResourceSearchParam param);
    int deductStock(@Param(value = "resourceid")Integer resourceid, @Param(value = "quantity") Integer quantity);
    boolean checkStock(@Param(value = "resourceid")Integer resourceid, @Param(value = "quantity") Integer quantity);
    List<Resource> selectByIds(List<Integer> ids);
    List<Map<String, Integer>> getAllResourceCategoryCounts( ResourceSearchParam  param);

    boolean updateResource(Resource resource);
    int updateResourceStatus(@Param("resourceId") Integer resourceId,
                             @Param("status") Integer status);
    List<Resource> getResourcesByUserId(Integer userId);

    // 新增方法：恢复库存
    int restoreStock(Integer resourceId, Integer quantity);

    @Select("SELECT * FROM resource")
    List<Resource> selectAll();

    @Select("SELECT * FROM resource WHERE resourceid = #{resourceid}")
    Resource selectById(Integer id);

    @Update("UPDATE resource SET resourcename=#{resourcename}, resourcedescription=#{resourcedescription} WHERE resourceid=#{resourceid}")
    void update(Resource resource);

    @Delete("DELETE FROM resource WHERE resourceid = #{resourceid}")
    void delete(Integer id);
}
