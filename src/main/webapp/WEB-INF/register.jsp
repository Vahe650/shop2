<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="../template/menucss/styles.css">
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
    <script src="../template/menucss/script.js"></script>

    <meta name="description" content="...">
    <meta name="keywords" content="...">
    <meta name="author" content="...">
    <title>CZSale - Classified Ads Website</title>
    <link rel="stylesheet" href="../template/css/CZSale.css" type="text/css"/>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
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
                                <p>Cras sit amet nibh libero, in gravida nulla. Nulla vel ...</p>
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
                <li><a href="register">Sign Up</a></li>
            </ol>
            <h2>Sign Up</h2>
            <p>
            <h2 style="color: red;">${message}</h2></p>

            <hr>
            <div class="row">
                <div class="col-lg-12">
                    <div class="well">
                        <spring:form action="/addUser" method="post" modelAttribute="user" enctype="multipart/form-data"
                                     role="form">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6 col-md-6">
                                        <spring:input path="name" class="form-control" name="firstname"
                                                      placeholder="Firstname" type="text"/></div>
                                    <div class="col-xs-6 col-md-6">
                                        <spring:input path="surname" class="form-control" name="firstname"
                                                      placeholder="LastName" type="text"/></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <spring:input path="email" name="searchItem" class="form-control"
                                              placeholder="Your email"
                                              type="email"/>
                            </div>


                            <div class="form-group">
                                <form:input type="password" path="password" id="txtPassword" tabindex="2"
                                            class="form-control"
                                            placeholder="Password"/>
                            </div>
                            <div class="form-group">
                                <form:input type="password" path="confirmPassword" id="txtConfirmPassword" tabindex="2"
                                            class="form-control" placeholder="Confirm Password"/>
                                <span id='message'></span>
                            </div>
                            <div>
                                <spring:select path="country" class="form-control"
                                               placeholder="Select Country" itemLabel="name">
                                <c:forEach items="${allcountry}" var="country">
                                <c:if test="${country.parentId==0}" var="no">
                                <c:set var="count" value="${country}"></c:set>
                                    <spring:option disabled="${no}" value="${count.name} " cssStyle="color: red"><h2>${count.name}</h2></spring:option>
                                </c:if>
                                <c:if test="${country.parentId!=0}" var="yes">
                                    <c:set var="any" value="${country}"></c:set>
                                    <spring:option lang="50" value="${any.id}" cssStyle="color:green;"><i>${any.name}</i></spring:option>
                                </c:if>
                                </c:forEach>
                                </spring:select>
                            </div>

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6 col-md-6">
                                        <spring:input path="tel1" class="form-control"
                                                      placeholder="Your first telephone number"
                                                      type="text"/></div>
                                    <div class="col-xs-6 col-md-6">
                                        <spring:input path="tel2" class="form-control"
                                                      placeholder="Your second telephone number" type="text"/></div>
                                </div>
                            </div>
                            <label for="image">Image:</label>
                            <input type="file" id="image" name="picture"/><br>

                            <form:radiobutton path="gender" value="MALE"/>Male
                            <form:radiobutton path="gender" value="FEMALE"/>Female<br><br>

                            <button class="btn btn-lg btn-primary btn-block" id="btnSubmit" value="Submit"
                                    type="submit">Sign
                                up!
                            </button>
                        </spring:form>
                    </div>
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

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#btnSubmit").click(function () {
            var password = $("#txtPassword").val();
            var confirmPassword = $("#txtConfirmPassword").val();
            if (password != confirmPassword) {
                $('#message').html('Not Matching').css('color', 'red');
                return false;
            }
            $('#message').html('Matching').css('color', 'green');
            return true;
        });
    });
</script>

<script src="../template/js/jquery-1.11.1.min.js"></script>
<script src="../template/js/bootstrap.min.js"></script>
<script src="../template/js/jquery.slides.min.js"></script>
<script src="../template/js/CZSale.js"></script>
</body>
</html>