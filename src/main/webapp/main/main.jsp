<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>持明法州</title>
    <link rel="icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <link rel="stylesheet" href="../statics/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../statics/jqgrid/css/jquery-ui.css">
    <link rel="stylesheet" href="../statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="../statics/boot/js/jquery-2.2.1.min.js"></script>
    <script src="../statics/boot/js/bootstrap.min.js"></script>
    <script src="../statics/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="../statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="../statics/boot/js/ajaxfileupload.js"></script>

    <script charset="utf-8" src="../kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="../kindeditor/lang/zh-CN.js"></script>
    <script>
        $(function () {
            $("#aaa").click(function () {
                $.ajax({
                    type:"GET",
                    url:"${pageContext.request.contextPath}/admin/exit",
                    success:function () {
                        location.href="${pageContext.request.contextPath}/login/login.jsp";
                    }
                })
            });
        })
    </script>
</head>
<body>
    <%--导航条--%>
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <!--导航标题-->
            <div class="navbar-header">
                <a class="navbar-brand" href="#">持明法洲后台管理系统 <small>v1.0</small></a>
            </div>

            <!--导航条内容-->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">欢迎:<font color="aqua">${sessionScope.loginAdmin.nickname}</font></a></li>
                    <li><a href="#" id="aaa">退出登录 <span class="glyphicon glyphicon-log-out"></span> </a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!--body-->
    <div class="container-fluid">
        <!--row-->
        <div class="row">
            <!--菜单-->
            <div class="col-sm-2">
                <!--手风琴控件-->
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

                    <!--面板-->
                    <!--轮播图管理-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    轮播图管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('banner.jsp')">轮播图列表</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--专辑管理-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    专辑管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('album.jsp')">专辑列表</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--文章管理-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingThree">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseTwo">
                                    文章管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('article.jsp')">文章列表</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--用户管理-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFour">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseTwo">
                                    用户管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('user.jsp')">用户列表</a></li>
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('user-test.jsp')">用户注册趋势</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--明星管理-->
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingFive">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFive" aria-expanded="false" aria-controls="collapseTwo">
                                    明星管理
                                </a>
                            </h4>
                        </div>
                        <div id="collapseFive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFive">
                            <div class="panel-body">
                                <ul class="list-group">
                                    <li class="list-group-item"><a href="javascript:$('#changeContent').load('star.jsp')">明星列表</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div><!--panel-group-->
            </div><!--col-sm-2-->

            <!--中心布局-->
            <div id="changeContent" class="col-sm-10">
                <!--巨幕-->
                <div class="jumbotron">
                    <h2 style="color: #2aabd2" align="center">欢迎来到持明法州后台管理系统!</h2>
                </div>
                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                    </ol>
                    <!-- Wrapper for slides -->
                    <div class="carousel-inner" role="listbox">
                        <div class="item active" align="center">
                            <img style="width: 100%;height: 327.59px" src="${pageContext.request.contextPath}/uploadfiles/image/biaotou/shouye.jpg" alt="...">
                            <div class="carousel-caption">
                            </div>
                        </div>
                        <div class="item" align="center">
                            <img style="width: 100%;height: 327.59px" src="${pageContext.request.contextPath}/uploadfiles/image/biaotou/003.jpg" alt="...">
                            <div class="carousel-caption">
                            </div>
                        </div>
                        <div class="item" align="center">
                            <img style="width: 100%;height: 327.59px" src="${pageContext.request.contextPath}/uploadfiles/image/biaotou/004.jpg" alt="...">
                            <div class="carousel-caption">
                            </div>
                        </div>
                    </div>
                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>

            </div>

        </div><!--row-->
    </div><!--fluid-->

    <br/>
    <%-- 面板 --%>
    <div class="panel panel-default">
        <div style="text-align: center" class="panel-body">
            持明法洲后台管理系统百知教育@zparkhrcom.cn
        </div>
    </div>
</body>
</html>