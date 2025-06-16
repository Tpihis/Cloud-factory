import com.mysql.cj.x.protobuf.MysqlxDatatypes;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PythonServiceClient {

//    private static final String PYTHON_API_URL = "http://localhost:5001/recommend_GA";
    private static final String PYTHON_API_URL = "http://localhost:5000/recommend_pso";

    public static void main(String[] args) {
        // 模拟从网页端传来的资源对象
        Map<String, Object> payload = new HashMap<>();
        Map<String, Integer> resources = new HashMap<>();
        resources.put("轮胎", 4);
        resources.put("车窗", 3);
        resources.put("哈哈", 2);
        payload.put("resources", resources);

        // 调用 Python 推荐接口
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(payload, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(PYTHON_API_URL, request, String.class);
//
        System.out.println("Response from Python: " + response.getBody());
    }
}