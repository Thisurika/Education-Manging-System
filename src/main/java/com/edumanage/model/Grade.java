package com.edumanage.model;

public class Grade {
    private String id;
    private String studentId;
    private String studentName;
    private String subject;
    private String grade;
    private String date;

    // Default constructor
    public Grade() {}

    // Parameterized constructor
    public Grade(String id, String studentId, String studentName, String subject, String grade, String date) {
        this.id = id;
        this.studentId = studentId;
        this.studentName = studentName;
        this.subject = subject;
        this.grade = grade;
        this.date = date;
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public String getSubject() {
        return subject;
    }

    public String getGrade() {
        return grade;
    }

    public String getDate() {
        return date;
    }

    // Setters
    public void setId(String id) {
        this.id = id;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public void setDate(String date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return id + "," + studentId + "," + studentName + "," + subject + "," + grade + "," + date;
    }

    // Static method to create Grade from string data
    public static Grade fromString(String data) {
        String[] parts = data.split(",");
        if (parts.length >= 6) {
            return new Grade(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5]);
        }
        return null;
    }
}