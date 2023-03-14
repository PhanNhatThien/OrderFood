package com.appfood.validator;

import com.appfood.pojo.Category;
import com.appfood.pojo.User;
import com.appfood.utils.Utils;
import com.appfood.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


@Component
public class UserValidator implements Validator {

    @Autowired
    private UserService userService;


    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;


        if (user.getUsername().isEmpty())
            errors.rejectValue("username", "", "Tên đăng nhập không được bỏ trống");


        if (user.getFirstName().isEmpty())
            errors.rejectValue("firstName", "", "Tên không được bỏ trống");

        if (user.getPassword().isEmpty())
            errors.rejectValue("password", "", "Mật khẩu không được bỏ trống");


        if (user.getPassword().contains(" "))
            errors.rejectValue("password", "", "Mật khẩu không chứa khoảng trắng");


    }
}