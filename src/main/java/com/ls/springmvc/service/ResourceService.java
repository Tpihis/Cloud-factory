package com.ls.springmvc.service;

import com.ls.springmvc.vo.Resource;


import java.util.List;

public interface ResourceService {
    List<Resource> pageSearch();
    boolean deleteResource(Integer resourceid);
}
