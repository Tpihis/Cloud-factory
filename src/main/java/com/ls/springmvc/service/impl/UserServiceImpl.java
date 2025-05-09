package com.ls.springmvc.service.impl;

import com.ls.springmvc.dao.UserDao;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import com.ls.springmvc.vo.UserPageParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service("userService")
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private ServiceMessage serviceMessage;

    @Autowired
    private UserDao userDao;

    public boolean registerUser(User user) {
        boolean result = false;
        try {
            userDao.addUser(user);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result;
        }
    }

    @Override
    public boolean deleteUser(Integer userid) {
        boolean result = false;
        try {
            userDao.deleteUser(userid);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result;
        }
    }

    @Override
    public int updateUser(User user) {
        int result = 0;
        try {
            result = userDao.updateUser(user);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result;
        }
    }


    public ServiceMessage loginUser(User user) {
        String inputPassword = user.getPassword();
        User existUser = userDao.findUserByUsername(user.getUsername());
        if (existUser == null) {
            serviceMessage.setCode(-1);
            serviceMessage.setMsg("用户不存在");
        } else if (!existUser.getPassword().equals(inputPassword)) {
            serviceMessage.setCode(-2);
            serviceMessage.setMsg("用户名或密码错误");
        } else {
            serviceMessage.setCode(0);
            serviceMessage.setMsg("登录成功");
            serviceMessage.setObj(existUser);
        }
        return serviceMessage;
    }

    @Override
    public User findUserById(Integer userid) {
        return userDao.findUserById(userid);
    }

    @Override
    public User findUserByUsername(String username) {
        return userDao.findUserByUsername(username);
    }
    @Override
    public List<User> pageSearch() {
        return userDao.pageSearch();
    }

    // 停用或启用用户
    public boolean changeUserStatus(User user) {
        try {
            return userDao.changeUserStatus(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    @Transactional
    public boolean batchDelete(List<Long> userids) {
        if (userids == null || userids.isEmpty()) {
            throw new IllegalArgumentException("用户ID列表不能为空");
        }

        // 可以在这里添加业务逻辑校验
        // 例如检查这些用户是否可以被删除

        return userDao.batchDelete(userids);
    }

    @Override
    public List<User> pageListUser(UserPageParam userPageParam) {
        return userDao.pageListUser(userPageParam);
    }

    @Override
    public int totalUserCount(UserPageParam userPageParam) {
        return userDao.totalUserCount(userPageParam);
    }
    @Override
    public UserDetails loadUserByUsername(String username) {
        UserDetails user = null;
        try {
            // 搜索数据库以匹配用户登录名.
            User existUser = userDao.findUserByUsername(username);
            user = new org.springframework.security.core.userdetails.User(
                    existUser.getUsername(), existUser.getPassword(), true, true,
                    true, true,
                    getAuthorities(existUser.getRole()));
        } catch (Exception e) {
            throw new UsernameNotFoundException("Error in retrieving user");
        }
        return user;
    }

    public Collection<GrantedAuthority> getAuthorities(Integer role) {
        List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(2);

        // 所有的用户默认拥有ROLE_USER权限
        authList.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return "ROLE_USER";
            }
        });
        // 如果参数access为1.则拥有ROLE_ADMIN权限
        if (role.compareTo(1) == 0) {
            authList.add(new GrantedAuthority() {
                @Override
                public String getAuthority() {
                    return "ROLE_ADMIN";
                }
            });
        }
        return authList;
    }

}