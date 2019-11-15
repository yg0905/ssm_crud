<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019-11-11
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script src="${APP_PATH}/static/js/jquery-3.0.0.min.js"></script>
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 引入Bootstrap样式 -->


<html>
<head>
    <title>员工列表</title>
</head>
<body>
<%--修改的模态框--%>
<div class="modal fade" id="empUpdatemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改列表</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_Update_static" name="empName">email@example.com</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_Update_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_Update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_Update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <%--部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_Update_btn">修改</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal  模态框 员工添加-->
<div class="modal fade" id="empAddmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工新增列表</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-10">
                            <%--部门提交id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD1</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>

<script type="text/javascript">
    var totalRecord,currentPage;
    $(function(){
       to_page(1)
    });
    function to_page(pn) {
        $.getJSON("${APP_PATH}/emps/emp","pn="+pn,function (result){
            build_emps(result);
            build_page_info(result);
            build_page_nav(result);
        })
    }
    function build_emps(result) {
        //先清空
        $("#emps_table tbody").empty();
        var emps=result.extend.pageinfo.list;
        $.each(emps,function (index,item) {
            var checkBoxtd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdtd=$("<td></td>").append(item.empId);
            var empNametd=$("<td></td>").append(item.empName);
            var gendertd=$("<td></td>").append(item.gender=='M'?"男":"女");
            var email=$("<td></td>").append(item.email);
            var deptName=$("<td></td>").append(item.department.deptName);
            //给编辑按钮添加一个自定义属性 表示员工id
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")
                .addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit_id",item.empId);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")
                .addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delBtn.attr("edit_id",item.empId);
            var btn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxtd)
                .append(empIdtd)
                .append(empNametd)
                .append(gendertd)
                .append(email)
                .append(deptName)
                .append(btn)
                .appendTo("#emps_table tbody");
        })
    }
    //显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageinfo.pageNum+"页，" +
            "总"+result.extend.pageinfo.pages+"页，" +
            "总共"+result.extend.pageinfo.total+"条记录")
        totalRecord=result.extend.pageinfo.total;
        currentPage=result.extend.pageinfo.pageNum;
    }
    //显示分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageinfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled")
        }else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum-1);
            });
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
        if(result.extend.pageinfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled")
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageinfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageinfo.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageinfo.navigatepageNums,function (index,item) {//item为连续页数
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageinfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                 to_page(item)
            });
            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //重置表单信息方法
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        //将class 为help-block 所有的清空
        $(ele).find(".help-block").text("");
    }
    //新增按钮被点击时
    $("#emp_add_modal_btn").click(function () {
        //清空表单  取出dom对象 调用reset清空表单方法 和样式
        reset_form("#empAddmodal form");
        getDepts("#dept_add_select");
        //点击新增按钮弹出模态框
        $("#empAddmodal").modal({
            backdrop:"static"
        })
    });
    //查出所有部门信息显示在下拉框
    function getDepts(ele) {
        $(ele).empty();
        $("#dept_add_select").empty();
        $.getJSON("${APP_PATH}/depts","",function (result) {
            $.each(result.extend.depts,function () {
                var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                optionEle.appendTo(ele);
            })
        })
    }
