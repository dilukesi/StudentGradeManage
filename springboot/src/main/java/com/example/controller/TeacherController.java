package com.example.controller;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.common.Result;
import com.example.entity.Teacher;
import com.example.service.TeacherService;
import com.github.pagehelper.PageInfo;

@RestController
@RequestMapping("/teacher")
public class TeacherController {
    @Resource
    TeacherService teacherService;
    /**
    * 新增
    */

    @PostMapping("/add")
    public Result add (@RequestBody Teacher teacher){
        teacherService.add(teacher);
        return Result.success();
    }

    /**
     * 删除
     */

    @DeleteMapping("/delete/{id}")
    public Result delete (@PathVariable Integer id){
        teacherService.deleteById(id);
        return Result.success();
    }
    /**
     * 更新
     */

    @PutMapping("/update")
    public  Result update (@RequestBody Teacher teacher)
    {
       teacherService.updateById(teacher);
        return Result.success();
    }
    /**
     * 列表
     */

    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10")Integer pageSize,
                             Teacher teacher){
        PageInfo<Teacher> PageInfo = teacherService.selectPage(pageNum,pageSize,teacher);
        return Result.success(PageInfo);
    }

}
