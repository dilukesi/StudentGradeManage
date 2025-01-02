package com.example.mapper;

import com.example.entity.Course;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface CourseMapper {
    @Select("select * from course where name like concat('%' , #{name} , '%') and no like concat('%' , #{no} , '%') " +
            "and teacher like concat('%' , #{teacher} , '%') order by id desc")
    List<Course> selectAll(Course course);
    //新增课程插入数据库
    @Insert("insert into course (name,no,descr,times,teacher) values(#{name},#{no},#{descr},#{times},#{teacher})")
    void insert(Course course);
    //更新课程数据库

    @Update("update course set name = #{name},no=#{no},descr = #{descr}, times=#{times}, teacher = #{teacher} where id= #{id}")
    void updateById(Course course);

    //删除课程
    @Delete("delete from course where id= #{id}")
    void deleteById(Integer id);
}
