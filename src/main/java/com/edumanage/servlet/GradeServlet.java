package com.edumanage.servlet;

import com.edumanage.dao.GradeDAO;
import com.edumanage.model.Grade;
import com.edumanage.model.Teacher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

public class GradeServlet extends HttpServlet {
    private GradeDAO gradeDAO;

    @Override
    public void init() throws ServletException {
        gradeDAO = new GradeDAO();
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
        
        if ("add".equals(action)) {
            addGrade(request, response);
        } else if ("update".equals(action)) {
            updateGrade(request, response);
        } else if ("delete".equals(action)) {
            deleteGrade(request, response);
        }
        
        response.sendRedirect("teacher-dashboard");
    }

    private void addGrade(HttpServletRequest request, HttpServletResponse response) {
        String id = UUID.randomUUID().toString();
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");
        String date = request.getParameter("date");

        Grade gradeObj = new Grade(id, studentId, studentName, subject, grade, date);
        gradeDAO.addGrade(gradeObj);
    }

    private void updateGrade(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("gradeId");
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");
        String date = request.getParameter("date");

        Grade gradeObj = new Grade(id, studentId, studentName, subject, grade, date);
        gradeDAO.updateGrade(gradeObj);
    }

    private void deleteGrade(HttpServletRequest request, HttpServletResponse response) {
        String gradeId = request.getParameter("gradeId");
        gradeDAO.deleteGrade(gradeId);
    }
}