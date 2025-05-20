package com.ls.springmvc.controller.system;

import com.ls.springmvc.service.ResourceService;
import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.AjaxResponse;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.*;
import java.util.ArrayList;
import java.util.Map;

@Controller
@RequestMapping(value = "/system")
public class SystemController {
    @Autowired
    private UserService userService;
    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AjaxResponse ajaxResponse;

    private String baseSavePath  ="D:\\1.study\\javaee\\pro\\upload\\";

    //资源图片路径
    private String baseRsePath  =baseSavePath +"Resources\\";

    private String TempPath = null;

    // 为每次上传创建时间戳文件夹
    private String getSavePath() {
        String timestamp = String.valueOf(System.currentTimeMillis());
        String savePath = baseSavePath + timestamp + "\\";
        new File(savePath).mkdirs();
        return savePath;
    }

    // 为用户创建独立文件夹（需要用户登录系统）
    private String getUserSavePath(Principal principal) {
        //获取到登录的用户名 这里的User对象是Spring-Security提供的User
        // 设置当前用户ID（假设用户已登录）
        Integer userid = -1;
        try {
             userid = userService.findUserByUsername(principal.getName()).getUserid();
        }catch(Exception e){
             throw new RuntimeException("用户未登录");
        }

        String userPath = baseSavePath + userid + "\\";
        new File(userPath).mkdirs();
        return userPath;
    }

    //为资源创建独立文件夹
    private String getResourceSavePath(String resourceId) {
        String resourcePath = baseRsePath + resourceId + "\\";
        new File(resourcePath).mkdirs();
        return resourcePath;
    }

    //获取资源图片
    @GetMapping("/resourceImage")
    public void getResourceImage(
            @RequestParam("resourceId") String resourceId,
            @RequestParam(value = "filename",required = false) String filename,
            HttpServletResponse response) throws IOException {

        String DirectoryPath = baseRsePath + resourceId + "\\";
        File Directory = new File(DirectoryPath);
        List<Map<String, Object>> fileList = new ArrayList<>();
        // 递归遍历所有子文件夹
        scanDirectory(Directory, fileList);

        String filePath = DirectoryPath + fileList.get(0).get("name");
        File file = new File(filePath); // 创建上传目录的File对象


        // 设置图片响应类型
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);

