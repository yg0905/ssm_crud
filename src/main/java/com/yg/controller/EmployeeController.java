package com.yg.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yg.bean.Emplovee;
import com.yg.bean.Msg;
import com.yg.service.EmployeeService;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.Mergeable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.net.BindException;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping(value = "/emps")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //查询数据并分页 返回转化成JSON RequestParam设置默认值
    @RequestMapping(value = "/emp")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        PageHelper.startPage(pn, 5);
        List<Emplovee> li = employeeService.getAll();
        // 使用pageinfo 包装查询结果 封装了详细信息还有查询出来的数据 5为连续显示的页数
        PageInfo page = new PageInfo(li, 5);
        return Msg.success().add("pageinfo", page);
    }

    /**
     * 查询员工数据
     *
     * @return
     */
    //@RequestMapping(value = "/emp")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 引入PageHelper分页插件
        // 调用分页的方法(传入页码 以及每页大小) 后面跟的就是一个分页查询
        PageHelper.startPage(pn, 5);
        List<Emplovee> li = employeeService.getAll();
        // 使用pageinfo 包装查询结果 封装了详细信息还有查询出来的数据 5为连续显示的页数
        PageInfo page = new PageInfo(li, 5);
        model.addAttribute("pageinfo", page);
        return "list";
    }

    /**
     * 新增员工     @Valid 校验employee对象里面的字段  BindingResult用来保存校验结果
     *
     * @return
     */
    @RequestMapping(value = "/empadd", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emplovee emplovee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败 返回失败 然后在模态框中显示错误信息
            //错误的校验信息   map用于错误的消息封装
            Map<String, Object> map = new HashMap<>();
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError : list) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(emplovee);
            return Msg.success();
        }

    }

    //    验证empName是否存在
    @ResponseBody
    @RequestMapping(value = "/checkUser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
//        matches() 方法用于检测字符串是否匹配给定的正则表达式。
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名必须是3到16位");
        }
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    //    查询选定的员工信息
    @RequestMapping(value = "/getEmp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Emplovee emplovee = employeeService.getEmp(id);
        return Msg.success().add("getEmp", emplovee);
    }

    /**
     * 解决put请求数据为空情况
     * 如果直接发送ajax=put请求  会获取不到数据
     * 原因：tomcat :将请求参数，封装一个map
     * 2.request.getparameter 会从map中去值
     * 3.Spring mvc 封装pojo对象的时候  会把pojo中每个属性的值拿到
     * ajax 发送put请求引发的 tomcat 不会封装put中数据的请求  只有post 可以
     * HttpPutFormContentFilter 将请求体中的数据解析包装成一个map
     *
     * @param emplovee
     * @return
     */
//    修改员工信息  这种对象的方法的empId必须与实体类一样
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Emplovee emplovee) {
        ;
        employeeService.updateEmp(emplovee);
        return Msg.success();
    }

    /**
     * 安主键删除   单个和批量在一个方法
     *
     * @param Ids
     * @return
     */
    @RequestMapping(value = "/emp/{Ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delectEmp(@PathVariable("Ids") String Ids) {
        List<Integer> id_list = new ArrayList<>();
        if (Ids.contains("-")) {
//           根据"-"，分割字符串
            String[] str_ids = Ids.split("-");
            for (String s : str_ids) {
                id_list.add(Integer.parseInt(s));
            }
            employeeService.deleteBch(id_list);
        } else {
            Integer id = Integer.parseInt(Ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}
