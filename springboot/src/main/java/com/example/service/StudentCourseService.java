package com.example.service;

import com.example.entity.StudentCourse;
import com.example.exception.CustomException;
import com.example.mapper.StudentCourseMapper;
import com.example.mapper.StudentMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class StudentCourseService {

    @Resource
    private StudentCourseMapper studentCourseMapper;

    public  PageInfo<StudentCourse> selectPage(Integer pageNum, Integer pageSize, StudentCourse studentCourse) {
        PageHelper.startPage(pageNum,pageSize);
        List<StudentCourse> list =studentCourseMapper.selectAll(studentCourse);
        return PageInfo.of(list);
    }

    public void add(StudentCourse studentCourse){
        StudentCourse course = studentCourseMapper.selectByCondition(studentCourse);//通过学生ID和课程ID进行查询的筛选，看学生是否选过该科
        if(course !=null){
            throw new CustomException("您已选过这个课程");

        }
        studentCourseMapper.insert(studentCourse);
    }

    public void deleteById(Integer id) {
        studentCourseMapper.deleteById(id);
    }

    public void updateStatus(StudentCourse studentCourse) {
        StudentCourse course = studentCourseMapper.selectByCondition(studentCourse);//通过学生ID和课程ID进行查询的筛选，看学生是否选过该科
        if(course !=null){
            throw new CustomException("允许更改");

        }
        studentCourseMapper.updateStatus(studentCourse);
    }
}
