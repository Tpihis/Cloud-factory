package com.ls.springmvc.Exception;

import jakarta.servlet.ServletException;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@ControllerAdvice
public class GlobalExceptionHandler implements AccessDeniedHandler{

    /**
     * 处理所有异常
     * @param ex 异常对象
     * @param model 用于向视图传递数据
     * @param request HTTP请求
     * @param response HTTP响应
     * @return 错误页面视图名
     */
//    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception ex, Model model,
                                      HttpServletRequest request,
                                      HttpServletResponse response) {
        // 获取HTTP状态码，如果没有设置则默认为500
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        if (statusCode == null) {
            statusCode = HttpServletResponse.SC_INTERNAL_SERVER_ERROR;
        }

        // 设置错误信息
        model.addAttribute("error", "系统发生错误");
        model.addAttribute("status", statusCode);
        model.addAttribute("message", ex.getMessage() != null ? ex.getMessage() : "未知错误");
        model.addAttribute("exception", ex.getClass().getSimpleName());
        model.addAttribute("url", request.getRequestURL());
        model.addAttribute("timestamp", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        // 显示堆栈信息
        if (true) {
            model.addAttribute("stackTrace", ex.getStackTrace());
        }

        return randomPage(); // 默认错误页面
    }

    //Spring-Security 访问拒绝处理
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException)
            throws IOException, ServletException {

        // 设置请求属性供JSP页面使用
        request.setAttribute("error", "访问被拒绝");
        request.setAttribute("status", "403");
        request.setAttribute("exception", "您没有足够的权限访问此资源");
        request.setAttribute("url", request.getRequestURI());
        request.setAttribute("timestamp",  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        request.setAttribute("message", accessDeniedException.getMessage());

        // 转发到错误页面
        request.getRequestDispatcher("/WEB-INF/jsp/"+ randomPage()+".jsp").forward(request, response);
    }
    //随机页面
    public  String randomPage() {
        // 随机选择一个页面
        String[] pages = {"error/error", "error/error1"};
        Random random = new Random();
        int index = random.nextInt(pages.length);
        return pages[index];
    }
}