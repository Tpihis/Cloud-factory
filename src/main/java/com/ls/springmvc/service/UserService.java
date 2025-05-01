package com.ls.springmvc.service;

import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    public boolean registerUser(User user);
    public boolean deleteUser(Integer userid);
    public boolean updateUser(User user);
    public ServiceMessage loginUser(User user);
    User findUserById(Integer userid);
    User findUserByUsername(String username);
    List<User> pageSearch();
    public boolean changeUserStatus(User user);
    public boolean batchDelete(List<Long> userIds);

}
