<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login - EduManage Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="logo">🎓 EduManage Pro</h1>
            <p class="tagline">Student Portal</p>
        </header>

        <div class="login-form-container">
            <div class="login-form-card">
                <div class="form-header">
                    <div class="form-icon student-icon">👨‍🎓</div>
                    <h2>Student Login</h2>
                    <p>Access your student dashboard</p>
                </div>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <form method="post" action="student-login" class="login-form">
                    <div class="form-group">
                        <label for="studentId">Student ID</label>
                        <input type="text" id="studentId" name="studentId" required 
                               placeholder="Enter your student ID">
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required 
                               placeholder="Enter your password">
                    </div>

                    <button type="submit" class="btn btn-student btn-full">Login</button>
                </form>

                <div class="form-footer">
                    <p>Contact your administrator for login credentials</p>
                    <a href="index.jsp" class="back-link">← Back to Home</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>