    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Registration Successful -Task Tracker</title>
        <meta charset = "UTF-8">
        <spring:url value="/css/verifyUserStyle.css" var="jspcss"/>
        <link rel="stylesheet" type="text/css" href="${jspcss}"/>
    </head>
    <body>
    <div class="card">
        <div class="verify-container">
            <div class="glass-card">
            <div class="success-icon">
        <svg width="32" height="32"
        viewBox="0 0 24 24"
        fill="none"
         stroke="#1D9E75"
         stroke-width="2.5"
         stroke-linecap="round"
         stroke-linejoin="round">
         <polyline points="20 6 9 17 4 12"/>
         </svg>
         </div>
          <h2>Registration Successful!</h2>
          <p class="subtitle"> Your Task Tracker account has been created successfully. </p>
          <div class="message-box"> <p> We have sent a verification link to your email address. </p>
          <p> <strong> Please check your inbox and click the verification link to activate your account. </strong> </p>
           </div> <a href="/tracker/login" class="btn-login"> Go to Login Page </a>
           <p class="footer-text">
           Didn't receive the email? Please check your spam or junk folder. </p>
           </div>
            </div>
    </div>
    </body>
    </html>