<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<jsp:forward page="/emps/emp"></jsp:forward>
<html lang="zh-CN">
<head>

    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>
    <!--引入jQuery-->
    <script src="${APP_PATH}/static/js/jquery-1.8.2.min.js"></script>
    <!-- 引入Bootstrap样式 -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<h1>你好，世界！</h1>
    <button class="btn btn-success">按钮</button>
</body>
</html>