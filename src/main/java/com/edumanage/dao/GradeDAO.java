package com.edumanage.dao;

import com.edumanage.model.Grade;
import com.edumanage.utils.FileHandler;
import java.util.ArrayList;
import java.util.List;

public class GradeDAO {
    private static final String GRADE_FILE = "grades.txt";

    public boolean addGrade(Grade grade) {
        String data = grade.toString() + "\n";
        return FileHandler.writeToFile(GRADE_FILE, true, data);
    }

    public List<Grade> getAllGrades() {
        List<Grade> grades = new ArrayList<>();
        String[] lines = FileHandler.readFromFile(GRADE_FILE);
        
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Grade grade = Grade.fromString(line);
                if (grade != null) {
                    grades.add(grade);
                }
            }
        }
        return grades;
    }

    public List<Grade> getGradesByStudentId(String studentId) {
        List<Grade> allGrades = getAllGrades();
        List<Grade> studentGrades = new ArrayList<>();
        
        for (Grade grade : allGrades) {
            if (grade.getStudentId().equals(studentId)) {
                studentGrades.add(grade);
            }
        }
        
        return studentGrades;
    }

    public List<Grade> getGradesBySubject(String subject) {
        List<Grade> allGrades = getAllGrades();
        List<Grade> subjectGrades = new ArrayList<>();
        
        for (Grade grade : allGrades) {
            if (grade.getSubject().equalsIgnoreCase(subject)) {
                subjectGrades.add(grade);
            }
        }
        
        return subjectGrades;
    }

    public boolean updateGrade(Grade updatedGrade) {
        List<Grade> grades = getAllGrades();
        StringBuilder data = new StringBuilder();
        
        for (Grade grade : grades) {
            if (grade.getId().equals(updatedGrade.getId())) {
                data.append(updatedGrade.toString()).append("\n");
            } else {
                data.append(grade.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(GRADE_FILE, false, data.toString());
    }

    public boolean deleteGrade(String gradeId) {
        List<Grade> grades = getAllGrades();
        StringBuilder data = new StringBuilder();
        
        for (Grade grade : grades) {
            if (!grade.getId().equals(gradeId)) {
                data.append(grade.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(GRADE_FILE, false, data.toString());
    }
}