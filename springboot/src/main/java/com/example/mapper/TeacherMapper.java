package com.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.entity.Teacher;


public interface TeacherMapper {
    @Select("select * from teacher where username = #{username}")
    Teacher selectByUsername(String username);
    
    @Insert("insert into teacher (username,password,name,phone,email,sex,entry,role)" +
            "values (#{username},#{password},#{name},#{phone},#{email},#{sex},#{entry},#{role})")
    void insert(Teacher teachert);

    @Update("update teacher set username=#{username},password=#{password},name=#{name},phone=#{phone}" +
            ",email=#{email},sex=#{sex},entry=#{entry} where id=#{id}")
    void updateById(Teacher teacher);


    @Delete("delete from teacher where id= #{id}")
    void deleteById(Integer id);

    @Select("select * from teacher where username like concat('%',#{username},'%') and name like concat('%',#{name},'%')")
    List<Teacher> selectAll(Teacher teacher);
} 
