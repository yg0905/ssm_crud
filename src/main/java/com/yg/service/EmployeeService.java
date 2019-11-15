package com.yg.service;

import com.yg.bean.Emplovee;
import com.yg.bean.EmploveeExample;
import com.yg.dao.EmploveeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@Transactional
public class EmployeeService {
    @Autowired
    private EmploveeMapper emploveeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Emplovee> getAll() {
        return emploveeMapper.selectByExampleWithDept(null);
    }

    /**
     * 新增
     */
    public void saveEmp(Emplovee emplovee){
        emploveeMapper.insertSelective(emplovee);
    }

    /**
     * 检验empName是否存在
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmploveeExample emploveeExample=new EmploveeExample();
        EmploveeExample.Criteria criteria = emploveeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count= emploveeMapper.countByExample(emploveeExample);
        return  count==0;
    }

    /**
     * 按主键查询
     * @param id
     * @return
     */
    public Emplovee getEmp(Integer id) {
        Emplovee emplovee= emploveeMapper.selectByPrimaryKey(id);
        return emplovee;
    }

    /**
     * 修改
     * @param emplovee
     */
    public void updateEmp(Emplovee emplovee) {
        emploveeMapper.updateByPrimaryKeySelective(emplovee);
    }

    /**
     * 单个删除
     * @param empId
     */
    public void deleteEmp(Integer empId) {
        emploveeMapper.deleteByPrimaryKey(empId);
    }

    /**
     * 批量删除
     * @param ids
     */
    public void deleteBch(List<Integer> ids) {
        EmploveeExample example=new EmploveeExample();
        EmploveeExample.Criteria criteria= example.createCriteria();
        criteria.andEmpIdIn(ids);
        emploveeMapper.deleteByExample(example);

    }
}
