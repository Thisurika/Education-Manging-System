package com.edumanage.servlet;

import com.edumanage.dao.TeacherDAO;
import com.edumanage.dao.StudentDAO;
import com.edumanage.model.Admin;
import com.edumanage.model.Teacher;
import com.edumanage.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    private TeacherDAO teacherDAO;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        
        if (admin == null) {
            response.sendRedirect("admin-login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect("index.jsp");
            return;
        }

        List<Teacher> teachers = teacherDAO.getAllTeachers();
        List<Student> students = studentDAO.getAllStudents();
        
        request.setAttribute("teachers", teachers);
        request.setAttribute("students", students);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        
        if (admin == null) {
            response.sendRedirect("admin-login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("addTeacher".equals(action)) {
            addTeacher(request, response);
        } else if ("updateTeacher".equals(action)) {
            updateTeacher(request, response);
        } else if ("deleteTeacher".equals(action)) {
            deleteTeacher(request, response);
        } else if ("addStudent".equals(action)) {
            addStudent(request, response);
        } else if ("updateStudent".equals(action)) {
            updateStudent(request, response);
        } else if ("deleteStudent".equals(action)) {
            deleteStudent(request, response);
        }
        
        response.sendRedirect("admin-dashboard");
    }

    private void addTeacher(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String employeeId = request.getParameter("employeeId");
        String subject = request.getParameter("subject");
        String department = request.getParameter("department");

        Teacher teacher = new Teacher(id, username, password, name, email, employeeId, subject, department);
        teacherDAO.addTeacher(teacher);
    }

    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String employeeId = request.getParameter("employeeId");
        String subject = request.getParameter("subject");
        String department = request.getParameter("department");

        Teacher teacher = new Teacher(id, username, password, name, email, employeeId, subject, department);
        teacherDAO.updateTeacher(teacher);
    }

    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) {
        String teacherId = request.getParameter("teacherId");
        teacherDAO.deleteTeacher(teacherId);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String studentId = request.getParameter("studentId");
        String grade = request.getParameter("grade");
        String className = request.getParameter("className");
        String phone = request.getParameter("phone");

        Student student = new Student(id, name, email, studentId, grade, className, phone);
        studentDAO.addStudent(student);
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String studentId = request.getParameter("studentId");
        String grade = request.getParameter("grade");
        String className = request.getParameter("className");
        String phone = request.getParameter("phone");

        Student student = new Student(id, name, email, studentId, grade, className, phone);
        studentDAO.updateStudent(student);
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) {
        String studentId = request.getParameter("studentId");
        studentDAO.deleteStudent(studentId);
    }
}