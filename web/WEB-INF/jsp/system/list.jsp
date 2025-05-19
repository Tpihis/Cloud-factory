<%--
  Created by IntelliJ IDEA.
  User: 86187
  Date: 2025/5/17
  Time: 20:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <title>文件列表</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        img.preview { max-width: 200px; max-height: 150px; }
    </style>
</head>
<body>
<h2 style="text-align: center;">文件列表</h2>
<table>
    <tr>
        <th>路径</th>
        <th>文件名</th>
        <th>大小</th>
        <th>预览/操作</th>
    </tr>
    <c:forEach items="${exist_files}" var="file">
        <tr>
            <td>${file.path}</td>
            <td>${file.name}</td>
            <td>${file.size}</td>
            <td>
                <c:choose>
                    <c:when test="${file.isImage}">
                        <img src="${pageContext.request.contextPath}/system/preview?filename=${file.name}" class="preview"
                             alt="${file.name}"/>
                    </c:when>
                    <c:otherwise>
<%--                        <c:if test="${file.isImage == 'Directory'}">--%>
<%--                            <a href="${pageContext.request.contextPath}/system/filesInDirectory?directoryName=${file.name}">--%>
<%--                                <button>查看</button>--%>
<%--                            </a>--%>
<%--                        </c:if>--%>
                        <a href="${pageContext.request.contextPath}/system/download?filename=${file.name}"
                           download="${file.name}">
                            <button>下载</button>
                        </a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
