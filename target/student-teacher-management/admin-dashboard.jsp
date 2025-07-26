<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.edumanage.model.Teacher" %>
<%@ page import="com.edumanage.model.Student" %>
<%@ page import="com.edumanage.model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - EduManage Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 EduManage Pro</h2>
                <p>Administrator Portal</p>
            </div>
            
            <div class="user-info">
                <% Admin admin = (Admin) session.getAttribute("admin"); %>
                <div class="user-avatar">👨‍💼</div>
                <h3><%= admin.getName() %></h3>
                <p><%= admin.getRole() %></p>
            </div>

            <ul class="nav-menu">
                <li><a href="#dashboard" class="nav-link active" onclick="showSection('dashboard')">📊 Dashboard</a></li>
                <li><a href="#teachers" class="nav-link" onclick="showSection('teachers')">👩‍🏫 Manage Teachers</a></li>
                <li><a href="#students" class="nav-link" onclick="showSection('students')">👨‍🎓 Manage Students</a></li>
                <li><a href="#reports" class="nav-link" onclick="showSection('reports')">📈 Reports</a></li>
                <li><a href="admin-dashboard?action=logout" class="nav-link logout">🚪 Logout</a></li>
            </ul>
        </nav>

        <main class="main-content">
            <div id="dashboard" class="content-section active">
                <div class="section-header">
                    <h1>Dashboard Overview</h1>
                </div>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon">👩‍🏫</div>
                        <div class="stat-number">
                            <% 
                            List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
                            int teacherCount = (teachers != null) ? teachers.size() : 0;
                            %>
                            <%= teacherCount %>
                        </div>
                        <div class="stat-label">Total Teachers</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">👨‍🎓</div>
                        <div class="stat-number">
                            <% 
                            List<Student> students = (List<Student>) request.getAttribute("students");
                            int studentCount = (students != null) ? students.size() : 0;
                            %>
                            <%= studentCount %>
                        </div>
                        <div class="stat-label">Total Students</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">📚</div>
                        <div class="stat-number">12</div>
                        <div class="stat-label">Active Courses</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">🏆</div>
                        <div class="stat-number">85%</div>
                        <div class="stat-label">Success Rate</div>
                    </div>
                </div>
            </div>

            <div id="teachers" class="content-section">
                <div class="section-header">
                    <h1>Teacher Management</h1>
                    <button class="btn btn-primary" onclick="showAddTeacherModal()">+ Add New Teacher</button>
                </div>

                <div class="teachers-grid">
                    <% 
                    if (teachers != null && !teachers.isEmpty()) {
                        for (Teacher teacher : teachers) {
                    %>
                        <div class="teacher-card">
                            <div class="teacher-avatar">👩‍🏫</div>
                            <div class="teacher-info">
                                <h3><%= teacher.getName() %></h3>
                                <p><strong>Username:</strong> <%= teacher.getUsername() %></p>
                                <p><strong>Email:</strong> <%= teacher.getEmail() %></p>
                                <p><strong>Employee ID:</strong> <%= teacher.getEmployeeId() %></p>
                                <p><strong>Subject:</strong> <%= teacher.getSubject() %></p>
                                <p><strong>Department:</strong> <%= teacher.getDepartment() %></p>
                            </div>
                            <div class="teacher-actions">
                                <button class="btn btn-secondary btn-sm" onclick="editTeacher('<%= teacher.getId() %>', '<%= teacher.getUsername() %>', '<%= teacher.getName() %>', '<%= teacher.getEmail() %>', '<%= teacher.getEmployeeId() %>', '<%= teacher.getSubject() %>', '<%= teacher.getDepartment() %>')">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteTeacher('<%= teacher.getId() %>')">Delete</button>
                            </div>
                        </div>
                    <% 
                        }
                    } else {
                    %>
                        <div class="empty-state">
                            <h3>No teachers found</h3>
                            <p>Add your first teacher to get started</p>
                        </div>
                    <% } %>
                </div>
            </div>

            <div id="students" class="content-section">
                <div class="section-header">
                    <h1>Student Management</h1>
                    <button class="btn btn-primary" onclick="showAddStudentModal()">+ Add New Student</button>
                </div>

                <div class="students-grid">
                    <% 
                    if (students != null && !students.isEmpty()) {
                        for (Student student : students) {
                    %>
                        <div class="student-card">
                            <div class="student-avatar">👨‍🎓</div>
                            <div class="student-info">
                                <h3><%= student.getName() %></h3>
                                <p><strong>Student ID:</strong> <%= student.getStudentId() %></p>
                                <p><strong>Email:</strong> <%= student.getEmail() %></p>
                                <p><strong>Grade:</strong> <%= student.getGrade() %></p>
                                <p><strong>Class:</strong> <%= student.getClassName() %></p>
                                <p><strong>Phone:</strong> <%= student.getPhone() %></p>
                            </div>
                            <div class="student-actions">
                                <button class="btn btn-secondary btn-sm" onclick="editStudent('<%= student.getId() %>', '<%= student.getName() %>', '<%= student.getEmail() %>', '<%= student.getStudentId() %>', '<%= student.getGrade() %>', '<%= student.getClassName() %>', '<%= student.getPhone() %>')">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteStudent('<%= student.getId() %>')">Delete</button>
                            </div>
                        </div>
                    <% 
                        }
                    } else {
                    %>
                        <div class="empty-state">
                            <h3>No students found</h3>
                            <p>Add your first student to get started</p>
                        </div>
                    <% } %>
                </div>
            </div>

            <div id="reports" class="content-section">
                <div class="section-header">
                    <h1>System Reports</h1>
                </div>
                
                <div class="search-container">
                    <h3>Generate Reports</h3>
                    <div class="search-form">
                        <div class="form-group">
                            <label for="reportType">Report Type</label>
                            <select id="reportType" name="reportType">
                                <option value="students">Student Report</option>
                                <option value="teachers">Teacher Report</option>
                                <option value="grades">Grade Report</option>
                                <option value="attendance">Attendance Report</option>
                            </select>
                        </div>
                        <button class="btn btn-primary">Generate Report</button>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Add Teacher Modal -->
    <div id="addTeacherModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Teacher</h2>
                <span class="close" onclick="closeModal('addTeacherModal')">&times;</span>
            </div>
            <form method="post" action="admin-dashboard">
                <input type="hidden" name="action" value="addTeacher">
                <div class="form-group">
                    <label for="teacherId">Teacher ID</label>
                    <input type="text" id="teacherId" name="id" required>
                </div>
                <div class="form-group">
                    <label for="teacherUsername">Username</label>
                    <input type="text" id="teacherUsername" name="username" required>
                </div>
                <div class="form-group">
                    <label for="teacherPassword">Password</label>
                    <input type="password" id="teacherPassword" name="password" required>
                </div>
                <div class="form-group">
                    <label for="teacherName">Full Name</label>
                    <input type="text" id="teacherName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="teacherEmail">Email</label>
                    <input type="email" id="teacherEmail" name="email" required>
                </div>
                <div class="form-group">
                    <label for="employeeId">Employee ID</label>
                    <input type="text" id="employeeId" name="employeeId" required>
                </div>
                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject" required>
                </div>
                <div class="form-group">
                    <label for="department">Department</label>
                    <input type="text" id="department" name="department" required>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addTeacherModal')">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Teacher</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add Student Modal -->
    <div id="addStudentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Student</h2>
                <span class="close" onclick="closeModal('addStudentModal')">&times;</span>
            </div>
            <form method="post" action="admin-dashboard">
                <input type="hidden" name="action" value="addStudent">
                <div class="form-group">
                    <label for="studentIdInput">Student ID</label>
                    <input type="text" id="studentIdInput" name="id" required>
                </div>
                <div class="form-group">
                    <label for="studentName">Full Name</label>
                    <input type="text" id="studentName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="studentEmail">Email</label>
                    <input type="email" id="studentEmail" name="email" required>
                </div>
                <div class="form-group">
                    <label for="studentNumber">Student Number</label>
                    <input type="text" id="studentNumber" name="studentId" required>
                </div>
                <div class="form-group">
                    <label for="studentGrade">Grade</label>
                    <select id="studentGrade" name="grade" required>
                        <option value="">Select Grade</option>
                        <option value="1">Grade 1</option>
                        <option value="2">Grade 2</option>
                        <option value="3">Grade 3</option>
                        <option value="4">Grade 4</option>
                        <option value="5">Grade 5</option>
                        <option value="6">Grade 6</option>
                        <option value="7">Grade 7</option>
                        <option value="8">Grade 8</option>
                        <option value="9">Grade 9</option>
                        <option value="10">Grade 10</option>
                        <option value="11">Grade 11</option>
                        <option value="12">Grade 12</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="className">Class</label>
                    <input type="text" id="className" name="className" required>
                </div>
                <div class="form-group">
                    <label for="studentPhone">Phone</label>
                    <input type="tel" id="studentPhone" name="phone" required>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addStudentModal')">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Student</button>
                </div>
            </form>
        </div>
    </div>

    <script src="js/dashboard.js"></script>
</body>
</html>