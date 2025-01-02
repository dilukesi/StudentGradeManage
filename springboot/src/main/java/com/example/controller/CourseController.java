package com.example.controller;

import com.example.common.Result;
import com.example.entity.Course;
import com.example.service.CourseService;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Delete;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/course")
public class CourseController {
    @Resource
    CourseService courseService;
    /**
     * 分页条件查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10")Integer pageSize,
                           Course course){
        PageInfo<Course> PageInfo = courseService.selectPage(pageNum, pageSize,course);
        return Result.success(PageInfo);
    }
    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Course course)
    {
        courseService.add(course);
        return Result.success();
    }
    /**
     * 更新
     */
    @PutMapping("/update")
    public  Result update (@RequestBody Course course)
    {
        courseService.updateById(course);
        return Result.success();
    }
    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public  Result delete(@PathVariable Integer id)
    {
        courseService.deleteById(id);
        return Result.success();
    }

}
