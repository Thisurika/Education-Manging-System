package com.edumanage.dao;

import com.edumanage.model.Student;
import com.edumanage.utils.FileHandler;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {
    private static final String STUDENT_FILE = "students.txt";

    public boolean addStudent(Student student) {
        String data = student.toString() + "\n";
        return FileHandler.writeToFile(STUDENT_FILE, true, data);
    }

    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        String[] lines = FileHandler.readFromFile(STUDENT_FILE);
        
        for (String line : lines) {
            if (!line.trim().isEmpty()) {
                Student student = Student.fromString(line);
                if (student != null) {
                    students.add(student);
                }
            }
        }
        return students;
    }

    public Student getStudentById(String studentId) {
        List<Student> students = getAllStudents();
        for (Student student : students) {
            if (student.getId().equals(studentId)) {
                return student;
            }
        }
        return null;
    }

    public boolean updateStudent(Student updatedStudent) {
        List<Student> students = getAllStudents();
        StringBuilder data = new StringBuilder();
        
        for (Student student : students) {
            if (student.getId().equals(updatedStudent.getId())) {
                data.append(updatedStudent.toString()).append("\n");
            } else {
                data.append(student.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(STUDENT_FILE, false, data.toString());
    }

    public boolean deleteStudent(String studentId) {
        List<Student> students = getAllStudents();
        StringBuilder data = new StringBuilder();
        
        for (Student student : students) {
            if (!student.getId().equals(studentId)) {
                data.append(student.toString()).append("\n");
            }
        }
        
        return FileHandler.writeToFile(STUDENT_FILE, false, data.toString());
    }

    public List<Student> getStudentsByGrade(String grade) {
        List<Student> allStudents = getAllStudents();
        List<Student> filteredStudents = new ArrayList<>();
        
        for (Student student : allStudents) {
            if (student.getGrade().equals(grade)) {
                filteredStudents.add(student);
            }
        }
        
        return filteredStudents;
    }

    public List<Student> getStudentsByClass(String className) {
        List<Student> allStudents = getAllStudents();
        List<Student> filteredStudents = new ArrayList<>();
        
        for (Student student : allStudents) {
            if (student.getClassName().equalsIgnoreCase(className)) {
                filteredStudents.add(student);
            }
        }
        
        return filteredStudents;
    }

    public List<Student> searchStudentsByName(String name) {
        List<Student> allStudents = getAllStudents();
        List<Student> filteredStudents = new ArrayList<>();
        
        for (Student student : allStudents) {
            if (student.getName().toLowerCase().contains(name.toLowerCase())) {
                filteredStudents.add(student);
            }
        }
        
        return filteredStudents;
    }
}