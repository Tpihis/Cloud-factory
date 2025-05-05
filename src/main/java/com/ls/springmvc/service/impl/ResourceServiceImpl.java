package com.ls.springmvc.service.impl;

import com.ls.springmvc.dao.ResourceDao;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.ServiceMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("resourceService")
@Transactional
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ServiceMessage serviceMessage;

    @Autowired
    private ResourceDao resourceDao;

    @Override
    public List<Resource> pageSearch() {
        return resourceDao.pageSearch();
    }

    @Override
    public boolean deleteResource(Integer resourceid) {
        boolean result = false;
        try {
            resourceDao.deleteResource(resourceid);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result;
        }
    }
}
