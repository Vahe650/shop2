<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
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

<div>
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
            <a href="/chooseCategory" class="btn btn-success navbar-btn navbar-left add-classified-btn" role="button">Add
                Post</a>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/userHelp">Help</a></li>
            </ul>
        </div>
    </nav>
    <div class="row content">
        <div class="col-lg-3 content-left">

            <h4>Search</h4>
            <div class="well well-sm">
                <form action="/admin/searchUser" method="get">
                    <div class="input-group">
                        <input name="search" type="text" class="form-control"
                               placeholder="What are you looking for?">
                        <span class="input-group-btn">
            <button class="btn btn-primary" type="submit"><span
                    class="glyphicon glyphicon-search"></span></button>
            </span>
                    </div>
                </form>
            </div>

        </div>
    </div>
    <div class="col-lg-9 content-right">
    <div class="row">
        <div class="col-md-112">

                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Category:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <spring:form action="/admin/addCategory" method="post"
                                         modelAttribute="category">
                                <spring:label path="name">Name:</spring:label>
                                <spring:input class="form-control" path="name"></spring:input><br>
                                <input class="btn btn-success btn-block" type="submit" value="ADD">

                            </spring:form>
                        </div>
                    </div>
                </div>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title">Add Parent Category and her Attributes:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <spring:form action="/admin/addParrentCategoryAndAtribute" method="post"
                                         modelAttribute="category">

                                <spring:select path="parentId" class="form-control"
                                               placeholder="Select Country" itemLabel="name">
                                    <c:forEach items="${allCategories}" var="category">
                                        <c:if test="${category.parentId!=0}" var="yes">
                                            <c:set var="count" value="${category}"></c:set>
                                            <spring:option disabled="${yes}"  value="${count.id}" cssStyle="color: green">${count.name}</spring:option>
                                        </c:if>
                                        <c:if test="${category.parentId==0}" var="no">
                                            <c:set var="any" value="${category}"></c:set>
                                            <spring:option  value="${any.id}" cssStyle="color: red" >${any.name}</spring:option>
                                        </c:if>
                                    </c:forEach>
                                </spring:select>
                                <br>
                                <spring:label path="name">Input new category </spring:label>
                                <spring:input class="form-control" path="name"></spring:input><br>

                                <spring:label path="name">Attributes</spring:label>
                                <button onclick="addAttribute()" class="btn btn-success btn-block"
                                        type="button">Add Attribute line
                                </button>
                                <br>
                                <div id="attributeBlock">
                                    <input class="form-control" type="text" name="atribute"
                                           placeholder="attribute"/>
                                </div>
                                <br>
                                <input class="btn btn-success btn-block" type="submit" value="ADD">
                            </spring:form>
                        </div>
                    </div>
                </div>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title"> Add Country:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <spring:form action="/admin/addCountry" method="post"
                                         modelAttribute="country">

                                <spring:label path="name">Name:</spring:label><br>
                                <spring:input class="form-control" path="name"></spring:input><br>
                                <input class="btn btn-success btn-block" type="submit" value="ADD">
                            </spring:form>
                        </div>
                    </div>
                </div>
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h3 class="panel-title"> Add Parent Country:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <spring:form action="/admin/addCountry" method="post"
                                         modelAttribute="country">

                                <spring:label path="name">Name:</spring:label>
                                <spring:input class="form-control" path="name"></spring:input><br>
                                <%--<spring:select class="form-control" path="parentId"--%>
                                               <%--items="${allCountries}"--%>
                                               <%--itemLabel="name"></spring:select><br>--%>
                                <spring:select path="parentId" class="form-control"
                                               placeholder="Select Country" itemLabel="name">
                                <c:forEach items="${allCountries}" var="country">
                                <c:if test="${country.parentId!=0}" var="no">
                                    <c:set var="count" value="${country}"></c:set>
                                    <spring:option disabled="${no}" value="${count.id} " cssStyle="color: red"><h2>${count.name}</h2></spring:option>
                                </c:if>
                                <c:if test="${country.parentId==0}" var="yes">
                                    <c:set var="any" value="${country}"></c:set>
                                    <spring:option lang="50" value="${any.id}" cssStyle="color:green;"><i>${any.name}</i></spring:option>
                                </c:if>
                                </c:forEach>
                                </spring:select>
                                <input class="btn btn-success btn-block" type="submit" value="ADD">
                            </spring:form>
                        </div>
                    </div>
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
</div></div>
</div>
<!-- JavaScript -->

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>

    function addAttribute() {
        $('#attributeBlock').append('<br/><input type="text" name="atribute" placeholder="atribute"/> ');
    }
