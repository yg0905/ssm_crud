package com.yg.test;
import com.github.pagehelper.PageInfo;
import com.yg.bean.Emplovee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:SpringMVC.xml"})
@WebAppConfiguration
public class MvcTest {
    /**
     * 测试mvc分页数据
     */
    @Autowired
    WebApplicationContext context;


    MockMvc mockMvc;
    @Before
    public void Test() {
        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void mvcTest() throws Exception {
//        模拟请求拿到返回值
       MvcResult re= mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","1")).andReturn();
       //请求成功后，请求域会有pageinfo 取出来验证
       MockHttpServletRequest request= re.getRequest();
       PageInfo pag= (PageInfo)request.getAttribute("pageinfo");
       System.out.println("当前页码"+pag.getPageNum());
       System.out.println("总页码"+pag.getPages());
        System.out.println("连续显示的页码");
        int[] nums=pag.getNavigatepageNums();
        List<Emplovee> list=pag.getList();
        for (int i: nums) {
            System.out.println(" "+i);
        }
        //获取员工数据
        List<Emplovee> li=pag.getList();
        for (Emplovee e:li) {
            System.out.println("id:"+e.getEmpId()+"name:"+e.getEmpName());
        }
    }
}
