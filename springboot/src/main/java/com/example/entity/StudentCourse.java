package com.example.entity;

public class StudentCourse {
    private Integer id;
    private String name;
    private String no;
    private Integer StudentId;
    private  Integer courseId;
    private String teacher;
    private String studentName;
    private Integer TeacherId;
    private Integer status;
    public Integer getCourseId() {
        return courseId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public Integer getStudentId() {
        return StudentId;
    }

    public void setStudentId(Integer studentId) {
        StudentId = studentId;
    }

    public String getTeacher() {
        return teacher;
    }

    public void setTeacher(String teacher) {

        this.teacher = teacher;
    }

    public Integer getTeacherId() {
        return TeacherId;
    }

    public void setTeacherId(Integer teacherId) {
        TeacherId = teacherId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}
