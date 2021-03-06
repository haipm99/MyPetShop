<%-- 
    Document   : adminManageAccount
    Created on : Jun 27, 2019, 11:41:37 AM
    Author     : 99hai
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Product</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Bootstrap 4 -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="CSS/jquery-ui.min.css">
        <!-- My CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/CSS/modal.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/CSS/style4.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Admin/CSS/main.css">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward()
            }
            noBack();
            window.onload = noBack;
            window.onpageshow = function (evt) {
                if (evt.persisted)
                    noBack()
            }
            window.onunload = function () {
                void (0)
            }
        </script>
    </head>
    <body>
        <div class="wrapper">
            <c:if test="${requestScope.CHECK == '1'}">
                <script type="text/javascript">
                    swal("Success", "Good Job", "success");
                </script>
            </c:if>
            <nav id="sidebar">
                <div class="sidebar-header">
                    <h3>WelCome ${sessionScope.FULLNAME}</h3>
                    <h5><a href="/PETWATER/LogoutController">Logout</h5>
                </div>

                <ul class="list-unstyled components">
                    <li>
                        <a href="LoadAccessoryAdmin?idPage=1">
                            <i class="fa fa-home"></i>
                            Manage All Product
                        </a>
                    </li>
                    <li>
                        <a href="LoadServiceAdminController">
                            <i class="fa fa-paperclip"></i>
                            Manage Service for Pet
                        </a>
                    </li>
                    <li>
                        <a href="AdminViewPetController?idPage=1">
                            <i class="fa fa-paperclip"></i>
                            Manage Pet
                        </a>
                    </li>
                    <li>
                        <a href="AdminViewOrderController?idPage=1">
                            <i class="fa fa-paperclip"></i>
                            Manage Order
                        </a>
                    </li>
                    <li>
                        <a href="AdminManageServiceProcessController">
                            <i class="fa fa-paperclip"></i>
                            Manage In Process Service
                        </a>
                    </li>
                    <li>
                        <a href="AdminManageHistoryService?idPage=1">
                            <i class="fa fa-paperclip"></i>
                            History of Service Process
                        </a>
                    </li>
                    <li class="active">
                        <a href="AdminManageAccount?idPage=1">
                            <i class="fa fa-paperclip"></i>
                            Manage Account
                        </a>
                    </li>
                    <li>
                        <a href="Admin/registerAdmin.jsp">
                            <i class="fa fa-paperclip"></i>
                            Register Admin
                        </a>
                    </li>
                </ul>
            </nav>
            <div id="content">
                <div class="container">
                    <div class="card text-center">
                        <!-- Header -->
                        <div class="card-header myCardHeader">
                            <div class="row">
                                <div class="col-md-6">
                                    <h3 class="text-left text-primary font-weight-bold">List User</h3>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col">
                                    <div class="input-group">
                                        <form action="AdminSearchAccount" method="POST">
                                            <input type="text" class="form-control" placeholder="Search By Username" name="txtSearch">
                                            <input type="submit" class="btn btn-outline-success" name="action" value="Search"/>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${requestScope.LIST_USER != null}">
                                <table class="table table-bordered table-hover myTable">
                                    <thead class="text-primary">
                                        <tr>
                                            <th>User name</th>
                                            <th>Fullname</th>
                                            <th>Phone</th>
                                            <th>Address</th>
                                            <th>Role</th>
                                            <th>Wallet</th>
                                            <th>Action</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <c:forEach items="${requestScope.LIST_USER}" var="user">
                                        <tr>
                                            <td>${user.username}</td>
                                            <td>${user.fullname}</td>
                                            <td>${user.phone}</td>
                                            <td>${user.address}</td>
                                            <td>${user.role}</td>
                                            <td>${user.wallet}</td>
                                            <c:url var="BANLINK" value="AdminBanUserController">
                                                <c:param name="delete-name" value="${user.username}" />
                                            </c:url>
                                            <c:url var="UNBAN" value="AdminUnBanUserController">
                                                <c:param name="unban-name" value="${user.username}"/>
                                            </c:url>
                                            <c:if test="${user.status}">
                                                <td><a href="${BANLINK}" class="btn btn-danger <c:if test="${user.username == sessionScope.USERNAME}">disabled</c:if> " >Ban</a></td>
                                            </c:if>
                                            <c:if test="${!user.status}">
                                                <td><a href="${UNBAN}" class="btn btn-success <c:if test="${user.username == sessionScope.USERNAME}">disabled</c:if> " >Un Ban</a></td>
                                            </c:if>    
                                            <td><span style="width:70px;height: 30px;" class="badge badge-<c:if test="${user.status}">success</c:if><c:if test="${!user.status}">danger</c:if>">
                                                    <c:if test="${user.status}">Active</c:if><c:if test="${!user.status}">Block</c:if>
                                                    </span>
                                                </td>
                                            </tr>
                                    </c:forEach>
                                </table>
                            </c:if>
                        </div>
                        <div class="card-footer myCardFooter">
                            <ul class="pagination">
                                <c:forEach var="i" begin="1" end="${requestScope.NUMBER_PAGE}" step="1">
                                    <li class="page-item"><a class="page-link" href="AdminManageAccount?idPage=${i}">${i}</a></li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    </body>

</html>