</script>
<script src="../template/js/jquery-1.11.1.min.js"></script>
<script src="../template/js/bootstrap.min.js"></script>
<script src="../template/js/jquery.slides.min.js"></script>
<script src="../template/js/CZSale.js"></script>
</body>
</html>

<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>--%>
<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--<meta charset="utf-8">--%>
<%--<meta http-equiv="X-UA-Compatible" content="IE=edge">--%>
<%--<meta name="viewport" content="width=device-width, initial-scale=1">--%>
<%--<meta name="description" content="...">--%>
<%--<meta name="keywords" content="...">--%>
<%--<meta name="author" content="...">--%>
<%--<title>CZSale - Classified Ads Website</title>--%>
<%--<link rel="stylesheet" href="../template/css/CZSale.css" type="text/css"/>--%>
<%--<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->--%>
<%--<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->--%>
<%--<!--[if lt IE 9]>--%>
<%--<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>--%>
<%--<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>--%>
<%--<![endif]-->--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="container wrapper">--%>
<%--<div class="logo"><a href="/"><img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale"/></a>--%>
<%--</div>--%>
<%--<nav class="navbar navbar-default" role="navigation">--%>
<%--<div class="navbar-header">--%>
<%--<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#czsale-navbar">--%>
<%--<span class="sr-only">Toggle navigation</span>--%>
<%--<span class="icon-bar"></span>--%>
<%--<span class="icon-bar"></span>--%>
<%--<span class="icon-bar"></span>--%>
<%--</button>--%>
<%--</div>--%>
<%--<div class="collapse navbar-collapse" id="czsale-navbar">--%>


<%--</div>--%>

<%--</nav>--%>

<%--<div class="row content">--%>


<%--<div class="col-lg-9 content-right">--%>
<%--<ol class="breadcrumb">--%>
<%--<li><a href="/">Home</a></li>--%>
<%--<li><a href="/userRegister">Sign Up</a></li>--%>
<%--</ol>--%>
<%--<div class="row content">--%>
<%--<div class="col-lg-3 content-left">--%>
<%--<h4>Search</h4>--%>
<%--<div class="well well-sm">--%>
<%--<form action="/searchResult" method="get">--%>
<%--<div class="input-group">--%>
<%--<input name="searchUser" type="text" class="form-control"--%>
<%--placeholder="What are you looking for?">--%>
<%--<span class="input-group-btn">--%>
<%--<button class="btn btn-primary" type="submit"><span--%>
<%--class="glyphicon glyphicon-search"></span></button>--%>
<%--</span>--%>
<%--</div>--%>
<%--</form>--%>
<%--</div>--%>
<%--</div></div>--%>
<%--<div class="row">--%>
<%--<div class="col-md-112">--%>
<%--<form class="form" role="form" method="post" action="<c:url value="/login"/>"--%>
<%--accept-charset="UTF-8"--%>
<%--id="login-nav">--%>
<%--<div class="panel panel-info">--%>
<%--<div class="panel-heading">--%>
<%--<h3 class="panel-title">Add Category:</h3>--%>
<%--</div>--%>
<%--<div class="panel-body">--%>
<%--<div class="form-group">--%>
<%--<spring:form action="/admin/addCategory" method="post"--%>
<%--modelAttribute="category">--%>
<%--<spring:label path="name">Name:</spring:label>--%>
<%--<spring:input class="form-control" path="name"></spring:input><br>--%>
<%--<input class="btn btn-success btn-block" type="submit" value="ADD">--%>

