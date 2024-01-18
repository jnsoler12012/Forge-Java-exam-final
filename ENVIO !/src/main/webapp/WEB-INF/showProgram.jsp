<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>All Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

</head>

<body>
    <header class="bg-primary p-2 mb-5">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid" d-flex justify-content-betwee>
                <div class="d-flex justify-content-between" id="navbarNav">
                    <ul class="navbar-nav d-flex justify-content-between">
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
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="/home">Volver al panel

                            </a>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>
    </header>
    <main class="m-5">
        <h2 class="mb-5">
            <c:out value="${ program.name }" />
        </h2>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <h3>
                        <p class="font-weight-bold">Agregada por</p>
                    </h3>


                </div>
                <div class="col-md-6">
                    <h3>
                        <p class="font-weight-bold">
                            <c:out value="${ program.user.firstName }" />
                        </p>
                    </h3>

                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Program name
                </div>
                <div class="col-md-6">
                    <c:out value="${ program.name }" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Red/Network television
                </div>
                <div class="col-md-6">
                    <c:out value="${ program.red }" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    Description
                </div>
                <div class="col-md-6">
                    <c:out value="${ program.description }" />
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <button class="btn btn-success" onclick="location.href='/programs/${program.id}/edit'"
                        type="button">edit</button>
                </div>
                <div class="col-md-6">
                    <c:if test="${ errorNoUser != null }">
                        <div class="alert alert-danger" role="alert">
                            <c:out value="${errorNoUser}" />
                        </div>
                    </c:if>
                </div>
            </div>
            <div class="row">
                <hr>
            </div>
            <div class="row">

                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-hover table-bordered table-sm">
                                <thead>
                                    <tr>
                                        <th>
                                            Name
                                        </th>
                                        <th>
                                            Rating
                                        </th>

                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${programs == null && programs == []}">
                                        <tr>
                                            <td>
                                                no hay ratings por el momento, agrega uno
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:forEach items="${ program.ratings }" var="rating">
                                        <tr>
                                            <td>
                                                <c:out value="${ rating.name }" />
                                            </td>
                                            <td>
                                                <c:out value="${ rating.score }" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </div>


                </div>

            </div>

        </div>
        <form:form action="/programs/${program.id}/newRating" method="POST" modelAttribute="rating">
            <c:if test="${ invalidRating != null }">
                <div class="alert alert-danger" role="alert">
                    <c:out value="${invalidRating}" />
                </div>
            </c:if>
            <div class="row">
                <div class="col-md-6"></div>
                <form:input type="number" min="0.0" max="5.0" class="col-8" path="score" />
                <form:errors class="text-danger col-3" path="score" />
            </div>

            <div class="col-md-6">
                <input type="submit" class="btn btn-success" value="Rate!">
            </div>
        </form:form>
        </div>

        </div>
    </main>
</body>

</html>