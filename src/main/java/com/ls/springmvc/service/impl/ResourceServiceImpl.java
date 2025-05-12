package com.ls.springmvc.service.impl;

import com.ls.springmvc.dao.ResourceDao;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.page.PageData;
import com.ls.springmvc.vo.page.ResourceSearchParam;
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

    @Override
    public boolean addResource(Resource resource) {
        boolean result = false;
        try {
            resourceDao.addResource(resource);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return result;
        }
    }

    @Override
    public Resource getResourceById(Integer resourceid) {
        return resourceDao.getResourceById(resourceid);
    }

    @Override
    public PageData<Resource> pageSearch(ResourceSearchParam param) {
        // 参数校验
        if (param.getPageNum() == null || param.getPageNum() < 1) {
            param.setPageNum(1);
        }
        if (param.getPageSize() == null || param.getPageSize() <= 0) {
            param.setPageSize(6);
        }

        // 计算偏移量（注意与前端约定pageNum从1开始）
        int offset = (param.getPageNum() - 1) * param.getPageSize();
        param.setPageNum(offset);

        List<Resource> list = resourceDao.pageListResource(param);
        int total = resourceDao.totalResourceCount(param);

        return new PageData<>(list, total, param.getPageNum(), param.getPageSize());
    }
}