        try (InputStream is = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            IOUtils.copy(is, os);
        }
    }


    //上传资源图片
    @PostMapping("/multiUploadResourceFile")
    @ResponseBody
    public AjaxResponse multiUploadResourceFile(@RequestParam("resourceId") Integer resourceId,
                                                @RequestParam("fileName") MultipartFile fileName[]) throws IOException {
        String savePath = getResourceSavePath(resourceId.toString());
        //获得所有文件名字的后缀
        String[] suffix = new String[fileName.length];
        for(int i=0;i<fileName.length;i++)
        {
            suffix[i] = fileName[i].getOriginalFilename().substring(fileName[i].getOriginalFilename().lastIndexOf("."));
        }

        // 遍历所有上传的文件
        for(int i=0;i<fileName.length;i++)
        {

            // 检查当前文件是否为空
            if(!fileName[i].isEmpty())//文件不空
            {
                // 创建目标文件对象，路径为保存目录+原始文件名
                File imgfile =new File(savePath + fileName[i].getOriginalFilename());
//                File imgfile =new File(savePath + resourceService.getResourceById(resourceId).getResourcename() + ".jpg");
                // 在磁盘上创建空文件
                imgfile.createNewFile();
                // 将上传文件内容写入目标文件
                fileName[i].transferTo(imgfile);
            }
        }

        return new AjaxResponse(0, "上传成功", null);
        // 返回上传成功页面
//        return "/system/success";
    }
    @PostMapping("/uploadFile")
    public String uploadFile(@RequestParam("fileName")
                             MultipartFile fileName)
            throws IOException {
        //创建file对象
        File saveFile =new File(
                baseSavePath +fileName.getOriginalFilename());
        //在磁盘创建该文件
        if(!saveFile.exists())
            saveFile.createNewFile();
        //将接受的文件存储
        fileName.transferTo(saveFile);
        return "/system/success";
    }
    /**
     * 处理多文件上传请求
     * @param fileName 前端传来的多个文件数组
     */
    @PostMapping("/multiUploadFile")
    public String multiUploadFile(@RequestParam("fileName")
                                  MultipartFile fileName[]) throws IOException {
        // 遍历所有上传的文件
        for(int i=0;i<fileName.length;i++)
        {
            // 检查当前文件是否为空
            if(!fileName[i].isEmpty())//文件不空
            {
                // 创建目标文件对象，路径为保存目录+原始文件名
                File imgfile =new File(baseSavePath +fileName[i].getOriginalFilename());
                // 在磁盘上创建空文件
                imgfile.createNewFile();
                // 将上传文件内容写入目标文件
                fileName[i].transferTo(imgfile);
            }
        }
        // 返回上传成功页面
        return "/system/success";
    }

    /**
     * 处理复杂表单文件上传请求（包含普通字段和多个文件）
     * @param name 表单中的姓名字段
     * @param age 表单中的年龄字段
     * @param img 表单中的图片文件数组
     * @param resume 表单中的简历文件
     * @return 上传成功后的跳转页面路径
     * @throws IOException 文件操作可能抛出的IO异常
     */
    @PostMapping("/complexUploadFile")
    public String onfile(@RequestParam("name") String name,
                         @RequestParam("age") String age,
                         @RequestParam("img") MultipartFile img[],
                         @RequestParam(value = "resume",required = false) MultipartFile resume ) throws IOException {

        //创建临时路径
        TempPath = baseSavePath  +"\\"+ name + age + "\\";
        // 创建目标目录（如果不存在）
        File saveDir = new File(TempPath);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); // 创建多级目录
        }
        // 处理图片文件数组
        for(int i=0;i<img.length;i++)
        {
            if(!img[i].isEmpty())//文件不空
            {
                // 创建图片文件对象
                File imgfile =new File(TempPath+img[i].getOriginalFilename());
                // 在磁盘创建空文件
                imgfile.createNewFile();
                // 将上传文件内容写入目标文件
                img[i].transferTo(imgfile);
            }
        }
        // 处理简历文件
        File resumefile =new File(TempPath+resume.getOriginalFilename());
        resumefile.createNewFile();
        resume.transferTo(resumefile);
        return "/system/success";
    }


    /**
     * 获取上传目录中的文件列表并展示
     * @param model Spring MVC模型对象，用于向视图传递数据
     * @return 文件列表展示页面的路径
     */
    @GetMapping("/files")
    public String listFiles(Model model) {
        // 创建上传目录的File对象
        File directory = new File(baseSavePath );
        List<Map<String, Object>> fileList = new ArrayList<>();
        // 递归遍历所有子文件夹
        scanDirectory(directory, fileList);

        // 将文件列表添加到模型
        model.addAttribute("exist_files", fileList);
        // 返回列表展示页面
        return "/system/list";
    }

    @GetMapping("/filesInDirectory")
    public String filesInDirectory(Model model ,@RequestParam("directoryName") String directoryName ) {
       TempPath = baseSavePath  +"\\"+ directoryName + "\\";
        // 创建上传目录的File对象
        File directory = new File(TempPath);
        // 获取目录下所有文件
        File[] files = directory.listFiles();

        // 创建文件信息列表
        List<Map<String, Object>> fileList = new ArrayList<>();
        if (files != null) {
            for (File file : files) {
                // 创建文件信息Map
                Map<String, Object> fileInfo = new HashMap<>();
                // 跳过文件夹，只处理文件
                if (file.isDirectory()) {
//                    continue;
                    fileInfo.put("name", file.getName());
                    //获得文件夹大小
                    long size = 0;
                    File[] files1 = file.listFiles();
                    if (files1!= null) {
                        for (File file1 : files1) {
                            size += file1.length();
                        }
                    }
                    fileInfo.put("size", size);
                    fileInfo.put("isImage", "Directory");
                    fileList.add(fileInfo);
                    continue;
                }

                // 添加文件名
                fileInfo.put("name", file.getName());
                // 添加格式化后的文件大小
                fileInfo.put("size", formatFileSize(file.length()));
                // 添加是否为图片的标识
                fileInfo.put("isImage", isImageFile(file.getName()));
                // 将文件信息添加到列表
                fileList.add(fileInfo);
            }
        }
        // 将文件列表添加到模型
        model.addAttribute("exist_files", fileList);
        // 返回列表展示页面
        return "/system/list";
    }

    /**
     * 预览图片文件
     * @param filename 要预览的图片文件名
     * @param response HTTP响应对象，用于输出图片数据
     * @throws IOException 文件操作可能抛出的IO异常
     */
    @GetMapping("/preview")
    public void previewImage(@RequestParam("filename") String filename,
                             HttpServletResponse response) throws IOException {
        // 创建要预览的图片文件对象
        File file = new File(baseSavePath  + filename);
        // 设置响应内容类型为JPEG图片
        response.setContentType(MediaType.IMAGE_JPEG_VALUE);

        // 使用try-with-resources确保流自动关闭
        try (InputStream is = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            // 将图片文件内容复制到响应输出流
            IOUtils.copy(is, os);
        }
    }

    // 文件下载
    @GetMapping("/download")
    public void downloadFile(@RequestParam("filename") String filename, HttpServletResponse response) throws IOException {
        File file = new File(baseSavePath  + filename);
        //设置页面不缓存,清空buffer
        response.reset();
        //字符编码
        response.setCharacterEncoding("UTF-8");
        //二进制传输数据&浏览器会直接触发下载行为（而非尝试解析或预览文件）。
        response.setContentType("application/octet-stream");
        //设置响应头
        response.setHeader("Content-Disposition",
                "attachment;fileName="+ URLEncoder.encode(filename, "UTF-8"));

        try (InputStream is = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            IOUtils.copy(is, os);
        }
    }
    @GetMapping("/uploadFilePage")
    public String uploadFilePage() {
        return "/system/upload";
    }

    // 判断是否为图片文件
    private boolean isImageFile(String fileName) {
        String[] imgExtensions = {".jpg", ".jpeg", ".png", ".gif"};
        String ext = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
        return Arrays.asList(imgExtensions).contains(ext);
    }

    // 格式化文件大小
    private String formatFileSize(long size) {
        if (size < 1024) return size + " B";
        int exp = (int) (Math.log(size) / Math.log(1024));
        return String.format("%.1f %sB", size / Math.pow(1024, exp), "KMGTPE".charAt(exp-1));
    }
    private void scanDirectory(File directory, List<Map<String, Object>> fileList) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isDirectory()) {
                    scanDirectory(file, fileList); // 递归扫描子文件夹
                } else {
                    Map<String, Object> fileInfo = new HashMap<>();
                    fileInfo.put("name", file.getName());
//                    fileInfo.put("path", file.getParent().replace(baseSavePath, ""));
                    fileInfo.put("path", file.getParent());
                    fileInfo.put("size", formatFileSize(file.length()));
                    fileInfo.put("isImage", isImageFile(file.getName()));
                    fileList.add(fileInfo);
                }
            }
        }
    }

}
