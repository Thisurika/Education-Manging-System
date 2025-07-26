package com.edumanage.dao;

import com.edumanage.model.Teacher;
import com.edumanage.utils.FileHandler;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {
    private static final String TEACHER_FILE = "teachers.txt";

    public boolean addTeacher(Teacher teacher) {
        String data = teacher.toString() + "\n";
        return FileHandler.writeToFile(TEACHER_FILE, true, data);
    }

    public List<Teacher> getAllTeachers() {
        List<Teacher> teachers = new ArrayList<>();
        String[] lines = FileHandler.readFromFile(TEACHER_FILE);
        
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Teacher teacher = Teacher.fromString(line);
                if (teacher != null) {
                    teachers.add(teacher);
                }
            }
        }
        return teachers;
    }

    public Teacher getTeacherByUsername(String username) {
        List<Teacher> teachers = getAllTeachers();
        for (Teacher teacher : teachers) {
            if (teacher.getUsername().equals(username)) {
                return teacher;
            }
        }
        return null;
    }

    public boolean updateTeacher(Teacher updatedTeacher) {
        List<Teacher> teachers = getAllTeachers();
        StringBuilder data = new StringBuilder();
        
        for (Teacher teacher : teachers) {
            if (teacher.getId().equals(updatedTeacher.getId())) {
                data.append(updatedTeacher.toString()).append("\n");
            } else {
                data.append(teacher.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(TEACHER_FILE, false, data.toString());
    }

    public boolean deleteTeacher(String teacherId) {
        List<Teacher> teachers = getAllTeachers();
        StringBuilder data = new StringBuilder();
        
        for (Teacher teacher : teachers) {
            if (!teacher.getId().equals(teacherId)) {
                data.append(teacher.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(TEACHER_FILE, false, data.toString());
    }
}