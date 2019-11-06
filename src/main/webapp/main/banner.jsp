<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<html lang="en">
<head>

    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h3>展示所有的轮播图</h3>
    </div>

    <script>

        $(function () {
            $("#bannerList").jqGrid({
                url:"${pageContext.request.contextPath}/banner/selectAll",
                datatype:"json",//指定请求数据格式 json格式
                colNames:["编号","名称","图片","描述","状态","创建时间"],//用来指定显示表格列
                colModel:[
                    {name:"id",hidden:true,editable:false},
                    {name:"name",editable:true},
                    {name:"cover",editable:true,edittype:"file",formatter:function (value,option,rows) {
                            return "<img style='width:100px;height:60px;' src='${pageContext.request.contextPath}/main/img/"+rows.cover+"'>";
                        }},
                    {name:"description",editable:true},
                    {name:"status",editable:true,edittype:"select",editoptions:{value:"正常:正常;冻结:冻结"}},
                    {name:"create_date",formatter:"date"}
                ],
                styleUI:"Bootstrap",//使用bootstrap样式
                autowidth:true,
                pager:"#bannerPager",//指定分页工具栏
                height:"40%",//高度
                page:1,//当前页
                rowNum:3,//每页展示2条
                sortname : 'id',
                viewrecords:true,//总条数
                rowList:[2,4,6],//下拉列表
                editurl:"${pageContext.request.contextPath}/banner/edit",//编辑时url(保存 删除 和 修改)
            }).navGrid("#bannerPager",{edit:true,add:true,del:true,search:false},{
                    //控制修改
                    closeAfterEdit:true,
                    beforeShowForm:function (fmt) {
                        fmt.find("#cover").attr("disabled",true);
                    }
                },{
                    //控制添加
                    closeAfterAdd:true,
                    afterSubmit:function (data) {
                        var status = data.responseJSON.status;
                        var id = data.responseJSON.message;
                        if (status){
                            $.ajaxFileUpload({
                                url:"${pageContext.request.contextPath}/banner/upload",
                                type:"post",
                                fileElementId:"cover",
                                data:{id:id},
                                success:function (response) {
                                    //自动刷新jdGrid表格
                                    $("#bannerList").trigger("reloadGrid");
                                }
                            });
                        }
                        return "111";
                    }

                });
        })
    </script>

</head>
<body>
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">轮播图列表</a></li>
            <%--<li role="presentation"><a href="#profile" onclick="outBanner()" aria-controls="profile" role="tab" data-toggle="tab">导出轮播图</a></li>--%>
        </ul>
    </div>

    <table id="bannerList"></table>
    <div style="height: 50px" id="bannerPager"></div>
</body>
</html>