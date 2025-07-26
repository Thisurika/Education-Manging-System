package com.edumanage.model;

public class Teacher extends Person {
    private String employeeId;
    private String subject;
    private String department;

    // Default constructor
    public Teacher() {
        super();
    }

    // Parameterized constructor
    public Teacher(String id, String username, String password, String name, String email, 
                  String employeeId, String subject, String department) {
        super(id, username, password, name, email);
        this.employeeId = employeeId;
        this.subject = subject;
        this.department = department;
    }

    // Getters
    public String getEmployeeId() {
        return employeeId;
    }

    public String getSubject() {
        return subject;
    }

    public String getDepartment() {
        return department;
    }

    // Setters
    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    @Override
    public String getRole() {
        return "TEACHER";
    }

    @Override
    public String toString() {
        return super.toString() + "," + employeeId + "," + subject + "," + department;
    }

    // Static method to create Teacher from string data
    public static Teacher fromString(String data) {
        String[] parts = data.split(",");
        if (parts.length >= 8) {
            return new Teacher(parts[0], parts[1], parts[2], parts[3], 
                             parts[4], parts[5], parts[6], parts[7]);
        }
        return null;
    }
}