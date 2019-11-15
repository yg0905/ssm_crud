package com.yg.test;


import com.yg.bean.Department;
import com.yg.bean.Emplovee;
import com.yg.dao.DepartmentMapper;
import com.yg.dao.EmploveeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;


/*@ContextConfiguration指定spring配置文件的位置 自动创建ioc容器指定spring配置文件的位置 自动创建ioc容器*/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmploveeMapper emploveeMapper;

    @Autowired//批量注入
    SqlSession sqlSession;
    @Test
    public void test(){
           /*ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
           DepartmentMapper departmentMapper = applicationContext.getBean(DepartmentMapper.class);*/
/*      System.out.println(departmentMapper);
          1.部门插入
        departmentMapper.insertSelective(new Department(null,"技术部"));
        departmentMapper.insertSelective(new Department(null,"人事部"));*/
//        2.员工信息插入
//      emploveeMapper.insertSelective(new Emplovee(null,"Jerry","M","142144@qq.comm",1));
//        3.批量插入的sqlSeesion
        EmploveeMapper mapper=sqlSession.getMapper(EmploveeMapper.class);
        for (int i=0;i<1000;i++){
            //相当于随机数
            String uid=UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Emplovee(null,uid,"M",uid+"@qq.com",1));
        }
    }
}
