package com.edumanage.utils;

import com.edumanage.model.Student;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

public class BinarySearch {
    
    public static List<Student> searchStudentsByGrade(List<Student> students, String targetGrade) {
        // First filter students by grade
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getGrade().equals(targetGrade)) {
                filteredStudents.add(student);
            }
        }
        
        // Sort by student ID for binary search
        Collections.sort(filteredStudents, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                return s1.getStudentId().compareTo(s2.getStudentId());
            }
        });
        
        return filteredStudents;
    }
    
    public static List<Student> searchStudentsByClass(List<Student> students, String targetClass) {
        // First filter students by class
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getClassName().equalsIgnoreCase(targetClass)) {
                filteredStudents.add(student);
            }
        }
        
        // Sort by name for binary search
        Collections.sort(filteredStudents, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                return s1.getName().compareToIgnoreCase(s2.getName());
            }
        });
        
        return filteredStudents;
    }
    
    public static List<Student> searchStudentsByName(List<Student> students, String targetName) {
        // Filter students by name (partial match)
        List<Student> filteredStudents = new ArrayList<>();
        for (Student student : students) {
            if (student.getName().toLowerCase().contains(targetName.toLowerCase())) {
                filteredStudents.add(student);
            }
        }
        
        // Sort by name
        Collections.sort(filteredStudents, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                return s1.getName().compareToIgnoreCase(s2.getName());
            }
        });
        
        return filteredStudents;
    }
    
    // Binary search implementation for finding a specific student by ID
    public static Student binarySearchById(List<Student> sortedStudents, String targetId) {
        int left = 0;
        int right = sortedStudents.size() - 1;
        
        while (left <= right) {
            int mid = left + (right - left) / 2;
            Student midStudent = sortedStudents.get(mid);
            
            int comparison = midStudent.getStudentId().compareTo(targetId);
            
            if (comparison == 0) {
                return midStudent; // Found the student
            } else if (comparison < 0) {
                left = mid + 1; // Search right half
            } else {
                right = mid - 1; // Search left half
            }
        }
        
        return null; // Student not found
    }
}