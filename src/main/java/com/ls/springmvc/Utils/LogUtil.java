package com.ls.springmvc.Utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.util.StackLocatorUtil;

/**
 * 完整的Log4j2工具类
 * 自动获取调用类信息并输出
 */
public class LogUtil {
    private static final int STACK_DEPTH = 3; // 调用栈深度

    private LogUtil() {
        throw new IllegalStateException("Utility class");
    }

    /**
     * 获取带有调用位置信息的Logger
     */
    private static Logger getCallerLogger() {
        Class<?> callerClass = StackLocatorUtil.getCallerClass(STACK_DEPTH);
        return LogManager.getLogger(callerClass);
    }

    /**
     * 获取调用位置信息
     */
    private static String getLocation() {
        StackTraceElement[] stacks = Thread.currentThread().getStackTrace();
        StackTraceElement caller = stacks[STACK_DEPTH];
        return caller.getClassName() + "." + caller.getMethodName()
                + "(" + caller.getLineNumber() + ")";
    }

    // ========== TRACE级别 ==========
    public static void trace(String message) {
        Logger logger = getCallerLogger();
        if (logger.isTraceEnabled()) {
            logger.trace("{} - {}", getLocation(), message);
        }
    }

    public static void trace(String message, Object... params) {
        Logger logger = getCallerLogger();
        if (logger.isTraceEnabled()) {
            logger.trace("{} - {}", getLocation(), String.format(message, params));
        }
    }

    // ========== DEBUG级别 ==========
    public static void debug(String message) {
        Logger logger = getCallerLogger();
        if (logger.isDebugEnabled()) {
            logger.debug("{} - {}", getLocation(), message);
        }
    }

    public static void debug(String message, Object... params) {
        Logger logger = getCallerLogger();
        if (logger.isDebugEnabled()) {
            logger.debug("{} - {}", getLocation(), String.format(message, params));
        }
    }

    // ========== INFO级别 ==========
    public static void info(String message) {
        Logger logger = getCallerLogger();
        if (logger.isInfoEnabled()) {
            logger.info("{} - {}", getLocation(), message);
        }
    }

    public static void info(String message, Object... params) {
        Logger logger = getCallerLogger();
        if (logger.isInfoEnabled()) {
            logger.info("{} - {}", getLocation(), String.format(message, params));
        }
    }

    // ========== WARN级别 ==========
    public static void warn(String message) {
        Logger logger = getCallerLogger();
        if (logger.isWarnEnabled()) {
            logger.warn("{} - {}", getLocation(), message);
        }
    }

    public static void warn(String message, Object... params) {
        Logger logger = getCallerLogger();
        if (logger.isWarnEnabled()) {
            logger.warn("{} - {}", getLocation(), String.format(message, params));
        }
    }

    public static void warn(String message, Throwable throwable) {
        Logger logger = getCallerLogger();
        if (logger.isWarnEnabled()) {
            logger.warn("{} - {}", getLocation(), message, throwable);
        }
    }

    // ========== ERROR级别 ==========
    public static void error(String message) {
        Logger logger = getCallerLogger();
        if (logger.isErrorEnabled()) {
            logger.error("{} - {}", getLocation(), message);
        }
    }

    public static void error(String message, Object... params) {
        Logger logger = getCallerLogger();
        if (logger.isErrorEnabled()) {
            logger.error("{} - {}", getLocation(), String.format(message, params));
        }
    }

    public static void error(String message, Throwable throwable) {
        Logger logger = getCallerLogger();
        if (logger.isErrorEnabled()) {
            logger.error("{} - {}", getLocation(), message, throwable);
        }
    }

    // ========== FATAL级别 ==========
    public static void fatal(String message) {
        Logger logger = getCallerLogger();
        if (logger.isFatalEnabled()) {
            logger.fatal("{} - {}", getLocation(), message);
        }
    }

    public static void fatal(String message, Throwable throwable) {
        Logger logger = getCallerLogger();
        if (logger.isFatalEnabled()) {
            logger.fatal("{} - {}", getLocation(), message, throwable);
        }
    }
}