<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Home</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }

        .header {
            background: #1f2937;
            color: white;
            padding: 18px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
        }

        .user-info {
            text-align: right;
            font-size: 14px;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        .info-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }

        .info-row {
            display: flex;
            margin-bottom: 15px;
        }

        .label {
            width: 150px;
            font-weight: bold;
        }

        .value {
            color: #374151;
            word-break: break-all;
        }

        .logout-btn {
            margin-top: 25px;
            padding: 10px 20px;
            background: #dc2626;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: #b91c1c;
        }
    </style>
</head>

<body>

<%
    String sessionId = session.getId();

    String loggedInUser = "Not logged in";

    if (request.getUserPrincipal() != null) {
        loggedInUser = request.getUserPrincipal().getName();
    }
%>

<div class="header">

    <h2>Task Tracker</h2>

    <div class="user-info">
        Logged in as: <strong><%= loggedInUser %></strong>
    </div>

</div>

<div class="container">

    <h2>Welcome, <%= loggedInUser %>!</h2>

    <div class="info-box">

        <div class="info-row">
            <div class="label">Username:</div>
            <div class="value">
                <%= loggedInUser %>
            </div>
        </div>

        <div class="info-row">
            <div class="label">Session ID:</div>
            <div class="value">
                <%= sessionId %>
            </div>
        </div>

        <div class="info-row">
            <div class="label">Session Created:</div>
            <div class="value">
                <%= new java.util.Date(session.getCreationTime()) %>
            </div>
        </div>

        <div class="info-row">
            <div class="label">Last Accessed:</div>
            <div class="value">
                <%= new java.util.Date(session.getLastAccessedTime()) %>
            </div>
        </div>

    </div>

    <form action="${pageContext.request.contextPath}/tracker/logout"
          method="post">

        <button type="submit" class="logout-btn">
            Logout
        </button>

    </form>

</div>

</body>
</html>
```
