package com.ls.springmvc.service;

import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import com.ls.springmvc.vo.page.UserPageParam;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.security.Principal;
import java.util.List;

public interface UserService extends UserDetailsService {
    public boolean registerUser(User user);
    public boolean deleteUser(Integer userid);
    public int updateUser(User user);
    public ServiceMessage loginUser(User user);
    User findUserById(Integer userid);
    User findUserByUsername(String username);
    List<User> pageSearch();
    public boolean changeUserStatus(User user);
    public boolean batchDelete(List<Long> userIds);
    //查询满足条件的某一页用户
    List<User> pageListUser(UserPageParam userPageParam);
    //查询满足条件的所有用户数
    int totalUserCount(UserPageParam userPageParam);

    //获得当前登录用户id
    Integer getCurrentUserId(Principal principal);
    //获得当前登录用户信息
    User getCurrentUser(Authentication authentication);
}
