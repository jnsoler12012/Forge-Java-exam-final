<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

</head>

<body>
    <header class="bg-primary p-2 mb-5">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/home">Welcome
                                <c:out value="${user.firstName}" />
                            </a>
                        </li>
                        <li class="nav-item">
                            <form id="logoutForm" method="POST" action="/logout">
                                <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                                <input type="submit" class="btn btn-success" value="Logout">
                            </form>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>
                                    Programa
                                </th>
                                <th>
                                    Red
                                </th>
                                <th>
                                    promedio
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                              <c:if test="${programs == null || programs == []}">
                                <tr>
                                    <td>No hay valores, agregue una tabla</td>
                                </tr>
                            </c:if>
                            <c:if test="${programs != null}">
                                <c:forEach items="${programs}" var="program">
                                    <tr>
                                        <td>
                                            <a href="/programs/${program.id}"><c:out value="${program.name}" /></a>
                                        </td>
                                        <td>
                                            <c:out value="${program.red}" />
                                        </td>
                                        <td>
                                            <c:out value="${program.createdAt}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <form id="newTable" method="GET" action="/program/new">
            <input type="submit" class="btn btn-success" value="+ New Program">
        </form>
    </main>

</body>

</html>