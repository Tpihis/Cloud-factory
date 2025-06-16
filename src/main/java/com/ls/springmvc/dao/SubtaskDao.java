package com.ls.springmvc.dao;

import com.ls.springmvc.vo.Subtask;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SubtaskDao {

    int insert(Subtask subtask);

    /**
     * 根据任务ID查询子任务
     * @param taskId 任务ID
     * @return 子任务列表
     */
    List<Subtask> getSubtasksByTaskId(@Param("taskId") Integer taskId);
//    更新子任务
    int updateSubtask(Subtask subtask);
}