<%--</spring:form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="panel panel-info">--%>
<%--<div class="panel-heading">--%>
<%--<h3 class="panel-title">Add Parent Category and her Attributes:</h3>--%>
<%--</div>--%>
<%--<div class="panel-body">--%>
<%--<div class="form-group">--%>
<%--<spring:form action="/admin/addParrentCategoryAndAtribute" method="post"--%>
<%--modelAttribute="category">--%>

<%--<spring:label path="name">Change parent category </spring:label>--%>
<%--<spring:select class="form-control" path="parentId"--%>
<%--items="${allCategories}"--%>
<%--itemLabel="name"></spring:select>--%>
<%--<br>--%>
<%--<spring:label path="name">Input new category </spring:label>--%>
<%--<spring:input class="form-control" path="name"></spring:input><br>--%>

<%--<spring:label path="name">Attributes</spring:label>--%>
<%--<button onclick="addAttribute()" class="btn btn-success btn-block"--%>
<%--type="button">Add Attribute line--%>
<%--</button>--%>
<%--<br>--%>
<%--<div id="attributeBlock">--%>
<%--<input class="form-control" type="text" name="atribute"--%>
<%--placeholder="attribute"/>--%>
<%--</div>--%>
<%--<br>--%>
<%--<input class="btn btn-success btn-block" type="submit" value="ADD">--%>
<%--</spring:form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="panel panel-info">--%>
<%--<div class="panel-heading">--%>
<%--<h3 class="panel-title"> Add Country:</h3>--%>
<%--</div>--%>
<%--<div class="panel-body">--%>
<%--<div class="form-group">--%>
<%--<spring:form action="/admin/addCountry" method="post"--%>
<%--modelAttribute="country">--%>

<%--<spring:label path="name">Name:</spring:label><br>--%>
<%--<spring:input class="form-control" path="name"></spring:input><br>--%>
<%--<input class="btn btn-success btn-block" type="submit" value="ADD">--%>
<%--</spring:form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="panel panel-info">--%>
<%--<div class="panel-heading">--%>
<%--<h3 class="panel-title"> Add Parent Country:</h3>--%>
<%--</div>--%>
<%--<div class="panel-body">--%>
<%--<div class="form-group">--%>
<%--<spring:form action="/admin/addCountry" method="post"--%>
<%--modelAttribute="country">--%>

<%--<spring:label path="name">Name:</spring:label>--%>
<%--<spring:input class="form-control" path="name"></spring:input><br>--%>
<%--<spring:select class="form-control" path="parentId"--%>
<%--items="${allCountries}"--%>
<%--itemLabel="name"></spring:select><br>--%>
<%--<input class="btn btn-success btn-block" type="submit" value="ADD">--%>
<%--</spring:form>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</form>--%>
<%--</div>--%>
<%--</div>--%>

<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<div class="footer">--%>
<%--<div class="footer-content">--%>
<%--<div class="row">--%>
<%--<div class="col-xs-6">--%>
<%--<img src="../template/img/czsale-logo.png" alt="CZSale" title="CZSale"--%>
<%--style="width: 100px; height: 58px;"/>--%>
<%--</div>--%>
<%--<div class="col-xs-6 text-right">--%>
<%--<a href="../template/help.jsp" class="btn btn-link">Help</a>--%>
<%--<span class="bar">|</span>--%>
<%--<a href="/contactUs" class="btn btn-link">Contact</a>--%>
<%--<span class="bar">|</span>--%>
<%--<a href="../template/conditions.jsp" class="btn btn-link">Rules & conditions</a>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--</div>--%>
<%--<!-- JavaScript -->--%>

<%--<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>--%>
<%--<script>--%>

<%--function addAttribute() {--%>
<%--$('#attributeBlock').append('<br/><input type="text" name="atribute" placeholder="atribute"/> ');--%>
<%--}--%>
<%--</script>--%>
<%--<script src="../template/js/jquery-1.11.1.min.js"></script>--%>
<%--<script src="../template/js/bootstrap.min.js"></script>--%>
<%--<script src="../template/js/jquery.slides.min.js"></script>--%>
<%--<script src="../template/js/CZSale.js"></script>--%>
<%--</body>--%>
<%--</html>--%>
