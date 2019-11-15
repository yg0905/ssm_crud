package com.yg.service;

import com.yg.bean.Department;
import com.yg.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        List<Department> list=null;
        return list=departmentMapper.selectByExample(null);
    }
}
