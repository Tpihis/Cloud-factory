package com.ls.springmvc.Utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeUtil {
//    封装一个获取当前时间工具类
//    日期时间
    public static String getCurrentDateTime(){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return now.format(formatter);
    }
//    日期
    public static String getCurrentDate(){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return now.format(formatter);
    }
//    时间
    public static String getCurrentTime(){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        return now.format(formatter);
    }
}
