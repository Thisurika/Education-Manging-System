<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.edumanage.model.Student" %>
<%@ page import="com.edumanage.model.Teacher" %>
<%@ page import="com.edumanage.model.Course" %>
<%@ page import="com.edumanage.model.Enrollment" %>
<%@ page import="com.edumanage.model.Grade" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - EduManage Pro</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 EduManage Pro</h2>
                <p>Student Portal</p>
            </div>
            
            <div class="user-info">
                <% Student student = (Student) session.getAttribute("student"); %>
                <div class="user-avatar">👨‍🎓</div>
                <h3><%= student.getName() %></h3>
                <p>Grade <%= student.getGrade() %> Student</p>
            </div>

            <ul class="nav-menu">
                <li><a href="#dashboard" class="nav-link active" onclick="showSection('dashboard')">📊 Dashboard</a></li>
                <li><a href="#courses" class="nav-link" onclick="showSection('courses')">📚 Available Courses</a></li>
                <li><a href="#enrollments" class="nav-link" onclick="showSection('enrollments')">📝 My Enrollments</a></li>
                <li><a href="#grades" class="nav-link" onclick="showSection('grades')">🏆 My Grades</a></li>
                <li><a href="#profile" class="nav-link" onclick="showSection('profile')">👤 My Profile</a></li>
                <li><a href="student-dashboard?action=logout" class="nav-link logout">🚪 Logout</a></li>
            </ul>
        </nav>

        <main class="main-content">
            <div id="dashboard" class="content-section active">
                <div class="section-header">
                    <h1>Student Dashboard</h1>
                </div>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon">📚</div>
                        <div class="stat-number">
                            <% 
                            List<Enrollment> enrollments = (List<Enrollment>) request.getAttribute("enrollments");
                            int enrollmentCount = (enrollments != null) ? enrollments.size() : 0;
                            %>
                            <%= enrollmentCount %>
                        </div>
                        <div class="stat-label">Enrolled Courses</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">🏆</div>
                        <div class="stat-number">
                            <% 
                            List<Grade> grades = (List<Grade>) request.getAttribute("grades");
                            int gradeCount = (grades != null) ? grades.size() : 0;
                            %>
                            <%= gradeCount %>
                        </div>
                        <div class="stat-label">Total Grades</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">📈</div>
                        <div class="stat-number">
                            <% 
                            double avgGrade = 0.0;
                            if (grades != null && !grades.isEmpty()) {
                                int totalPoints = 0;
                                for (Grade grade : grades) {
                                    switch(grade.getGrade()) {
                                        case "A": totalPoints += 4; break;
                                        case "B": totalPoints += 3; break;
                                        case "C": totalPoints += 2; break;
                                        case "D": totalPoints += 1; break;
                                        default: totalPoints += 0; break;
                                    }
                                }
                                avgGrade = (double) totalPoints / grades.size();
                            }
                            %>
                            <%= String.format("%.1f", avgGrade) %>
                        </div>
                        <div class="stat-label">Average GPA</div>
                    </div>
                    
                    <div class="stat-card">
                        <div class="stat-icon">👩‍🏫</div>
                        <div class="stat-number">
                            <% 
                            List<Teacher> teachers = (List<Teacher>) request.getAttribute("teachers");
                            int teacherCount = (teachers != null) ? teachers.size() : 0;
                            %>
                            <%= teacherCount %>
                        </div>
                        <div class="stat-label">Available Teachers</div>
                    </div>
                </div>
            </div>

            <div id="courses" class="content-section">
                <div class="section-header">
                    <h1>Available Courses</h1>
                </div>

                <div class="courses-grid">
                    <% 
                    List<Course> courses = (List<Course>) request.getAttribute("courses");
                    if (courses != null && !courses.isEmpty()) {
                        for (Course course : courses) {
                    %>
                        <div class="course-card">
                            <div class="course-avatar">📚</div>
                            <div class="course-info">
                                <h3><%= course.getCourseName() %></h3>
                                <p><strong>Course Code:</strong> <%= course.getCourseCode() %></p>
                                <p><strong>Teacher:</strong> <%= course.getTeacherName() %></p>
                                <p><strong>Department:</strong> <%= course.getDepartment() %></p>
                                <p><strong>Credits:</strong> <%= course.getCredits() %></p>
                                <p><strong>Schedule:</strong> <%= course.getSchedule() %></p>
                                <p><strong>Description:</strong> <%= course.getDescription() %></p>
                            </div>
                            <div class="course-actions">
                                <form method="post" action="student-dashboard" style="display: inline;">
                                    <input type="hidden" name="action" value="enroll">
                                    <input type="hidden" name="courseId" value="<%= course.getId() %>">
                                    <button type="submit" class="btn btn-success btn-sm">Enroll Now</button>
                                </form>
                            </div>
                        </div>
                    <% 
                        }
                    } else {
                    %>
                        <div class="empty-state">
                            <h3>No courses available</h3>
                            <p>Check back later for new course offerings</p>
                        </div>
                    <% } %>
                </div>
            </div>

            <div id="enrollments" class="content-section">
                <div class="section-header">
                    <h1>My Course Enrollments</h1>
                </div>

                <div class="enrollments-grid">
                    <% 
                    if (enrollments != null && !enrollments.isEmpty()) {
                        for (Enrollment enrollment : enrollments) {
                    %>
                        <div class="enrollment-card">
                            <div class="course-avatar">📝</div>
                            <div class="course-info">
                                <h3><%= enrollment.getCourseName() %></h3>
                                <p><strong>Course Code:</strong> <%= enrollment.getCourseCode() %></p>
                                <p><strong>Teacher:</strong> <%= enrollment.getTeacherName() %></p>
                                <p><strong>Enrollment Date:</strong> <%= enrollment.getEnrollmentDate() %></p>
                                <p><strong>Status:</strong> 
                                    <span class="grade-badge grade-<%= enrollment.getStatus().toLowerCase() %>">
                                        <%= enrollment.getStatus() %>
                                    </span>
                                </p>
                            </div>
                            <div class="course-actions">
                                <% if ("ACTIVE".equals(enrollment.getStatus())) { %>
                                    <form method="post" action="student-dashboard" style="display: inline;">
                                        <input type="hidden" name="action" value="unenroll">
                                        <input type="hidden" name="enrollmentId" value="<%= enrollment.getId() %>">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to unenroll from this course?')">Unenroll</button>
                                    </form>
                                <% } %>
                            </div>
                        </div>
                    <% 
                        }
                    } else {
                    %>
                        <div class="empty-state">
                            <h3>No course enrollments</h3>
                            <p>Enroll in courses to see them here</p>
                        </div>
                    <% } %>
                </div>
            </div>

            <div id="grades" class="content-section">
                <div class="section-header">
                    <h1>My Grades</h1>
                </div>

                <div class="grade-container">
                    <h3>Grade Report</h3>
                    <table class="grade-table">
                        <thead>
                            <tr>
                                <th>Course</th>
                                <th>Teacher</th>
                                <th>Grade</th>
                                <th>Date</th>
                                <th>GPA Points</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            if (grades != null && !grades.isEmpty()) {
                                for (Grade grade : grades) {
                                    String gpaPoints = "";
                                    switch(grade.getGrade()) {
                                        case "A": gpaPoints = "4.0"; break;
                                        case "B": gpaPoints = "3.0"; break;
                                        case "C": gpaPoints = "2.0"; break;
                                        case "D": gpaPoints = "1.0"; break;
                                        default: gpaPoints = "0.0"; break;
                                    }
                            %>
                                <tr>
                                    <td><%= grade.getSubject() %></td>
                                    <td><%= grade.getTeacherName() != null ? grade.getTeacherName() : "N/A" %></td>
                                    <td>
                                        <span class="grade-badge grade-<%= grade.getGrade().toLowerCase() %>">
                                            <%= grade.getGrade() %>
                                        </span>
                                    </td>
                                    <td><%= grade.getDate() %></td>
                                    <td><%= gpaPoints %></td>
                                </tr>
                            <% 
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="5" style="text-align: center; color: #7f8c8d;">No grades available yet</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div id="profile" class="content-section">
                <div class="section-header">
                    <h1>My Profile</h1>
                </div>

                <div class="search-container">
                    <div class="student-card" style="max-width: 600px; margin: 0 auto;">
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
                            <button class="btn btn-primary" onclick="editProfile()">Edit Profile</button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="js/dashboard.js"></script>
</body>
</html>