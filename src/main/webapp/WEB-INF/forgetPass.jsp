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

            <h3>Forget Password</h3>


            <div class="row">
                <div class="col-md-112">
                    <form action="/forget">
                        <div class="form-group">
                            <label class="sr-only">Email address</label>
                            <input type="email" class="form-control" placeholder="Email address" name="email" required>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success btn-block">Send</button>
                        </div>
                    </form>
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
<script src="../template/js/jquery-1.11.1.min.js"></script>
<script src="../template/js/bootstrap.min.js"></script>
<script src="../template/js/jquery.slides.min.js"></script>
<script src="../template/js/CZSale.js"></script>
</body>
</html>