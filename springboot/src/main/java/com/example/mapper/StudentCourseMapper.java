package com.example.mapper;

import com.example.entity.StudentCourse;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface StudentCourseMapper {

    @Insert("insert into student_course (name,no,student_id,course_id,teacher,teacher_id,status)values (#{name},#{no},#{studentId},#{courseId},#{teacher},#{teacherId},#{status})")
    void insert(StudentCourse studentCourse);

    @Select("select * from student_course where student_id=#{studentId} and course_id=#{courseId}" )
    StudentCourse selectByCondition(StudentCourse studentCourse);

    List<StudentCourse> selectAll(StudentCourse studentCourse);

    @Update("update student_course set status=1 where (student_id=#{studentId} and no=#{no})")
    void updateStatus(StudentCourse studentCourse);

    @Delete("delete  from student_course where id=#{id}")
    void deleteById(Integer id);
}
