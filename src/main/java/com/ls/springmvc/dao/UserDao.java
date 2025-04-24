package com.ls.springmvc.dao;


import com.ls.springmvc.vo.User;
import org.apache.ibatis.annotations.Mapper;

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

    // 修改用户
    int updateUser(User user);

    // 删除用户
    int deleteUser(Integer userid);
}