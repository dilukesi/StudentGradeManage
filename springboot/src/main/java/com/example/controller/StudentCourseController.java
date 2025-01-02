package com.example.controller;

import com.example.common.Result;
import com.example.entity.StudentCourse;
import com.example.service.StudentCourseService;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Delete;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/studentCourse")
public class StudentCourseController {

    @Resource
    StudentCourseService studentCourseService;
    /**学生选课
    *
    */
    @PostMapping("/add")
    public Result add(@RequestBody StudentCourse studentCourse){
        studentCourseService.add(studentCourse);
        return Result.success();
    }

    @PutMapping("/updateStatus")
    public Result updateStatus(@RequestBody StudentCourse studentCourse){
        studentCourseService.updateStatus(studentCourse);
        return Result.success();
    }

    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10")Integer pageSize,
                            StudentCourse studentCourse){
        PageInfo<StudentCourse> PageInfo = studentCourseService.selectPage(pageNum, pageSize,studentCourse);
        return Result.success(PageInfo);
    }
    @DeleteMapping("/delete/{id}")
    public  Result delete(@PathVariable Integer id){
        studentCourseService.deleteById(id);
        return Result.success();
    }
}
