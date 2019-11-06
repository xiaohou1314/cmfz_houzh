<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<html lang="en">
<head>

    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h3>展示所有的用户</h3>
    </div>

    <script>
        $(function () {

            $("#userList").jqGrid({
                url : "${pageContext.request.contextPath}/user/selectAll",
                datatype : "json",
                height : "40%",
                colNames : [ '编号', '用户名', '密码', '昵称', '手机号','签名','性别','创建时间'],
                colModel : [
                    {name : 'id',hidden:true,editable:false},
                    {name : 'username',editable:true},
                    {name : 'password',editable:true},
                    {name : 'nickname',editable:true},
                    {name : 'phone',editable:true},
                    {name : 'sign',editable:true},
                    {name : 'sex',editable:true,edittype:"select",editoptions:{value:"男:男;女:女"}},
                    {name : 'create_date',formatter:"date"},
                ],
                styleUI:"Bootstrap",
                autowidth:true,
                rowNum : 2,
                rowList : [ 2, 5,10],
                pager : '#userPager',
                viewrecords : true,
                caption : "所有用户列表",
                editurl:"${pageContext.request.contextPath}/star/edit",//编辑时url(保存 删除 和 修改)
            })
        })
    </script>

</head>
<body>
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">明星列表</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath}/user/export">导出用户</a></li>
        </ul>
    </div>

    <table id="userList"></table>
    <div style="height: 50px" id="userPager"></div>
</body>
</html>