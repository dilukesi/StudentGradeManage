package com.example.controller;

import com.example.common.Result;
import com.example.entity.Course;
import com.example.entity.Student;
import com.example.service.StudentService;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Delete;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.annotation.Resource;

@RestController
@RequestMapping("/student")
public class StudentController {

    @Resource
    StudentService studentService;

/**
 * 新增
 */

    @PostMapping("/add")
    public Result add (@RequestBody Student student){
        studentService.add(student);
        return Result.success();
    }
    @PostMapping("/batchAdd")
    public Result batchAdd(@RequestBody List<Student> students) {
        studentService.batchAdd(students);
        return Result.success();
    }
    /**
     * 删除
     */

    @DeleteMapping("/delete/{id}")
    public Result delete (@PathVariable Integer id){
        studentService.deleteById(id);
        return Result.success();
    }
    /**
     * 更新
     */

    @PutMapping("/update")
    public  Result update (@RequestBody Student student)
    {
       studentService.updateById(student);
        return Result.success();
    }
    /**
     * 列表
     */

    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10")Integer pageSize,
                             Student student){
        PageInfo<Student> PageInfo = studentService.selectPage(pageNum,pageSize,student);
        return Result.success(PageInfo);
    }
}
