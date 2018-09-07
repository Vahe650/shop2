<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="...">
    <meta name="keywords" content="...">
    <meta name="author" content="...">
    <link rel="stylesheet" href="../template/menucss/styles.css">
    <title>CZSale - Classified Ads Website</title>
    <link rel="stylesheet" href="../template/css/CZSale.css" type="text/css"/>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../template/menucss/script.js"></script>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="collapse navbar-collapse">
    <ul class="nav navbar-nav navbar-top-right">
        <c:if test="${current!=null}"><a href="/userProfileDetail?id=${current.id}">
            <h5 style="color: red"><u>${current.name}&nbsp;${current.surname}</u>
                <img class="user_top_img" src="/user/image?fileName=${current.picUrl}"
                     alt="No img" style="border-radius: 50%" ></h5>
        </a> </c:if>
    </ul>
</div>

<div class="container wrapper">
    <div class="logo"><a href="/"><img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale"/></a></div>
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
            <a href="chooseCategory" class="btn btn-success navbar-btn navbar-left add-classified-btn" role="button">Add
                post</a>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/admin">Admin Page</a></li>
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

                    <c:if test="${current !=null}"><a href="/logout">Sign Out</a></c:if>
                    <c:if test="${current ==null}">
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
            </ul></c:if>
        </div>
    </nav>
    <div class="row content">
        <div class="col-lg-3 content-left">


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
                                        <a href='/categorySearch?id=${parentCategory.id}'><span>${parentCategory.name}</span></a>
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
                                    <p>${one.description}...</p></c:if>
                            </div>
                        </div>
                    </c:forEach>
                    <p class="text-right show-more"><a href="#">More &rarr;</a></p>
                </div>
            </div>

        </div>
        <div class="col-lg-9 content-right">
            <ol class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/contactUs">Contact</a></li>

            </ol>
            <div class="row selected-classifieds">
            <c:forEach items="${allUsers}" var="one">
            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-6">
            <div class="thumbnail">
            <img src="/user/image?fileName=${one.picUrl}" class="jpegsize">
            <div class="caption">
            <h5>${one.name}&nbsp;${one.surname}</h5><br>
            <h5>${one.email}</h5>
            <a href="/admin/deleteUser?id=${one.id}"><button btn btn-success btn-block>Delete</button></a>
            <c:if test="${one.verify==false}">
            <a href="/admin/blockUser?id=${one.id}"><button btn btn-success btn-block>Unblock</button></a>
            </c:if>
            <c:if test="${one.verify==true}">
            <a href="/admin/blockUser?id=${one.id}"><button btn btn-success btn-block>Block</button></a>
            </c:if>
            </div>
            </div>
            </div>
            </c:forEach>

            </div>
            ${mess}

            <hr>
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form action="#" method="POST">
                                <div class="form-group">
                                    <label for="InputEmail">Email address</label>
                                    <input type="email" class="form-control" id="InputEmail" placeholder="Enter your email">
                                </div>
                                <div class="form-group">
                                    <label for="InputSubject">Subject</label>
                                    <input type="email" class="form-control" id="InputSubject" placeholder="Enter your subject">
                                </div>
                                <div class="form-group">
                                    <label for="InputText">Your text</label>
                                    <textarea class="form-control" id="InputText" name="message" placeholder="Type in your message" rows="5" style="margin-bottom:10px;"></textarea>
                                </div>
                                <button class="btn btn-info" type="submit">Send</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="footer-content">
            <div class="row">
                <div class="col-xs-6">
                    <img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale" style="width: 100px; height: 58px;" />
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
