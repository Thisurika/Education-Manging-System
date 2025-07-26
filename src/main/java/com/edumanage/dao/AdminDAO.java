package com.edumanage.dao;

import com.edumanage.model.Admin;
import com.edumanage.utils.FileHandler;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    private static final String ADMIN_FILE = "admins.txt";

    public boolean addAdmin(Admin admin) {
        String data = admin.toString() + "\n";
        return FileHandler.writeToFile(ADMIN_FILE, true, data);
    }

    public Admin getAdminByUsername(String username) {
        String[] lines = FileHandler.readFromFile(ADMIN_FILE);
        
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Admin admin = Admin.fromString(line);
                if (admin != null && admin.getUsername().equals(username)) {
                    return admin;
                }
            }
        }
        return null;
    }

    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String[] lines = FileHandler.readFromFile(ADMIN_FILE);
        
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Admin admin = Admin.fromString(line);
                if (admin != null) {
                    admins.add(admin);
                }
            }
        }
        return admins;
    }

    // Initialize default admin if file doesn't exist
    public void initializeDefaultAdmin() {
        if (!FileHandler.isFileExist(ADMIN_FILE)) {
            Admin defaultAdmin = new Admin("1", "admin", "admin123", "System Administrator", 
                                          "admin@edumanage.com", "ADM001", "FULL");
            addAdmin(defaultAdmin);
        }
    }
}