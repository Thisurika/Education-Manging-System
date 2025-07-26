<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Login - EduManage Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="logo">🎓 EduManage Pro</h1>
            <p class="tagline">Teacher Portal</p>
        </header>

        <div class="login-form-container">
            <div class="login-form-card">
                <div class="form-header">
                    <div class="form-icon teacher-icon">👩‍🏫</div>
                    <h2>Teacher Login</h2>
                    <p>Access your teaching dashboard</p>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form method="post" action="teacher-login" class="login-form">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required 
                               placeholder="Enter your username">
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Enter your password">
                    </div>

                    <button type="submit" class="btn btn-teacher btn-full">Login</button>
                </form>

                <div class="form-footer">
                    <p>Contact administrator for login credentials</p>
                    <a href="index.jsp" class="back-link">← Back to Home</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>