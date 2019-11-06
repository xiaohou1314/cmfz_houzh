<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<html lang="en">
<head>

    <!--页头-->
    <div class="page-header" style="margin-top: -20px">
        <h3>展示所有的专辑</h3>
    </div>

    <script>
        $(function () {

            $("#albumList").jqGrid({
                url : "${pageContext.request.contextPath}/album/selectAll",
                datatype : "json",
                height : "40%",
                colNames : [ '编号', '名称', '作者', '封面', '音乐数量','专辑简介','创建时间'],
                colModel : [
                    {name : 'id',hidden:true,editable:false},
                    {name : 'name',editable:true},
                    {name : 'star_id',editable:true,edittype:"select",editoptions:{dataUrl:'${pageContext.request.contextPath}/star/getAllStarForSelect'},formatter:function (value,option,rows) {
                            return rows.star.nickname;
                        }},
                    {name : 'cover',editable:true,edittype:"file",formatter:function (value,option,rows){
                            return "<img style='width:100px;height:70px' src='${pageContext.request.contextPath}/main/album_img/"+rows.cover+"'>"
                        }},
                    {name : 'count'},
                    {name : 'brief',editable:true},
                    {name : 'create_date',editable:true,edittype:"date"},
                ],
                styleUI:"Bootstrap",
                autowidth:true,
                rowNum : 2,
                rowList : [ 2, 5,10],
                pager : '#albumPager',
                viewrecords : true,
                subGrid : true,
                caption : "所有专辑列表",
                subGridRowExpanded : function(subgrid_id, id) {
                    var subgrid_table_id, pager_id;
                    subgrid_table_id = subgrid_id + "_t";
                    pager_id = "p_" + subgrid_table_id;
                    $("#" + subgrid_id).html(
                        "<table id='" + subgrid_table_id  +"' class='scroll'></table>" +
                        "<div id='" + pager_id + "' class='scroll'></div>");
                    $("#" + subgrid_table_id).jqGrid(
                        {
                            url : "${pageContext.request.contextPath}/chapter/selectAll?album_id=" + id,
                            datatype : "json",
                            colNames : [ '编号', '名字', '歌手', '大小','时长', '创建时间','在线播放'],
                            colModel : [
                                {name : "id",hidden:true},
                                {name : "name",editable:true,edittype:"file"},
                                {name : "singer",editable:true},
                                {name : "size"},
                                {name : "duration"},
                                {name : "create_date"},
                                {name : "operation",width:300,formatter:function (value,option,rows) {
                                        return "<audio controls>\n" +
                                            "  <source src='${pageContext.request.contextPath}/main/music/"+rows.name+"' >\n" +
                                            "</audio>";
                                    }}
                            ],
                            styleUI:"Bootstrap",
                            rowNum : 2,
                            pager : pager_id,
                            autowidth:true,
                            height : '40%',
                            editurl:"${pageContext.request.contextPath}/chapter/edit?album_id="+id
                        });
                    jQuery("#" + subgrid_table_id).jqGrid('navGrid',
                        "#" + pager_id, {
                            edit : false,
                            add : true,
                            del : false,
                            search:false
                        },{},{
                            //控制添加
                            closeAfterAdd:true,
                            afterSubmit:function (response) {
                                var status = response.responseJSON.status;
                                if(status){
                                    var cid = response.responseJSON.message;
                                    $.ajaxFileUpload({
                                        url:"${pageContext.request.contextPath}/chapter/upload",
                                        type:"post",
                                        fileElementId:"name",
                                        data:{id:cid,album_id:id},
                                        success:function () {
                                            $("#"+subgrid_table_id).trigger("reloadGrid");
                                        }
                                    })
                                }
                                return "123";
                            }
                        });
                },
                editurl:"${pageContext.request.contextPath}/album/edit",//编辑时url(保存 删除 和 修改)
            }).navGrid("#albumPager",{edit:false,add:true,del:false,search:false},{
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
                            url:"${pageContext.request.contextPath}/album/upload",
                            type:"post",
                            fileElementId:"cover",
                            data:{id:id},
                            success:function (response) {
                                //自动刷新jdGrid表格
                                $("#albumList").trigger("reloadGrid");
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
            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">专辑列表</a></li>
        </ul>
    </div>

    <table id="albumList"></table>
    <div style="height: 50px" id="albumPager"></div>
</body>
</html>