<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Table</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

</head>

<body>
    <header class="bg-primary p-2 mb-5">
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
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
        <h2>Create a new program</h2>
        <div class="container-fluid">
            <form:form action="/program/new" method="POST" modelAttribute="program">
                <div class="form-group">
                    <c:if test="${ errorName != null }" >
                        <div class="alert alert-danger" role="alert">
                            <c:out value="${errorName}"/>
                          </div>
                    </c:if>
                    <form:label path="name" for="name">Name</form:label>
                    <form:errors path="name" class="badge text-bg-primary" />
                    <form:input type="text" class="form-control" id="name" path="name" />
                </div>
                <div class="form-group">
                    <form:label path="red" for="red">Red</form:label>
                    <form:errors path="red" class="badge text-bg-primary" />
                    <form:input type="text" class="form-control" id="red" path="red" />
                </div>
                <div class="form-group">
                    <form:label path="description" for="description">Description</form:label>
                    <form:errors path="description" class="badge text-bg-primary" />
                    <form:input type="text" class="form-control" id="description" path="description" />
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        Submit
                    </button>

                    <button class="btn btn-success" onclick="location.href='/home'" type="button">Cancel</button>
                </div>

            </form:form>
        </div>
    </main>

</body>

</html>