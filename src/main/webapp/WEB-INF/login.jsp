<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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

        </div>
    </nav>
    <div class="row content">


        <div class="col-lg-9 content-right">
            <ol class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/userRegister">Sign Up</a></li>
            </ol>

            <h2>Sign Up</h2>
            <h4 style="color: red">${errorMessage}</h4>
            <hr>


            <div class="row">
                <div class="col-md-112">
                    <form class="form" role="form" method="post" action="<c:url value="/login"/>" accept-charset="UTF-8"
                          id="login-nav">
                        <div class="form-group">
                            <label class="sr-only" for="exampleInputEmail2">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail2" placeholder="Email address"
                                   name="email" required>
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
                        <div class="form-group1"><p><a href="/forgetPassword">Forget password</a> </p></div>
                    </form>
                </div>
            </div>

                <%--<div class="col-md-112">--%>
                    <%--<button onclick="location.href='#'" class="btn btn-default btn-block btn-social btn-facebook">--%>
                        <%--<i class="fa fa-facebook"></i> Sign in with Facebook--%>
                    <%--</button>--%>
                    <%--<button onclick="location.href='#'" class="btn btn-default btn-block btn-social btn-twitter"><i--%>
                            <%--class="fa fa-twitter"></i> Sign in with Twitter--%>
                    <%--</button>--%>
                    <%--<button onclick="location.href='#'" class="btn btn-default btn-block btn-social btn-google-plus"><i--%>
                            <%--class="fa fa-google-plus"></i> Sign in with Google--%>
                    <%--</button>--%>
                <%--</div>--%>

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