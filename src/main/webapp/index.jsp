<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduManage Pro - Login</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1 class="logo">🎓 EduManage Pro</h1>
            <p class="tagline">Comprehensive Student & Teacher Management System</p>
        </header>

        <div class="login-container">
            <div class="login-card">
                <h2>Welcome to EduManage Pro!</h2>
                <p>Choose your login type to access the system</p>
                
                <div class="login-options">
                    <div class="login-option">
                        <div class="option-icon admin-icon">👨‍💼</div>
                        <h3>Administrator Login</h3>
                        <p>Manage teachers, students, and system settings</p>
                        <a href="admin-login" class="btn btn-admin">Login as Admin</a>
                    </div>
                    
                    <div class="login-option">
                        <div class="option-icon teacher-icon">👩‍🏫</div>
                        <h3>Teacher Login</h3>
                        <p>Manage students, grades, and class activities</p>
                        <a href="teacher-login" class="btn btn-teacher">Login as Teacher</a>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">
            <p>&copy; 2024 EduManage Pro. All rights reserved.</p>
        </footer>
    </div>
</body>
</html>