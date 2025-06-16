package com.ls.springmvc.controller.user;

import com.ls.springmvc.Utils.LogUtil;
import com.ls.springmvc.Utils.TimeUtil;
import com.ls.springmvc.service.OrderService;
import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.TaskService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.*;
import com.ls.springmvc.vo.api.PageResult;
import com.ls.springmvc.vo.api.Result;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller(value = "userTaskController")
@RequestMapping(value = "/user/task")
public class TaskController {

    private static final String PYTHON_API_URL = "http://localhost:5000/recommend_pso";


    @Autowired
    private TaskService taskService;
    @Autowired
    private UserService userService;
    @Autowired
    private ResourceService resourceService;
    @Autowired
    private OrderService orderService;

    @GetMapping("/publish")
    public String taskPublishing(){
        return "/user/taskPublishing";
    }

    @GetMapping("/detailView")
    public String taskDetail(){
        return "/user/taskDetails";
    }

    @GetMapping("/matchResources")
    public String matchResources(){
        return "/user/matchResources";
    }
@GetMapping("/detail")
@ResponseBody
public Result<Map<String,Object>> getTaskDetail(@RequestParam("taskId") Integer taskId, Principal principal) {
    try {
        // 1. 查询任务基本信息
        Task task = taskService.findTaskById(taskId);
        if (task == null) {
            return Result.error("任务不存在");
        }

        // 2. 获取当前登录用户ID
        Integer currentUserId = null;
        if (principal != null) {
            currentUserId = userService.getCurrentUserId(principal);
        }

        // 3. 准备数据
       Map<String,Object> data = new HashMap<>();
        data.put("task", task);
        data.put("currentUserId", currentUserId);
        return Result.success(data);
    } catch (Exception e) {
        e.printStackTrace();
        return Result.error("服务器错误" + e.getMessage());
    }
}
//    增删改查
    @RequestMapping(value = "/addTask")
    @ResponseBody
    public Result<Task> addTask(Task task, Principal principal) {
        Integer userid = userService.getCurrentUserId(principal);
        task.setUserid(userid);
        task.setTaskstatus("待完成");
        task.setAuditstatus("待审");
        task.setTaskdate(TimeUtil.getCurrentDateTime());
        int taskid = taskService.addTask(task);
    if (taskid > 0) {
    return Result.success(null);
    }
         return Result.error("添加失败");
    }

    @PostMapping("/deleteTask")
    @ResponseBody
    public Result<Task> deleteTask(
            @RequestParam(value = "taskId", required = true) Integer taskId,
            Principal principal) {

        // 添加参数验证
        if (taskId == null || taskId <= 0) {
            return Result.error("无效的任务ID");
        }

        try {
            Integer userId = userService.getCurrentUserId(principal);
            Task task = taskService.findTaskById(taskId);

            if(task == null) {
                return Result.error("任务不存在");
            }

            if(!task.getUserid().equals(userId)) {
                return Result.error("无权删除此任务");
            }

            int result = taskService.deleteTask(taskId);
            return result > 0 ? Result.success(null) : Result.error("删除失败");
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("服务器错误: " + e.getMessage());
        }
    }

    @RequestMapping(value = "/updateTask")
    @ResponseBody
    public Result<Task> updateTask(Task task) {
        int result = taskService.updateTask(task);
        if (result > 0) {
            return Result.success(null);
        }else {
            return Result.error("修改失败");
        }
    }
    @RequestMapping(value = "/findTaskById")
    @ResponseBody
    public Result<Task> findTaskById(Task task) {
        if (task.getTaskid()!= null) {
             task = taskService.findTaskById(task.getTaskid());
            if (task != null) {
                return Result.success(task);
            }else {
                return Result.error("查询失败");
            }
        }
        return Result.error("没有taskId");
    }
//    分页查询
    @GetMapping(value = "/getTaskList")
    @ResponseBody
    public Result<PageResult<Task>> getTaskList(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size",defaultValue = "10") int size) {
        PageResult<Task> pageResult = taskService.getTaskList(page, size);
        if (pageResult!= null) {
            return Result.success(pageResult);
        }else {
            return Result.error("查询失败");
        }
    }

