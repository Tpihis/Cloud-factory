package com.ls.springmvc.service;

import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface UserService extends UserDetailsService {
    public boolean registerUser(User user);
    public ServiceMessage loginUser(User user);
    User findUserById(Integer userid);
    User findUserByUsername(String username);
}
