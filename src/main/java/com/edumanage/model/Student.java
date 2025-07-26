package com.edumanage.model;

public class Student extends Person {
    private String studentId;
    private String grade;
    private String className;
    private String phone;

    // Default constructor
    public Student() {
        super();
    }

    // Parameterized constructor
    public Student(String id, String name, String email, String studentId, 
                  String grade, String className, String phone) {
        super();
        setId(id);
        setName(name);
        setEmail(email);
        this.studentId = studentId;
        this.grade = grade;
        this.className = className;
        this.phone = phone;
    }

    // Getters
    public String getStudentId() {
        return studentId;
    }

    public String getGrade() {
        return grade;
    }

    public String getClassName() {
        return className;
    }

    public String getPhone() {
        return phone;
    }

    // Setters
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String getRole() {
        return "STUDENT";
    }

    @Override
    public String toString() {
        return getId() + "," + getName() + "," + getEmail() + "," + studentId + "," + grade + "," + className + "," + phone;
    }

    // Static method to create Student from string data
    public static Student fromString(String data) {
        String[] parts = data.split(",");
        if (parts.length >= 7) {
            return new Student(parts[0], parts[1], parts[2], parts[3], 
                             parts[4], parts[5], parts[6]);
        }
        return null;
    }
}