//    校验表单数据
    function validate_add_form(){
        var empName=$("#empName_add_input").val();
        var regName=/(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //调用封装的方法
            show_validate("#empName_add_input","error","名字不符合规定");
            //alert("名字不符合规定");
            //$("#empName_add_input").parent().addClass("has-error");
            //$("#empName_add_input").next("span").text("名字不符合规定");
            return false;
        }else{
            show_validate("#empName_add_input","success","");
            //$("#empName_add_input").parent().addClass("has-success");
            //$("#empName_add_input").next("span").text("");
        };
        //校验邮箱格式
        var empEmail=$("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(empEmail)){
            show_validate("#email_add_input","error","邮箱格式不正确1");
            //alert("邮箱格式不正确");
            //$("#email_add_input").parent().addClass("has-error");
            //$("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        }else{
            show_validate("#email_add_input","success","");
            //$("#email_add_input").parent().addClass("has-success");
            //$("#email_add_input").next("span").text("");
        };
        return true;
    }
    //显示校验结果的提示信息
    function show_validate(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
//    验证用户名是否存在Ajax 内容发生改变时 发送Ajax
    $("#empName_add_input").change(function () {

        $.getJSON("${APP_PATH}/emps/checkUser","empName="+this.value,function (result) {
            if(result.code==100){
                show_validate("#empName_add_input","success","用户名可以使用");
                $("#emp_save_btn").attr("ajax_va","success");
            }else{
                show_validate("#empName_add_input","error",result.extend.va_msg);
                $("#emp_save_btn").attr("ajax_va","error");
            }
        })
    });
//    点击保存新增方法
    $("#emp_save_btn").click(function () {
        if(!validate_add_form()){
            return false;
        }
        if($(this).attr("ajax_va")=="error"){
            return false
        }
        //发送ajax请求保存信息新增
        $.ajax({
            url:"${APP_PATH}/emps/empadd",
            type:"POST",
            data:$("#empAddmodal form").serialize(),
            success:function (result) {
                if(result.code==100){
                    //新增成功 关闭模态框
                    $("#empAddmodal").modal('hide');
                    //显示最新的一条信息 显示最后一页 用总记录数来去最后一页 分页插件会吧最大的数字当做最后一页
                    to_page(totalRecord);
                }else{
                    //显示后台失败信息
                    if(undefined!=result.extend.errorFields.empName){
                        show_validate("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                    if(undefined!=result.extend.errorFields.email){
                        show_validate("#email_add_input","error",result.extend.errorFields.email);
                    }
                }
            }
        });
    });
//    给编辑按钮绑定点击事件
    $(document).on("click",".edit_btn",function () {
        //查查部门 显示下拉框
        getDepts("#dept_update_select");
        //查出选中的员工信息 显示出来
        getEmp($(this).attr("edit_id"));
        //将编辑按钮中的id 传到更新按钮
        $("#emp_Update_btn").attr("edit_update_id",$(this).attr("edit_id"));
        $("#empUpdatemodal").modal({
            backdrop:"static"
        });
    });

//    查询当前员工信息
    function getEmp(id) {
        $.getJSON("${APP_PATH}/emps/getEmp/"+id,"",function (result) {
            var empData=result.extend.getEmp;
            $("#empName_Update_static").text(empData.empName);
            $("#email_Update_input").val (empData.email);
            $("#empUpdatemodal input[name=gender]").val([empData.gender]);
            $("#dept_update_select").val([empData.dId]) ;
        })
    }
//    点击更新 修改员工信息
    $("#emp_Update_btn").click(function () {
        var empEmail=$("#email_Update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(empEmail)){
            show_validate("#email_Update_input","error","邮箱格式不正确");
            return false;
        }else{
            show_validate("#email_Update_input","success","");
        };

        $.ajax({
            url:"${APP_PATH}/emps/emp/"+$("#emp_Update_btn").attr("edit_update_id"),
            type:"PUT",
            data:$("#empUpdatemodal form").serialize(),
            success:function (result){
                alert(result.msg);
                $("#empUpdatemodal").modal("hide");
                to_page(currentPage);
            }
        });
    });
//    给删除按钮添加点击事件
    $(document).on("click",".delete_btn",function () {
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确定删除"+empName+"吗？")){
            $.ajax({
                url:"${APP_PATH}/emps/emp/"+$(this).attr("edit_id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });
//    点击多选框 全选或者全不选 prop获取原属性值 attr 获取自定义值
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$("#check_all").prop("checked"));
    })
    $(document).on("click",".check_item",function () {
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    })
//    点击全部删除按钮
    $("#emp_delete_all_btn").click(function () {
        var empName="";
        var del_ids="";
        $.each($(".check_item:checked"),function () {
            empName+=$(this).parents("tr").find("td:eq(2)").text()+",";
            del_ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除最后面多余的","
        empName=empName.substring(0,empName.length-1);
        //去除最后面多余的"-"
        del_ids=del_ids.substring(0,del_ids.length-1);
            if(confirm("确定删除【"+empName+"】吗")){
            //    发送ajax
                $.ajax({
                    url:"${APP_PATH}/emps/emp/"+del_ids,
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        to_page(currentPage);
                    }
                })
            }
    })
</script>
</body>
</html>
