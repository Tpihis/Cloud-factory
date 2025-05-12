package com.ls.springmvc.controller;

import com.ls.springmvc.service.UserService;
import com.ls.springmvc.vo.ServiceMessage;
import com.ls.springmvc.vo.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class IndexController {


   @GetMapping("/")
   public String Index(){
       return "user/index";
//       return "user/在JSP页面中打印网址";
   }

}
