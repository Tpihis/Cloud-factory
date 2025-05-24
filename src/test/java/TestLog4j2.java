
import com.ls.springmvc.Utils.LogUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class TestLog4j2 {
//    static Logger logger= LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);

    public static void main(String[] args) throws ClassNotFoundException {
        LogUtil.trace("trace message");
        LogUtil.debug("debug message");
        LogUtil.info("info message");
        LogUtil.warn("warn 警告");
        LogUtil.error("error message");
        LogUtil.fatal("fatal message");
        System.out.println("Hello World!");
        // 反射检查类是否存在
        Class.forName("org.springdoc.core.OpenAPIService");
    }
}