    @PostMapping("/taskList")
    @ResponseBody
    public Result<PageResult<Task>> getTaskList(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            // 这里需要根据实际情况获取用户ID，假设可以从UserService获取
            Integer userId = userService.getCurrentUserId(principal);
            params.put("userid", userId);

            // 确保参数存在
            params.putIfAbsent("pageNum", 1);
            params.putIfAbsent("pageSize", 10);
            params.putIfAbsent("searchKey", "");
            params.putIfAbsent("taskStatus", "");
            params.putIfAbsent("categoryid", "");
            params.putIfAbsent("priority", "");
            params.putIfAbsent("timeRange", "");
            params.putIfAbsent("sortField", "taskdate");
            params.putIfAbsent("sortOrder", "desc");

            // 处理排序参数
            if (params.containsKey("sortField") && params.containsKey("sortOrder")) {
                params.put("orderBy", params.get("sortField") + " " + params.get("sortOrder"));
            }

            PageResult<Task> pageResult = taskService.getTaskListByParams(
                    (int) params.get("pageNum"),
                    (int) params.get("pageSize"),
                    params
            );

            if (pageResult != null) {
                return Result.success(pageResult);
            } else {
                return Result.error("查询失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    @PostMapping("/accept")
    @ResponseBody
    public ResponseEntity<Result<Integer>> acceptTask(
            @RequestParam("taskId") int taskId,
            Principal principal,
            HttpServletResponse response) {

        // 强制设置响应头和内容类型
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("X-Content-Type-Options", "nosniff");

        try {
            Integer userId = userService.getCurrentUserId(principal);
            if (userId == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Result.error( "用户未登录"));
            }

            Task task = taskService.findTaskById(taskId);
            if (task == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Result.error( "任务不存在"));
            }

            if (!"待接受".equals(task.getTaskstatus())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Result.error( "任务当前状态不可接受"));
            }

            int result = taskService.acceptTask(taskId, userId);
            return ResponseEntity.ok()
                    .header("Content-Type", "application/json")
                    .body(Result.success( result));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Result.error("接受任务失败: " + e.getMessage()));
        }
    }
    // 取消任务
    // 取消任务 - 统一使用Result返回格式
    @PostMapping("/cancel")
    @ResponseBody
    public ResponseEntity<Result<Integer>> cancelTask(
            @RequestParam Integer taskId,
            Principal principal,
            HttpServletResponse response) {

        // 强制设置响应头和内容类型
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("X-Content-Type-Options", "nosniff");

        try {
            // 业务逻辑
            Integer userId = userService.getCurrentUserId(principal);
            if (userId == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body(Result.error( "用户未登录"));
            }

            Task task = taskService.findTaskById(taskId);
            if (task == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(Result.error( "任务不存在"));
            }

            if (!userId.equals(task.getUserid())) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body(Result.error( "无权取消此任务"));
            }

            if (!"待完成".equals(task.getTaskstatus())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body(Result.error( "任务当前状态不可取消"));
            }

            int result = taskService.cancelTask(taskId);
            return ResponseEntity.ok()
                    .header("Content-Type", "application/json")
                    .body(Result.success(result));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Result.error( "服务器错误: " + e.getMessage()));
        }
    }
    // 更新任务
    @PostMapping("/update")
    @ResponseBody
    public Result<Integer> updateTask(@RequestBody Task task, Principal principal) {
        try {
            // 获取当前用户ID
            Integer userId = userService.getCurrentUserId(principal);
            if (userId == null) {
                return Result.error("用户未登录");
            }

            // 检查任务是否存在且当前用户有权限修改
            Task existingTask = taskService.findTaskById(task.getTaskid());
            if (existingTask == null) {
                return Result.error("任务不存在");
            }

            // 只有任务创建者可以修改任务
            if (!userId.equals(existingTask.getUserid())) {
                return Result.error("无权修改此任务");
            }

            // 检查任务状态是否可以修改
            if ("已完成".equals(existingTask.getTaskstatus()) || "已取消".equals(existingTask.getTaskstatus())) {
                return Result.error("任务当前状态不可修改");
            }

            // 保留不可修改的字段
            task.setUserid(existingTask.getUserid());
            task.setTaskstatus(existingTask.getTaskstatus()); // 状态通过专门接口修改

            // 如果前端没有提供日期，使用原日期
            if (task.getTaskdate() == null || task.getTaskdate().isEmpty()) {
                task.setTaskdate(existingTask.getTaskdate());
            }

            // 更新任务
            int result = taskService.updateTask(task);
            if (result > 0) {
                return Result.success(result); // 返回成功时，Result.success() 会封装为 {code: 200, msg: "成功", data: result}
            } else {
                return Result.error("更新任务失败"); // 返回失败时，{code: 500, msg: "更新任务失败"}
            }
        } catch (Exception e) {
            return Result.error("更新任务失败: " + e.getMessage());
        }
    }
    @PostMapping("/status_counts")
    @ResponseBody
    public Result<List<Map<String, Object>>> getStatusCounts(@RequestBody Map<String, Object> params) {
        try {
            // 设置默认参数
            params.putIfAbsent("searchKey", "");
            params.putIfAbsent("taskStatus", "");
            params.putIfAbsent("categoryid", "");
            params.putIfAbsent("priority", "");
            params.putIfAbsent("timeRange", "");

            // 获取各状态的任务数量统计
            List<Map<String, Object>> counts = taskService.getStatusCounts(params);

            // 返回格式示例:
            // [{"taskStatus":"待完成","count":5}, {"taskStatus":"进行中","count":3}, ...]
            return Result.success(counts);
        } catch (Exception e) {
            return Result.error("获取状态统计失败: " + e.getMessage());
        }
    }

    // 支持搜索和筛选的分页查询
    @PostMapping("/page_Search")
    @ResponseBody
    public Result<PageResult<Task>> pageSearch(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            // 确保参数存在
            params.putIfAbsent("pageNum", 1);
            params.putIfAbsent("pageSize", 10);
            params.putIfAbsent("searchKey", "");
            params.putIfAbsent("taskStatus", "");
            params.putIfAbsent("categoryid", "");
            params.putIfAbsent("priority", "");
            params.putIfAbsent("timeRange", "");
            params.putIfAbsent("sortField", "taskdate");
            params.putIfAbsent("sortOrder", "desc");

            // 处理排序参数
            if (params.containsKey("sortField") && params.containsKey("sortOrder")) {
                params.put("orderBy", params.get("sortField") + " " + params.get("sortOrder"));
            }

            PageResult<Task> pageResult = taskService.getTaskListByParams(
                    (int) params.get("pageNum"),
                    (int) params.get("pageSize"),
                    params
            );

            if (pageResult != null) {
                return Result.success(pageResult);
            } else {
                return Result.error("查询失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("查询失败: " + e.getMessage());
        }
    }
    // 修改后的统计方法
    @PostMapping("/statistics")
    @ResponseBody
    public Result<Map<String, Object>> getTaskStatistics(@RequestBody Map<String, Object> params, Principal principal) {
        try {
            Integer userId = userService.getCurrentUserId(principal);
            if (userId == null) {
                return Result.error("用户未登录");
            }

            params.put("userid", userId);
            Map<String, Object> statistics = taskService.getTaskStatistics(params);
            if (statistics != null) {
                return Result.success(statistics);
            } else {
                return Result.error("获取统计信息失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取统计信息失败: " + e.getMessage());
        }
    }
    @GetMapping("/decompose")
    @ResponseBody
    public Result<String> decomposeTask(
            @RequestParam("taskid") Integer taskid) {

        if (taskid == null) {
            return Result.error("任务ID不能为空");
        }

        try {
            taskService.decomposeAndSaveTask(taskid);
            return Result.success("任务分解成功");
        } catch (IllegalArgumentException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("服务器内部错误: " + e.getMessage());
        }
    }
    @GetMapping("getTaskIdsByUserId")
    @ResponseBody
    public Result<List<Integer>> getTaskIdsByUserId(Principal principal) {
        Integer userId = userService.getCurrentUserId(principal);
        if (userId == null) {
            return Result.error("用户未登录");
        }
        List<Task> tasks = taskService.getTaskListByUserId(userId);
//        只返回taskid
        List<Integer> taskIds = tasks.stream()
              .map(Task::getTaskid)
              .collect(Collectors.toList());
        if (tasks!= null) {
            return Result.success(taskIds);
        }
        return Result.error("获取任务失败");
    }



//   子任务相关接口

    @GetMapping("/subtask/detail")
    @ResponseBody
    public Result<List<Subtask>> subtaskDetail(@RequestParam("taskid") Integer taskid) {
            List<Subtask> subtasks = taskService.getSubtasksByTaskId(taskid);
            if (subtasks!= null) {
                return Result.success(subtasks);
            } else {
                return Result.error("获取子任务失败");
            }
        }

    @GetMapping("/subtask/getSubtasksByTaskId")
    @ResponseBody
    public Result<List<Subtask>> getSubtasksByTaskId(@RequestParam("taskId") Integer taskid) {

            Task task = taskService.findTaskById(taskid);
//            从task中取出subtaskIds,','隔开存放在列表中
            List<Integer> subtaskIds = Arrays.stream(task.getSubtasks().split(","))
                .map(Integer::parseInt)
                .collect(Collectors.toList());
            List<Subtask> subtasks = taskService.getSubtasksByTaskId(taskid);
//            校验两个列表是中的值否一致,无顺序要求
            if (!subtasks.stream().map(Subtask::getSubtaskid).collect(Collectors.toList()).containsAll(subtaskIds)) {
                return Result.error("子任务ID不匹配");
            }
            return Result.success(subtasks);
    }

    @PostMapping("/subtask/confirmAllocateResources")
    @ResponseBody
    public Result<Integer> confirmAllocateResources(@RequestBody Map<String, Object> requestMap) {
        try {
            Integer taskId = (Integer) requestMap.get("taskId");
            String resourceIds = (String) requestMap.get("resourceIds");
            // 1. 解析resourceIds字符串，将其转换为List<Integer>
            List<Integer> resourceIdList = Arrays.stream(resourceIds.split(","))
                  .map(Integer::parseInt)
                  .collect(Collectors.toList());
//            2. 获取任务信息,资源信息列表
            Task task = taskService.findTaskById(taskId);
            List<Resource> resources = resourceService.getResourcesByIds(resourceIdList);
//            3.创建订单
            Order order = new Order();
            order.setTaskid(taskId);
            order.setResourceids(resourceIds);
            order.setOrdertime(TimeUtil.getCurrentDateTime());
            order.setOrderstatus("待支付");
            order.setUserid(task.getUserid());
            int orderId = orderService.createOrder(order);
//            4.更新子任务数据
            List<Subtask> subtasks = taskService.getSubtasksByTaskId(taskId);
//            5. 遍历子任务，按顺序更新资源信息
            for (Subtask subtask : subtasks) {
                // 找出资源名称中包含子任务名称的资源
                List<String> matchedResourceIds = resources.stream()
                        .filter(resource -> resource.getResourcename().contains(subtask.getSubtaskname()))
                        .map(Resource::getResourceid)
                        .map(String::valueOf)
                        .collect(Collectors.toList());

                if (!matchedResourceIds.isEmpty()) {
                    // 将匹配的资源ID用逗号连接，更新到子任务中
                    String newResourceIds = String.join(",", matchedResourceIds);
                    subtask.setResourceids(newResourceIds);

                    // 更新子任务
                    taskService.updateSubtask(subtask);
                }
            }
            return Result.success(null);
        } catch (Exception e) {
            return Result.error("选择资源组失败:" + e.getMessage());
        }

    }

    @GetMapping("/subtask/getResourceAllocationsByTaskId")
    @ResponseBody
    public Result<Map<String, Object>> getResourceAllocationsByTaskId(@RequestParam("taskId") Integer taskId) {
        try {
            // 1. 获取任务信息
            Task task = taskService.findTaskById(taskId);
            if (task == null) {
                return Result.error("任务不存在");
            }

            // 2. 获取子任务信息
            List<Subtask> subtasks = taskService.getSubtasksByTaskId(taskId);

            // 3. 准备返回的数据结构
            Map<String, Object> result = new HashMap<>();
            List<Resource> resources = new ArrayList<>();
            List<Integer> demands = new ArrayList<>();

            // 4. 处理每个子任务的资源分配
            for (Subtask subtask : subtasks) {
                if (subtask.getResourceids() != null && !subtask.getResourceids().isEmpty()) {
                    String[] resourceIdArray = subtask.getResourceids().split(",");
                    String[] quantityArray = subtask.getResourcequantities().split(",");

                    // 确保两个数组长度一致
                    if (resourceIdArray.length != quantityArray.length) {
                        LogUtil.warn("子任务 {} 的资源ID和数量不匹配", subtask.getSubtaskid());
                        continue;
                    }

                    // 收集资源ID和对应数量
                    for (int i = 0; i < resourceIdArray.length; i++) {
                        try {
                            int resourceId = Integer.parseInt(resourceIdArray[i].trim());
                            int quantity = Integer.parseInt(quantityArray[i].trim());

                            // 获取资源详情
                            Resource resource = resourceService.getResourceById(resourceId);
                            if (resource != null) {
                                resources.add(resource);
                                demands.add(quantity);
                            }
                        } catch (NumberFormatException e) {
                            LogUtil.warn("无效的资源ID或数量格式: ID={}, Quantity={}",
                                    resourceIdArray[i], quantityArray[i]);
                        }
                    }
                }
            }
            // 5. 构建返回结果
            result.put("resources", resources);
            result.put("demands", demands);

            return Result.success(result);
        } catch (Exception e) {
            return Result.error("获取资源分配失败: " + e.getMessage());
        }
    }

    /**
     * 自动分配资源接口（简化版）
     */
    @PostMapping("/subtask/autoAllocateResources")
    @ResponseBody
    public Result<List<Map<String, Object>>> autoAllocateResources(@RequestBody List<Map<String, Object>> params) {
        try {
            // 1. 调用Python API获取推荐资源
            Map<String, Object> pythonResponse = callPythonAlgorithm(params);

            // 2. 解析Python返回数据
            Map<String, List<Map<String, Object>>> recommendedResources =
                    (Map<String, List<Map<String, Object>>>) pythonResponse.get("recommended_resources");

            // 3. 生成3-7个随机组合
            List<Set<Integer>> resourceCombinations = generateRandomCombinations(recommendedResources);

            // 4. 批量查询资源详细信息
            List<Map<String, Object>> result = buildCombinationResults(resourceCombinations,params);

            return Result.success(result);
        } catch (Exception e) {
            return Result.error("资源分配失败: " + e.getMessage());
        }


    }

    private Map<String, Object> callPythonAlgorithm(List<Map<String, Object>> params) {
        Map<String, Integer> resourceRequirements = params.stream()
                .filter(task -> task.get("name") != null)
                .collect(Collectors.toMap(
                        task -> (String) task.get("name"),
                        task -> task.get("count") != null ? (Integer) task.get("count") : 0
                ));

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        return restTemplate.postForObject(
                getRandomAlgorithmUrl(),
                new HttpEntity<>(Map.of("resources", resourceRequirements),headers),
                Map.class );
    }

    private List<Set<Integer>> generateRandomCombinations(Map<String, List<Map<String, Object>>> recommendedResources) {
        Random random = new Random();
        int combinationCount = 3 + random.nextInt(5); // 3-7个组合

        return IntStream.range(0, combinationCount)
                .mapToObj(i -> recommendedResources.values().stream()
                        .filter(list -> !list.isEmpty())
                        .map(list -> list.get(random.nextInt(list.size())))
                        .map(resource -> (Integer) resource.get("resourceid"))
                        .collect(Collectors.toSet()))
                .collect(Collectors.toList());
    }

    private List<Map<String, Object>> buildCombinationResults(List<Set<Integer>> combinations,List<Map<String, Object>> params) {
        // 构建资源名称到需求量的映射
        Map<String, Integer> resourceDemand = params.stream()
                .collect(Collectors.toMap(
                        item -> (String) item.get("name"),
                        item -> ((Number) item.get("count")).intValue()
                ));
        // 获取所有需要查询的资源ID
        Set<Integer> allResourceIds = combinations.stream()
                .flatMap(Set::stream)
                .collect(Collectors.toSet());

        // 批量查询资源信息
        List<Resource> resources = resourceService.getResourcesByIds(new ArrayList<>(allResourceIds));
        Map<Integer, Resource> resourceMap = resources.stream()
                .collect(Collectors.toMap(Resource::getResourceid, r -> r));

        // 构建组合结果
        AtomicInteger counter = new AtomicInteger(1);
        return combinations.stream()
                .map(ids -> {
                    List<Resource> comboResources = ids.stream()
                            .map(resourceMap::get)
                            .filter(Objects::nonNull)
                            .collect(Collectors.toList());

                    // 计算组合总价（考虑需求量）
                    // 关键修正：直接计算 (单价 × 需求量) 的总和
                    List<Map<String, Object>> orderedDemands = new ArrayList<>();

                    double totalPrice = comboResources.stream()
                            .mapToDouble(resource -> {
                                Map<String, Object> matchedDemand = params.stream()
                                        .filter(p -> resource.getResourcename().contains((String) p.get("name")))
                                        .findFirst()
                                        .orElse(Map.of("name", "", "count", 1));

                                orderedDemands.add(matchedDemand);
                                return resource.getResourceprice() * ((Number) matchedDemand.get("count")).intValue();
                            })
                            .sum();

                    Map<String, Object> combination = new HashMap<>();
                    combination.put("combinationId", counter.getAndIncrement());
                    combination.put("resources", comboResources);  // 直接使用Resource对象列表
                    combination.put("cost", Math.round(totalPrice * 100) / 100.0);// 保留两位小数
                    combination.put("demands", orderedDemands); // 单独提供需求映射
                    return combination;
                })
                .collect(Collectors.toList());
    }
//获得随机的算法链接"http://localhost:5001/recommend_GA";
//ttp://localhost:5000/recommend_pso";
    public String getRandomAlgorithmUrl(){
        String url_ga = "http://localhost:5001/recommend_GA";
        String url_pso = "http://localhost:5000/recommend_pso";
        Random random = new Random();
        int randomNum = random.nextInt(2);
        if(randomNum == 0){
            return url_ga;
        }
        return url_pso;
    }
}
