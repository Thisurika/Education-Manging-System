<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.edumanage.model.Student" %>
<%@ page import="com.edumanage.model.Teacher" %>
<%@ page import="com.edumanage.model.Grade" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard - EduManage Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 EduManage Pro</h2>
                <p>Teacher Portal</p>
            </div>
            
            <div class="user-info">
                <% Teacher teacher = (Teacher) session.getAttribute("teacher"); %>
                <div class="user-avatar">👩‍🏫</div>
                <h3><%= teacher.getName() %></h3>
                <p><%= teacher.getSubject() %> Teacher</p>
            </div>

            <ul class="nav-menu">
                <li><a href="#students" class="nav-link active" onclick="showSection('students')">👨‍🎓 My Students</a></li>
                <li><a href="#grades" class="nav-link" onclick="showSection('grades')">📊 Grade Management</a></li>
                <li><a href="#search" class="nav-link" onclick="showSection('search')">🔍 Search Students</a></li>
                <li><a href="#profile" class="nav-link" onclick="showSection('profile')">👤 My Profile</a></li>
                <li><a href="teacher-dashboard?action=logout" class="nav-link logout">🚪 Logout</a></li>
            </ul>
        </nav>

        <main class="main-content">
            <div id="students" class="content-section active">
                <div class="section-header">
                    <h1>My Students</h1>
                    <button class="btn btn-primary" onclick="showAddStudentModal()">+ Add New Student</button>
                </div>

                <div class="students-grid">
                    <% 
                    List<Student> students = (List<Student>) request.getAttribute("students");
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
                                <button class="btn btn-success btn-sm" onclick="addGrade('<%= student.getId() %>', '<%= student.getName() %>')">Add Grade</button>
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

            <div id="grades" class="content-section">
                <div class="section-header">
                    <h1>Grade Management</h1>
                </div>

                <div class="grade-container">
                    <h3>Student Grades</h3>
                    <table class="grade-table">
                        <thead>
                            <tr>
                                <th>Student Name</th>
                                <th>Student ID</th>
                                <th>Subject</th>
                                <th>Grade</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            List<Grade> grades = (List<Grade>) request.getAttribute("grades");
                            if (grades != null && !grades.isEmpty()) {
                                for (Grade grade : grades) {
                            %>
                                <tr>
                                    <td><%= grade.getStudentName() %></td>
                                    <td><%= grade.getStudentId() %></td>
                                    <td><%= grade.getSubject() %></td>
                                    <td>
                                        <span class="grade-badge grade-<%= grade.getGrade().toLowerCase() %>">
                                            <%= grade.getGrade() %>
                                        </span>
                                    </td>
                                    <td><%= grade.getDate() %></td>
                                    <td>
                                        <button class="btn btn-secondary btn-sm" onclick="editGrade('<%= grade.getId() %>', '<%= grade.getStudentId() %>', '<%= grade.getSubject() %>', '<%= grade.getGrade() %>')">Edit</button>
                                        <button class="btn btn-danger btn-sm" onclick="deleteGrade('<%= grade.getId() %>')">Delete</button>
                                    </td>
                                </tr>
                            <% 
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="6" style="text-align: center; color: #7f8c8d;">No grades recorded yet</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="search" class="content-section">
                <div class="section-header">
                    <h1>Search Students</h1>
                </div>

                <div class="search-container">
                    <form method="get" action="teacher-dashboard" class="search-form">
                        <input type="hidden" name="action" value="search">
                        <div class="form-group">
                            <label for="searchType">Search By</label>
                            <select id="searchType" name="searchType" required>
                                <option value="">Select search type</option>
                                <option value="grade">Grade Level</option>
                                <option value="class">Class Name</option>
                                <option value="name">Student Name</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="searchValue">Search Value</label>
                            <input type="text" id="searchValue" name="searchValue" required placeholder="Enter search term">
                        </div>
                        <button type="submit" class="btn btn-primary">Search with Binary Search</button>
                    </form>

                    <% String searchType = (String) request.getAttribute("searchType"); %>
                    <% if (searchType != null) { %>
                        <div class="search-results">
                            <h3>Search Results for "<%= request.getAttribute("searchValue") %>"</h3>
                            <div class="students-grid">
                                <% 
                                List<Student> searchStudents = (List<Student>) request.getAttribute("searchResults");
                                if (searchStudents != null && !searchStudents.isEmpty()) {
                                    for (Student student : searchStudents) {
                                %>
                                    <div class="student-card">
                                        <div class="student-avatar">👨‍🎓</div>
                                        <div class="student-info">
                                            <h3><%= student.getName() %></h3>
                                            <p><strong>Student ID:</strong> <%= student.getStudentId() %></p>
                                            <p><strong>Email:</strong> <%= student.getEmail() %></p>
                                            <p><strong>Grade:</strong> <%= student.getGrade() %></p>
                                            <p><strong>Class:</strong> <%= student.getClassName() %></p>
                                        </div>
                                        <div class="student-actions">
                                            <button class="btn btn-success btn-sm" onclick="addGrade('<%= student.getId() %>', '<%= student.getName() %>')">Add Grade</button>
                                        </div>
                                    </div>
                                <% 
                                    }
                                } else {
                                %>
                                    <p>No students found matching your search criteria.</p>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>

            <div id="profile" class="content-section">
                <div class="section-header">
                    <h1>My Profile</h1>
                </div>

                <div class="search-container">
                    <div class="teacher-card" style="max-width: 600px; margin: 0 auto;">
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
                            <button class="btn btn-primary" onclick="editProfile()">Edit Profile</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Add Student Modal -->
    <div id="addStudentModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Student</h2>
                <span class="close" onclick="closeModal('addStudentModal')">&times;</span>
            </div>
            <form method="post" action="teacher-dashboard">
                <input type="hidden" name="action" value="addStudent">
                <div class="form-group">
                    <label for="studentId">Student ID</label>
                    <input type="text" id="studentId" name="id" required>
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

    <!-- Add Grade Modal -->
    <div id="addGradeModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add Grade</h2>
                <span class="close" onclick="closeModal('addGradeModal')">&times;</span>
            </div>
            <form method="post" action="grades">
                <input type="hidden" name="action" value="add">
                <input type="hidden" id="gradeStudentId" name="studentId">
                <div class="form-group">
                    <label for="gradeStudentName">Student Name</label>
                    <input type="text" id="gradeStudentName" name="studentName" readonly>
                </div>
                <div class="form-group">
                    <label for="gradeSubject">Subject</label>
                    <input type="text" id="gradeSubject" name="subject" value="<%= teacher.getSubject() %>" readonly>
                </div>
                <div class="form-group">
                    <label for="gradeValue">Grade</label>
                    <select id="gradeValue" name="grade" required>
                        <option value="">Select Grade</option>
                        <option value="A">A - Excellent</option>
                        <option value="B">B - Good</option>
                        <option value="C">C - Average</option>
                        <option value="D">D - Below Average</option>
                        <option value="F">F - Fail</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="gradeDate">Date</label>
                    <input type="date" id="gradeDate" name="date" required>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('addGradeModal')">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Grade</button>
                </div>
            </form>
        </div>
    </div>

    <script src="js/dashboard.js"></script>
</body>
</html>