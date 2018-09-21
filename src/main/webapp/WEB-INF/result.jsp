<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="...">
    <meta name="keywords" content="...">
    <meta name="author" content="...">
    <title>CZSale - Post Ads Website</title>

    <link rel="stylesheet" href="../template/menucss/styles.css">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../template/menucss/script.js"></script>
    <link rel="stylesheet" href="../template/css/CZSale.css" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>

    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <![endif]-->
</head>
<body>
<div class="collapse navbar-collapse">
    <ul class="nav navbar-nav navbar-top-right">
        <c:if test="${user!=null}"><a href="/userProfileDetail?id=${user.id}">
            <h5 style="color: red"><u>${user.name}&nbsp;${user.surname}</u>
                <img class="user_top_img" src="/user/image?fileName=${user.picUrl}"
                     alt="No img" style="border-radius: 50%"></h5>
        </a> </c:if>
    </ul>
</div>
<div class="container wrapper">
    <div class="logo"><a href="/"><img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale"/></a>
    </div>
    <nav class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#czsale-navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse" id="czsale-navbar">
            <a href="/chooseCategory" class="btn btn-success navbar-btn navbar-left add-classified-btn" role="button">Add
                Post</a>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${user.type== 'ADMIN'}">
                    <li><a href="/admin">Admin Page</a></li>
                </c:if>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Pages <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="/">Home page</a></li>
                        <li><a href="/chooseCategory">Add Post</a></li>
                        <li><a href="/searchResult">Category page</a></li>
                        <li><a href="/userConditions">Rules & Conditions</a></li>
                        <li><a href="/userHelp">Help (FAQ)</a></li>
                        <li><a href="/contactUs">Contact</a></li>
                        <li><a href="/userRegister">Sign Up</a></li>
                    </ul>
                </li>
                <li><a href="/userHelp">Help</a></li>
                <li><a href="/userRegister">Sign up</a></li>
                <li class="dropdown">

                    <c:if test="${user !=null}"><a href="/logout">Sign Out</a></c:if>
                    <c:if test="${user ==null}">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sign in<b class="caret"></b></a>
                    <ul class="dropdown-menu" style="padding: 15px;min-width: 250px;">
                        <li>
                            <div class="row">
                                <div class="col-md-12">
                                    <form class="form" role="form" method="post" action="<c:url value="/login"/>"
                                          accept-charset="UTF-8" id="login-nav">
                                        <div class="form-group">
                                            <label class="sr-only" for="exampleInputEmail2">Email address</label>
                                            <input type="email" class="form-control" id="exampleInputEmail2"
                                                   placeholder="Email address" name="email" required>
                                        </div>
                                        <div class="form-group">
                                            <label class="sr-only" for="exampleInputPassword2">Password</label>
                                            <input type="password" class="form-control" id="exampleInputPassword2"
                                                   placeholder="Password" name="password" required>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"> Remember me
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-success btn-block">Sign in</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </li>
                            <%--<li class="divider"></li>--%>
                            <%--<li>--%>
                            <%--<div class="form-group">--%>
                            <%--<button onclick="location.href='#'"--%>
                            <%--class="btn btn-default btn-block btn-social btn-facebook"><i--%>
                            <%--class="fa fa-facebook"></i> Sign in with Facebook--%>
                            <%--</button>--%>
                            <%--<button onclick="location.href='#'"--%>
                            <%--class="btn btn-default btn-block btn-social btn-twitter"><i--%>
                            <%--class="fa fa-twitter"></i> Sign in with Twitter--%>
                            <%--</button>--%>
                            <%--<button onclick="location.href='#'"--%>
                            <%--class="btn btn-default btn-block btn-social btn-google-plus"><i--%>
                            <%--class="fa fa-google-plus"></i> Sign in with Google--%>
                            <%--</button>--%>
                            <%--</div>--%>
                            <%--</li>--%>
                    </ul>
                </li>
            </ul>
            </c:if>
        </div>
    </nav>
    <div class="row content">
        <div class="col-lg-3 content-left">
            <h4>Search</h4>
            <div class="well well-sm">
                <form action="/searchResult" method="get">
                    <div class="input-group">
                        <input name="search" type="text" class="form-control" placeholder="What are you looking for?">
                        <span class="input-group-btn">
									<button class="btn btn-primary" type="submit"><span
                                            class="glyphicon glyphicon-search"></span></button>
								</span>
                    </div>
                </form>
            </div>
            <c:if test="${result.size()>1}">
                <h4>Price Range</h4>
                <form action="/middleRange">
                    <div class="range">
                        <output id="range" style="text-align:center; color:red">FROM</output>
                        <input type="range" name="firstInt" min="0" max="100000" value="50" step="50"
                               onchange="range.value=value">
                        <output id="rangePrimary" style="text-align:center; color: red; ">TO</output>
                        <input type="range" name="secondInt" min="0" max="100000" value="50" step="50"
                               onchange="rangePrimary.value=value">

                        <input type="hidden" name="id" value="${result[0].category.id}">


                        <button class="btn btn-primary" type="submit" style="align-items: center"><span
                                style="align-content: center"
                                class="glyphicon glyphicon-search"></span></button>
                    </div>
                </form>
            </c:if>


            <h4>Categories</h4>
            <div id='cssmenu'>
                <ul>
                    <li class='active'><a href='/'><span>Home</span></a></li>
                    <c:forEach items="${allCategories}" var="category">
                        <c:if test="${category.parentId ==0}">
                            <li class='has-sub'><a href='#'><span>${category.name}</span></a></c:if>
                        <ul>
                            <c:forEach items="${allCategories}" var="parentCategory">
                                <c:if test="${parentCategory.parentId == category.id}">
                                    <li>
                                        <a href="/categorySearch?id=${parentCategory.id}"><span>${parentCategory.name}</span></a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                        </li></c:forEach>
                </ul>
            </div>
            <div class="hidden-xs hidden-sm hidden-md">
                <h4>Newest Posts</h4>
                <div class="newest-classifieds">
                    <c:forEach items="${four}" var="one">
                        <div class="media">
                            <a class="pull-left" href="/viewDetail?id=${one.id}">
                                <img class="media-object" style="width: 64px; height: 64px;"
                                     src="/post/image?fileName=${one.pictures[0].picUrl}"/>
                            </a>
                            <div class="media-body">
                                <p><a href="/viewDetail?id=${one.id}"><strong>${one.title}</strong></a></p>
                                <c:if test="${one.description.length()>45}">
                                    <p>${one.description.substring(0,45)}...</p></c:if>
                                <c:if test="${one.description.length()<45}">
                                    <p>${one.description}...</p></c:if></div>
                        </div>
                    </c:forEach>
                    <p class="text-right show-more"><a href="#">More &rarr;</a></p>
                </div>
            </div>
        </div>
        <div class="col-lg-9 content-right">


            <%--<div class="hidden-xs hidden-sm hidden-md">--%>
            <%--<h4>Newest Posts</h4>--%>
            <%--<div class="newest-classifieds">--%>
            <%--<c:set var="last" value="${fn:length(allPosts)}"/>--%>
            <%--<c:forEach var="i" begin="1" end="3" step="1">--%>
            <%--<c:set var="one" value="${allPosts[last-i]}"/>--%>
            <%--<div class="media">--%>
            <%--<a class="pull-left" href="/viewDetail?id=${one.id}">--%>
            <%--<img class="media-object" style="width: 64px; height: 64px;"--%>
            <%--src="/post/image?fileName=${one.pictures[0].picUrl}"/>--%>
            <%--</a>--%>
            <%--<div class="media-body">--%>
            <%--<p><a href="/viewDetail?id=${one.id}"><strong>${one.title}</strong></a></p>--%>
            <%--<c:if test="${one.description.length()>45}">--%>
            <%--<p>${one.description.substring(0,45)}...</p></c:if>--%>
            <%--<c:if test="${one.description.length()<45}">--%>
            <%--<p>${one.description}...</p></c:if>                            </div>--%>
            <%--</div>--%>
            <%--</c:forEach>--%>
            <%--<p class="text-right show-more"><a href="#">More &rarr;</a></p>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="col-lg-9 content-right">--%>
            <%--<===========================================================================================================================>--%>
            <%--<ol class="breadcrumb">--%>
            <%--<li><a href="/">Home</a></li>--%>
            <%--<li><a href="#">Categories</a></li>--%>
            <%--<li><a href="#">Computers & Networking</a></li>--%>
            <%--<li><a href="result.jsp">PC, Computers</a></li>--%>
            <%--</ol>--%>
            <h2>New</h2>

            <div class="well well-sm" style="padding: 0; background-color: #FCF8E3;">
                <div class="row top-classifieds">
                    <c:forEach items="${four}" var="one">
                        <div class="col-lg-3 col-md-3 col-sm-4 col-xs-12">
                            <div class="thumbnail">
                                <a href="/viewDetail?id=${one.id}">
                                    <img alt="" src="/post/image?fileName=${one.pictures[0].picUrl}" class="jpegsize"/></a>
                                <div class="caption">
                                    <h5><a href="/viewDetail?id=${one.id}">${one.title}</a></h5>

                                    <p class="price"><fmt:formatNumber value="${one.price}" type="number"
                                                                       maxFractionDigits="3"></fmt:formatNumber></p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <hr>


            <div class="row classifieds-table">
                <div class="col-lg-12">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Product</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Views</th>
                        </tr>

                        </thead>

                        <tbody>
                        <tr>

                            <h3>${mes}</h3>


                        </tr>
                        <c:forEach items="${result}" var="post">
                            <tr>
                                <td class="col-sm-8 col-md-6">
                                    <div class="media">
                                        <a class="thumbnail pull-left" href="/viewDetail?id=${post.id}"
                                           style="width: 84px; height: 80px;">
                                            <img class="media-object"
                                                 src="/post/image?fileName=${post.pictures[0].picUrl}"
                                                 style="width: 72px; height: 72px;"/>
                                        </a>
                                        <div class="media-body">
                                            <h4 class="media-heading"><a
                                                    href="/viewDetail?id=${post.id}">${post.title}</a></h4>
                                            <p>
                                                <small>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla
                                                    adipiscing tempor ornare. Pellentesque habitant morbi tristique
                                                    senectus et netus et malesuada fames ac ...
                                                </small>
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td class="col-sm-1 col-md-1 text-center" style="vertical-align: middle;">
                                    <strong><fmt:formatNumber value="${post.price}" type="number"
                                                              maxFractionDigits="3"></fmt:formatNumber></strong>
                                </td>
                                <td class="col-sm-1 col-md-1 text-center"
                                    style="vertical-align: middle;">${post.view}</td>

                            </tr>
                        </c:forEach>


                        </tbody>
                    </table>

                </div>
                <div class="col-lg-12" style="text-align: center;">
                    <ul class="pagination">
                        <li class="disabled"><a href="#"><<</a></li>
                        <li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">>></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="footer-content">
            <div class="row">
                <div class="col-xs-6">
                    <img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale"
                         style="width: 100px; height: 58px;"/>
                </div>
                <div class="col-xs-6 text-right">
                    <a href="/userHelp" class="btn btn-link">Help</a>
                    <span class="bar">|</span>
                    <a href="/contactUs" class="btn btn-link">Contact</a>
                    <span class="bar">|</span>
                    <a href="/userConditions" class="btn btn-link">Rules & conditions</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- JavaScript -->
<script src="../template/js/jquery-1.11.1.min.js"></script>
<script src="../template/js/bootstrap.min.js"></script>
<script src="../template/js/jquery.slides.min.js"></script>
<script src="../template/js/CZSale.js"></script>
</body>
</html>