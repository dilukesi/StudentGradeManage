package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.common.RoleEnum;
import com.example.entity.Account;
import com.example.entity.Student;
import com.example.exception.CustomException;
import com.example.mapper.StudentMapper;
import com.github.javafaker.Faker;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.x.protobuf.MysqlxExpr;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Locale;

@Service
public class StudentService {

    @Resource
    private StudentMapper studentMapper;
    
    public Faker faker =new Faker(new Locale("zh", "CN"));
    /**登录
     *
     */
    public Account login(Account account){
        Account dbStudent =studentMapper.selectByUsername(account.getUsername());
        if(dbStudent == null ){
            //没有用户
            throw new CustomException("账号或密码错误");
        }
        //比较密码
        if(!account.getPassword().equals(dbStudent.getPassword())){
            throw new CustomException("账号或密码错误");
        }
        //登录成功
        return dbStudent;

    }
    /**注册
     *
     */
    public void register(Account account) {
        Student student =new Student();
        student.setUsername(account.getUsername());
        student.setPassword(account.getPassword());
        this.add(student);
    }
    /**新增
     *
     */
    public void add(Student student) {
        Student dbStudent =studentMapper.selectByUsername(student.getUsername());
        if(dbStudent !=null)
        {
            //已有账号 不允许注册
            throw  new CustomException("账号已存在");

        }
        if(ObjectUtil.isEmpty(student.getName())){
            String name =faker.name().fullName();
            student.setName(name);
        }
        student.setRole(RoleEnum.STUDENT.name());
        studentMapper.insert(student);
    }

    public void batchAdd(List<Student> students) {
        for (Student student : students) {
            try {
                // 检查学生账号是否已存在
                Student dbStudent = studentMapper.selectByUsername(student.getUsername());
                if (dbStudent != null) {
                    throw new CustomException("账号已存在");
                }
                
                // 如果学生姓名为空，则使用账号作为姓名
                if (ObjectUtil.isEmpty(student.getName())) {
                    String name =faker.name().fullName();
                    student.setName(name);
                }

                // 设置学生角色
                student.setRole(RoleEnum.STUDENT.name());

                // 插入学生记录
                studentMapper.insert(student);
            } catch (CustomException e) {
                // 处理自定义异常，例如记录日志或通知用户
                System.err.println(e.getMessage());
            } catch (Exception e) {
                // 处理其他异常，例如数据库异常
                System.err.println(e.getMessage());
            }
        }
    }

    public void updateById(Student student) {
        studentMapper.updateById(student);
    }

    public void deleteById(Integer id) {
        studentMapper.deleteById(id);
    }

    public PageInfo<Student> selectPage(Integer pageNum,Integer pageSize,Student student) {
        PageHelper.startPage(pageNum,pageSize);
        List<Student> studentList= studentMapper.selectAll(student);
        return PageInfo.of(studentList);
    }
}
