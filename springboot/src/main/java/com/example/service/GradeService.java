package com.example.service;

import com.example.entity.Grade;
import com.example.exception.CustomException;
import com.example.mapper.GradeMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class GradeService {
    @Resource
    private GradeMapper gradeMapper;
    public  void add(Grade grade)
    {
        Grade dbgrade = gradeMapper.selectByCondition(grade);
        if(dbgrade!=null){
            throw new CustomException("您已经打过分了");
        }
        gradeMapper.insert(grade);
    }


    public PageInfo<Grade> selectPage(Integer pageNum, Integer pageSize, Grade grade) {
        PageHelper.startPage(pageNum,pageSize);
            List<Grade> list =gradeMapper.selectAll(grade);
            return PageInfo.of(list);
    }

    public void update(Grade grade) {
        gradeMapper.update(grade);
    }

    public void deleteById(Integer id) {
        gradeMapper.deleteById(id);
    }
}
