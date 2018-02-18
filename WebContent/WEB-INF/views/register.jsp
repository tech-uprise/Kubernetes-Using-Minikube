    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
        <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>Registration</title>
        </head>
        <body>
        		<form:form id="regForm" modelAttribute="user" action="registerProcess" method="post">
                <table align="center">
                    <tr>
                        <td>
                            <form:label path="username">Username</form:label>
                        </td>
                        <td>
                            <form:input path="username" name="username" id="username" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="password">Password</form:label>
                        </td>
                        <td>
                            <form:password path="password" name="password" id="password" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="firstname">First Name</form:label>
                        </td>
                        <td>
                            <form:input path="firstname" name="firstname" id="firstname" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="lastname">Last Name</form:label>
                        </td>
                        <td>
                            <form:input path="lastname" name="lastname" id="lastname" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="email">Email</form:label>
                        </td>
                        <td>
                            <form:input path="email" name="email" id="email" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="streetnumber">Street Number</form:label>
                        </td>
                        <td>
                            <form:input path="streetnumber" name="streetnumber" id="streetnumber" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="streetname">Street Name</form:label>
                        </td>
                        <td>
                            <form:input path="streetname" name="streetname" id="streetname" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="city">City</form:label>
                        </td>
                        <td>
                            <form:input path="city" name="city" id="city" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="state">State</form:label>
                        </td>
                        <td>
                            <form:input path="state" name="state" id="state" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="zipcode">Zip Code</form:label>
                        </td>
                        <td>
                            <form:input path="zipcode" name="zipcode" id="zipcode" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="phone">Phone</form:label>
                        </td>
                        <td>
                            <form:input path="phone" name="phone" id="phone" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="favoritemovie">Favorite Movie</form:label>
                        </td>
                        <td>
                            <form:input path="favoritemovie" name="favoritemovie" id="favoritemovie" />
                        </td>
                    </tr>
                     <tr>
                       <td>
                            <form:label path="favoritebook">Favorite Book</form:label>
                        </td>
                        <td>
                            <form:input path="favoritebook" name="favoritebook" id="favoritebook" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="favoriteplace">Favorite Place</form:label>
                        </td>
                        <td>
                            <form:input path="favoriteplace" name="favoriteplace" id="favoriteplace" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="favoritefood">Favorite Food</form:label>
                        </td>
                        <td>
                            <form:input path="favoritefood" name="favoritefood" id="favoritefood" />
                        </td>
                    </tr>
                   <tr>
                       <td>
                            <form:label path="schoolname">School Name</form:label>
                        </td>
                        <td>
                            <form:input path="schoolname" name="schoolname" id="schoolname" />
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <form:label path="grade">Grade</form:label>
                        </td>
                        <td>
                            <form:input path="grade" name="grade" id="grade" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <form:button id="register" name="register">Register</form:button>
                        </td>
                    </tr>
                    <tr></tr>

                </table>
            </form:form>
        </body>
        </html>