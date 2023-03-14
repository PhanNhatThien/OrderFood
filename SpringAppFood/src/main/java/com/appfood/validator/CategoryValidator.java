package com.appfood.validator;

import com.appfood.pojo.Category;
import com.appfood.pojo.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


@Component
public class CategoryValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return Category.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Category category = (Category) target;
        if (category.getName().isEmpty())
            errors.rejectValue("name", "", "Tên không được bỏ trống");
        if (category.getDescription().length() > 15)
            errors.rejectValue("description", "", "Mô tả không quá 15 ký tự");

    }

}