package com.ls.springmvc.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ls.springmvc.dao.SubtaskDao;
import com.ls.springmvc.dao.TaskDao;
import com.ls.springmvc.service.TaskService;
import com.ls.springmvc.vo.Resource;
import com.ls.springmvc.vo.Subtask;
import com.ls.springmvc.vo.Task;
import com.ls.springmvc.vo.api.PageResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskDao taskDao;
    @Autowired
    private SubtaskDao subtaskDao;
    @Override
    public int addTask(Task task) {
        taskDao.addTask(task);
        return task.getTaskid();
    }

    @Override
    public int deleteTask(int id) {
        return taskDao.deleteTask(id);
    }

    @Override
    public int updateTask(Task task) {
        return taskDao.updateTask(task);
    }

    @Override
    public Task findTaskById(int id) {
        return taskDao.findTaskById(id);
    }

    @Override
    public PageResult<Task> getTaskList(int pageNum, int pageSize) {
//        启用pagehelper分页插件
        PageHelper.startPage(pageNum, pageSize);
        List<Task> tasks = taskDao.getTaskList();
        // 通过 PageInfo 获取分页信息
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);
        return new PageResult<Task>(pageInfo.getTotal(), pageInfo.getList());
    }


    @Override
    public List<Task> getTaskListByUserId(Integer userId) {
        return taskDao.findByUserId(userId);
    }

    @Override
    public List<Map<String, Object>> getStatusCounts(Map<String, Object> params) {
        // 使用现有 DAO 方法
        return taskDao.getTaskStatusCounts(params);
    }
    @Override
    public PageResult<Task> getTaskListByParams(int pageNum, int pageSize, Map<String, Object> params) {
        PageHelper.startPage(pageNum, pageSize);

        // 处理排序
        if (params.containsKey("orderBy")) {
            PageHelper.orderBy(params.get("orderBy").toString());
        }

        List<Task> tasks = taskDao.getTaskList(params);
        PageInfo<Task> pageInfo = new PageInfo<>(tasks);

        return new PageResult<>(pageInfo.getTotal(), pageInfo.getList());
    }

    @Override
    public Map<String, Object> getTaskStatistics(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();

        // 获取总任务数
        int totalTasks = taskDao.getTaskCount(params);
        result.put("totalTasks", totalTasks);

        // 获取进行中任务数
        Map<String, Object> inProgressParams = new HashMap<>(params);
        inProgressParams.put("taskstatus", "进行中");
        int inProgressTasks = taskDao.getTaskCount(inProgressParams);
        result.put("inProgressTasks", inProgressTasks);

        // 获取状态统计
        List<Map<String, Object>> statusCounts = taskDao.getTaskStatusCounts(params);
        result.put("statusCounts", statusCounts);

        return result;
    }

    @Override
    public int acceptTask(int taskId, int userId) {
        // 更新任务状态和接受者
        Task task = new Task();
        task.setTaskid(taskId);
        task.setTaskstatus("进行中"); // 接受后状态改为进行中
        return taskDao.updateTask(task);
    }

    @Override
    public int cancelTask(int taskId) {
        Task task = taskDao.findTaskById(taskId);
        if (task == null) {
            throw new RuntimeException("任务不存在");
        }
        task.setTaskstatus("已取消");
        return taskDao.updateTask(task);
    }

    @Transactional
    public void decomposeAndSaveTask(Integer taskid) {
        // 1. 获取原始任务
        Task task = taskDao.findTaskById(taskid);
        if (task == null) {
            throw new IllegalArgumentException("任务不存在");
        }

        // 2. 根据任务ID生成预设子任务
        List<Subtask> subtasks = generateSubtasks(taskid);

        // 3. 保存子任务到数据库
        for (Subtask subtask : subtasks) {
            subtaskDao.insert(subtask);
        }

        // 4. 更新任务的子任务列表
        String newSubtaskIds = subtasks.stream()
                .map(sub -> sub.getSubtaskid().toString())
                .collect(Collectors.joining(","));

        // 合并已有的子任务ID
        String existingSubtasks = task.getSubtasks();
        if (existingSubtasks != null && !existingSubtasks.isEmpty()) {
            task.setSubtasks(existingSubtasks + "," + newSubtaskIds);
        } else {
            task.setSubtasks(newSubtaskIds);
        }

        // 5. 更新任务
        taskDao.updateTask(task);
    }

    // 生成预设的子任务（三个固定例子）
    private List<Subtask> generateSubtasks(Integer taskid) {
        switch (taskid) {
            case 1:
                return Arrays.asList(
                        // 自行车
                        new Subtask(taskid, "车架", "1",
                                "铝合金材质，重量≤2.5kg，承重≥100kg", "2023-08-15","2"),
                        new Subtask(taskid, "车轮", "1",
                                "26英寸轮径，防滑胎纹，支持快拆", "2023-08-25","4"),
                        new Subtask(taskid, "车把", "1",
                                "可调节高度，人体工学握把", "2023-08-25","2"),
                        new Subtask(taskid, "刹车", "1",
                                "双碟刹系统，防水防尘", "2023-08-25","3"),
                        new Subtask(taskid, "链条", "1",
                                "不锈钢材质，防锈设计，兼容8速变速", "2023-08-25","3"),
                        new Subtask(taskid, "脚踏板", "1",
                                "防滑钉设计，铝合金轴承", "2023-08-25","4")
                );

            case 2:
                return Arrays.asList(
                        // 电脑
                        new Subtask(taskid, "CPU", "1",
                                "Intel i7-12700K，12核20线程，基础频率3.6GHz", "2023-08-15","4"),
                        new Subtask(taskid, "内存", "1",
                                "32GB DDR5，4800MHz，支持扩展", "2023-08-25","1"),
                        new Subtask(taskid, "硬盘", "1",
                                "1TB NVMe SSD，读取速度≥7000MB/s", "2023-08-25","2"),
                        new Subtask(taskid, "显卡", "1",
                                "NVIDIA RTX 3080，10GB GDDR6X", "2023-08-25","1"),
                        new Subtask(taskid, "主板", "1",
                                "ATX规格，支持PCIe 4.0，4个M.2插槽", "2023-08-25","4"),
                        new Subtask(taskid, "电源", "1",
                                "750W 80Plus金牌，全模组设计", "2023-08-25","2")
                );

            case 3:
                return Arrays.asList(
                        // 手机
                        new Subtask(taskid, "屏幕", "1",
                                "6.62英寸 AMOLED，120Hz刷新率，2400×1080分辨率", "2023-08-15","1"),
                        new Subtask(taskid, "电池", "1",
                                "5500mAh，支持65W快充", "2023-08-25","4"),
                        new Subtask(taskid, "摄像头", "1",
                                "2000万像素主摄，f/1.8光圈，支持4K录像", "2023-08-25","3"),
                        new Subtask(taskid, "处理器", "1",
                                "天玑1000，7nm制程，八核架构", "2023-08-25","1"),
                        new Subtask(taskid, "扬声器", "1",
                                "直径3.6cm，声压级≥90dB，立体声双扬声器", "2023-08-25","2")
                );

            case 4:
                return Arrays.asList(
                        // 手表
                        new Subtask(taskid, "表盘", "1",
                                "1.4英寸圆形AMOLED，326PPI，支持常亮显示", "2023-08-15","2"),
                        new Subtask(taskid, "表带", "1",
                                "硅胶材质，20mm快拆设计，防水防汗", "2023-08-25","4"),
                        new Subtask(taskid, "机芯", "1",
                                "瑞士ETA 2824-2，自动上链，精度±5秒/天", "2023-08-25","1"),
                        new Subtask(taskid, "指针", "1",
                                "夜光涂层，精钢材质", "2023-08-25","3"),
                        new Subtask(taskid, "表冠", "1",
                                "旋入式设计，防水100米", "2023-08-25","3")
                );

            case 5:
                return Arrays.asList(
                        // 电饭煲
                        new Subtask(taskid, "内胆", "1",
                                "5L陶瓷涂层，不粘锅设计，可拆卸清洗", "2023-08-15","1"),
                        new Subtask(taskid, "加热盘", "1",
                                "IH电磁加热，功率1200W，支持多段控温", "2023-08-25","2"),
                        new Subtask(taskid, "控制面板", "1",
                                "触控式，24小时预约功能", "2023-08-25","4"),
                        new Subtask(taskid, "盖子", "1",
                                "可拆卸内盖，防溢设计", "2023-08-25","1"),
                        new Subtask(taskid, "电源线", "1",
                                "1.5米长，耐高温材质", "2023-08-25","4")
                );
            case 6:
                return Arrays.asList(
                        // 吉他
                        new Subtask(taskid, "琴身", "1",
                                "云杉木面板，桃花心木背侧板，41英寸标准尺寸", "2023-08-15","2"),
                        new Subtask(taskid, "琴颈", "1",
                                "枫木材质，C型握感，20品", "2023-08-25","2"),
                        new Subtask(taskid, "琴弦", "1",
                                "磷青铜材质，012-053规格", "2023-08-25","8"),
                        new Subtask(taskid, "琴桥", "1",
                                "玫瑰木材质，可调节弦高", "2023-08-25","4"),
                        new Subtask(taskid, "调音旋钮", "1",
                                "全封闭式，18:1齿轮比", "2023-08-25","3")
                );
            case 7:
                return Arrays.asList(
                        // 台灯
                        new Subtask(taskid, "灯座", "1",
                                "金属材质，重量≥1.2kg，防倾倒设计", "2023-08-15","3"),
                        new Subtask(taskid, "灯杆", "1",
                                "可360°旋转，高度可调（40cm-70cm）", "2023-08-25","4"),
                        new Subtask(taskid, "灯罩", "1",
                                "磨砂PC材质，光线柔和不刺眼", "2023-08-25","1"),
                        new Subtask(taskid, "灯泡", "1",
                                "LED 12W，色温3000K-6000K可调", "2023-08-25","2"),
                        new Subtask(taskid, "开关", "1",
                                "触摸控制，支持亮度记忆功能", "2023-08-25","1")
                );
            case 8:
                return Arrays.asList(
                        // 汽车
                        new Subtask(taskid, "轮胎", "1",
                                "225/55 R18，高性能橡胶，耐磨指数≥400，防爆胎设计", "2023-08-15","4"),
                        new Subtask(taskid, "车窗", "1",
                                "前挡风：夹层钢化玻璃，防紫外线（UV阻隔率≥99%）", "2023-08-25","8"),
                        new Subtask(taskid, "车架", "1",
                                "高强度钢铝混合结构，符合C-NCAP五星碰撞要求", "2023-08-25","1"),
                        new Subtask(taskid, "方向盘", "1",
                                "真皮包裹，直径36cm，电动四向调节", "2023-08-25","4"),
                        new Subtask(taskid, "发动机", "1",
                                "2.0T涡轮增压，最大马力245Ps，峰值扭矩370N·m", "2023-08-25","1")
                );
            default:
                throw new IllegalArgumentException("任务ID " + taskid + " 没有预设的分解方案");
        }
    }
    @Override
    public List<Subtask> getSubtasksByTaskId(Integer taskId) {
        if (taskId == null || taskId <= 0) {
            throw new IllegalArgumentException("任务ID无效");
        }
        return subtaskDao.getSubtasksByTaskId(taskId);
    }
    @Override
    public int updateSubtask(Subtask subtask) {
        if (subtask == null || subtask.getSubtaskid() == null) {
            throw new IllegalArgumentException("子任务ID无效");
        }
        return subtaskDao.updateSubtask(subtask);
    }
}
