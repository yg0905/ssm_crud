package com.yg.bean;

import jdk.nashorn.internal.objects.annotations.Property;
import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.Pattern;

public class Emplovee {
    private Integer empId;
    @Pattern(regexp ="(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5})"
            ,message="用户名必须为2-5位中文或者6-16位英文")
    private String empName;

    private String gender;
//    校验Email 的标准格式
    @Email
    private String email;

    public Emplovee(Integer empId, String empName, String gender, String email, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.dId = dId;
    }
public Emplovee(){}
    private Integer dId;
//    用于封装员工对应的部门
    private Department department;

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}