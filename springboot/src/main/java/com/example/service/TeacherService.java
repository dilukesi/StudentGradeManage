package com.example.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.common.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Teacher;
import com.example.exception.CustomException;
import com.example.mapper.TeacherMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.hutool.core.util.ObjectUtil;

@Service
public class TeacherService {
    @Resource
    private TeacherMapper teacherMapper;
     /**登录
     *
     */
    public Account login(Account account){
        Account dbTeacher=teacherMapper.selectByUsername(account.getUsername());
        if(dbTeacher == null ){
            //没有用户
            throw new CustomException("账号或密码错误");
        }
        //比较密码
        if(!account.getPassword().equals(dbTeacher.getPassword())){
            throw new CustomException("账号或密码错误");
        }
        //登录成功
        return dbTeacher;

    }
    /**注册
     *
     */
    public void register(Account account) {
        Teacher teacher =new Teacher();
        teacher.setUsername(account.getUsername());
        teacher.setPassword(account.getPassword());
        this.add(teacher);
    }
    /**新增
     *
     */
    public void add(Teacher teacher) {
        Teacher dbTeacher =teacherMapper.selectByUsername(teacher.getUsername());
        if(dbTeacher !=null)
        {
            //已有账号 不允许注册
            throw  new CustomException("账号已存在");

        }
        if(ObjectUtil.isEmpty(teacher.getName())){
            teacher.setName(teacher.getUsername());
        }
        teacher.setRole(RoleEnum.TEACHER.name());
        teacherMapper.insert(teacher);
    }

    public void updateById(Teacher teacher) {
        teacherMapper.updateById(teacher);
    }

    public void deleteById(Integer id) {
        teacherMapper.deleteById(id);
    }

    public PageInfo<Teacher> selectPage(Integer pageNum,Integer pageSize,Teacher teacher) {
        PageHelper.startPage(pageNum,pageSize);
        List<Teacher> teachertList= teacherMapper.selectAll(teacher);
        return PageInfo.of(teachertList);
    }
}
