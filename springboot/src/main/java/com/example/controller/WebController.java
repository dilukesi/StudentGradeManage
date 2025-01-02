package com.example.controller;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.Result;
import com.example.common.RoleEnum;
import com.example.entity.Account;
import com.example.service.AdminService;
import com.example.service.StudentService;
import com.example.service.TeacherService;

import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
public class WebController {
@Resource
private AdminService adminService;
@Resource
private StudentService studentService;
@Resource
private TeacherService teacherService;
    /**
     * 默认请求接口
     */
    @GetMapping("/")
    public Result hello() {
        return Result.success();
    }

    /**
     * 登录接口
     */
    @PostMapping("/login")
    public Result login(@RequestBody Account account){
        Account dbAccount;
        if(RoleEnum.ADMIN.name().equals(account.getRole()))
        {
            dbAccount = adminService.login(account); //管理员登录
        } 
        else if(RoleEnum.STUDENT.name().equals(account.getRole()))
        {
            dbAccount = studentService.login(account); //学生登录
        }
        else if(RoleEnum.TEACHER.name().equals(account.getRole()))
        {
            dbAccount = teacherService.login(account);
        }
        else{
            return  Result.error("角色错误");
        }
        return Result.success(dbAccount);
    }
    /**
     * 注册接口
     */
    @PostMapping("/register")
    public Result register(@RequestBody Account account){
        if(ObjectUtil.isEmpty(account.getUsername())||ObjectUtil.isEmpty(account.getPassword()))
        {
            return Result.error("账号或密码必填");
        }
        studentService.register(account);
        return Result.success();
    }
}

