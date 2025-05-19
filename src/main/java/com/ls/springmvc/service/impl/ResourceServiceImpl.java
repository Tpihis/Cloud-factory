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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public int addResource(Resource resource) {

        try {
            resourceDao.addResource(resource);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return resource.getResourceid();
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

    // 扣减库存
    @Override
    @Transactional
    public int deductStock(Integer resourceid, Integer quantity) {
        int result = 0;
        // 验证参数
        if (resourceid == null || quantity == null || quantity <= 0) {
            throw new IllegalArgumentException("参数不合法");
        }
        try {
            result = resourceDao.deductStock(resourceid, quantity);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return result;
        }
    }
//检查库存
    @Override
    public boolean checkStock(Integer resourceid, Integer quantity) {
        boolean result = false;
        // 验证参数
        if (resourceid == null || quantity == null) {
            throw new IllegalArgumentException("参数不合法");
        }
        try {
            // 调用DAO层检查库存
            result = resourceDao.checkStock(resourceid, quantity);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            return result;
        }
    }
    @Override
    public List<Resource> getResourcesByIds(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            return new ArrayList<>();
        }
        return resourceDao.selectByIds(ids);
    }

    @Override
    public List<Map<String, Integer>> getAllResourceCategoryCounts(ResourceSearchParam  param) {
        List<Map<String, Integer>> countsList = new ArrayList<Map<String, Integer>>();
        try {
            countsList = resourceDao.getAllResourceCategoryCounts(param);
            System.out.println("查询资源分类数量成功"+countsList);
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("查询资源分类数量失败"+e.getMessage());
//            return new HashMap<>();
        }
        // 计算全部订单数量（更健壮地实现）
        int totalCount =  0 ;
        for (Map<String, Integer> countMap : countsList) {
            totalCount +=  countMap.get("count");
        }

        Map<String, Integer> totalMap = new HashMap<>();
        totalMap.put("categoryid", -1);
        totalMap.put("count", totalCount);
        countsList.add(totalMap);
        return countsList;
    }
}
