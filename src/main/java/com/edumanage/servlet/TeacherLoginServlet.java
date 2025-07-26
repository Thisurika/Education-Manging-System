package com.edumanage.servlet;

import com.edumanage.dao.TeacherDAO;
import com.edumanage.model.Teacher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class TeacherLoginServlet extends HttpServlet {
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        teacherDAO = new TeacherDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Teacher teacher = teacherDAO.getTeacherByUsername(username);
        
        if (teacher != null && teacher.authenticate(username, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("teacher", teacher);
            response.sendRedirect("teacher-dashboard");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("teacher-login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("teacher-login.jsp").forward(request, response);
    }
}