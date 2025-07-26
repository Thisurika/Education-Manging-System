package com.edumanage.model;

public class Admin extends Person {
    private String adminId;
    private String accessLevel;

    // Default constructor
    public Admin() {
        super();
    }

    // Parameterized constructor
    public Admin(String id, String username, String password, String name, String email, 
                String adminId, String accessLevel) {
        super(id, username, password, name, email);
        this.adminId = adminId;
        this.accessLevel = accessLevel;
    }

    // Getters
    public String getAdminId() {
        return adminId;
    }

    public String getAccessLevel() {
        return accessLevel;
    }

    // Setters
    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public void setAccessLevel(String accessLevel) {
        this.accessLevel = accessLevel;
    }

    @Override
    public String getRole() {
        return "ADMINISTRATOR";
    }

    @Override
    public String toString() {
        return super.toString() + "," + adminId + "," + accessLevel;
    }

    // Static method to create Admin from string data
    public static Admin fromString(String data) {
        String[] parts = data.split(",");
        if (parts.length >= 7) {
            return new Admin(parts[0], parts[1], parts[2], parts[3], 
                           parts[4], parts[5], parts[6]);
        }
        return null;
    }
}