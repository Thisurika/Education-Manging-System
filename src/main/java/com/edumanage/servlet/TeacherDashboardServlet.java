package com.edumanage.servlet;

import com.edumanage.dao.StudentDAO;
import com.edumanage.dao.GradeDAO;
import com.edumanage.model.Teacher;
import com.edumanage.model.Student;
import com.edumanage.model.Grade;
import com.edumanage.utils.BinarySearch;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class TeacherDashboardServlet extends HttpServlet {
    private StudentDAO studentDAO;
    private GradeDAO gradeDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
        gradeDAO = new GradeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        
        if (teacher == null) {
            response.sendRedirect("teacher-login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            session.invalidate();
            response.sendRedirect("index.jsp");
            return;
        } else if ("search".equals(action)) {
            searchStudents(request, response);
            return;
        }

        List<Student> students = studentDAO.getAllStudents();
        List<Grade> grades = gradeDAO.getGradesBySubject(teacher.getSubject());
        
        request.setAttribute("students", students);
        request.setAttribute("grades", grades);
        request.getRequestDispatcher("teacher-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Teacher teacher = (Teacher) session.getAttribute("teacher");
        
        if (teacher == null) {
            response.sendRedirect("teacher-login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("addStudent".equals(action)) {
            addStudent(request, response);
        } else if ("updateStudent".equals(action)) {
            updateStudent(request, response);
        } else if ("deleteStudent".equals(action)) {
            deleteStudent(request, response);
        }
        
        response.sendRedirect("teacher-dashboard");
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

    private void searchStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String searchValue = request.getParameter("searchValue");
        
        List<Student> allStudents = studentDAO.getAllStudents();
        List<Student> searchResults = null;
        
        if ("grade".equals(searchType)) {
            searchResults = BinarySearch.searchStudentsByGrade(allStudents, searchValue);
        } else if ("class".equals(searchType)) {
            searchResults = BinarySearch.searchStudentsByClass(allStudents, searchValue);
        } else if ("name".equals(searchType)) {
            searchResults = BinarySearch.searchStudentsByName(allStudents, searchValue);
        }
        
        List<Grade> grades = gradeDAO.getAllGrades();
        
        request.setAttribute("students", allStudents);
        request.setAttribute("grades", grades);
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchValue", searchValue);
        request.getRequestDispatcher("teacher-dashboard.jsp").forward(request, response);
    }
}