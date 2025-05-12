package com.ls.springmvc.dao;


import com.ls.springmvc.vo.User;
import com.ls.springmvc.vo.page.UserPageParam;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;



@Mapper
public interface UserDao {
    // 根据id查询用户
    User findUserById(Integer userid);

    //根据用户名查询用户
    User findUserByUsername(String username);

    // 查询所有用户
    List<User> findAllUser();

    // 添加用户
    boolean addUser(User user);
    List<User> pageSearch();

    // 修改用户
//    boolean updateUser(User user);

    // 删除用户
    boolean deleteUser(Integer userid);

    // 更新用户状态（停用 / 启用）
    boolean changeUserStatus(User user);

    boolean batchDelete(@Param("userids") List<Long> userids);

    //通过注解(静态)和xml里面(动态)两种方式编写SQL语句
    int updateUser(User user);
    //查询满足条件的某一页用户
    List<User> pageListUser(UserPageParam userPageParam);
    //查询满足条件的所有用户数
    int totalUserCount(UserPageParam userPageParam);
}