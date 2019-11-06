<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<html lang="en">
<head>

    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h3>展示所有的明星</h3>
    </div>

    <script>
        $(function () {

            $("#starList").jqGrid({
                url : "${pageContext.request.contextPath}/star/selectAll",
                datatype : "json",
                height : "40%",
                colNames : [ '编号', '艺名', '真名', '图片', '性别','生日'],
                colModel : [
                    {name : 'id',hidden:true,editable:false},
                    {name : 'nickname',editable:true},
                    {name : 'realname',editable:true},
                    {name : 'photo',editable:true,edittype:"file",formatter:function (value,option,rows){
                            return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/main/star_img/"+rows.photo+"'>"
                        }},
                    {name : 'sex',editable:true,edittype:"select",editoptions:{value:"男:男;女:女"}},
                    {name : 'bir',formatter:"date"},
                ],
                styleUI:"Bootstrap",
                autowidth:true,
                rowNum : 2,
                rowList : [ 2, 5,10],
                pager : '#starPager',
                viewrecords : true,
                subGrid : true,
                caption : "所有明星列表",
                subGridRowExpanded : function(subgrid_id, id) {
                    var subgrid_table_id, pager_id;
                    subgrid_table_id = subgrid_id + "_t";
                    pager_id = "p_" + subgrid_table_id;
                    $("#" + subgrid_id).html(
                        "<table id='" + subgrid_table_id  +"' class='scroll'></table>" +
                        "<div id='" + pager_id + "' class='scroll'></div>");
                    $("#" + subgrid_table_id).jqGrid(
                        {
                            url : "${pageContext.request.contextPath}/user/selectUsersByStarId?star_id=" + id,
                            datatype : "json",
                            colNames : [ '编号', '用户名', '昵称', '头像','电话', '性别','地址','签名' ],
                            colModel : [
                                {name : "id",editable:true},
                                {name : "username",editable:true},
                                {name : "nickname",editable:true},
                                {name : 'photo',editable:true,edittype:"file",formatter:function (value,option,rows){
                                        return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/main/star_img/"+rows.photo+"'>";
                                    }},
                                {name : "phone",editable:true},
                                {name : "sex",editable:true},
                                {name : "address",editable:false,hidden:true},
                                {name : "sign",editable:true}
                            ],
                            styleUI:"Bootstrap",
                            rowNum : 2,
                            pager : pager_id,
                            autowidth:true,
                            height : '40%'
                        });
                    jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                        "#" + pager_id, {
                            edit : false,
                            add : false,
                            del : false,
                            search:false
                        });
                },
                editurl:"${pageContext.request.contextPath}/star/edit",//编辑时url(保存 删除 和 修改)
            }).navGrid("#starPager",{edit:false,add:true,del:false,search:false},{
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
                            url:"${pageContext.request.contextPath}/star/upload",
                            type:"post",
                            fileElementId:"photo",
                            data:{id:id},
                            success:function (response) {
                                //自动刷新jdGrid表格
                                $("#starList").trigger("reloadGrid");
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
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">明星列表</a></li>
        </ul>
    </div>

    <table id="starList"></table>
    <div style="height: 50px" id="starPager"></div>
</body>
</html>