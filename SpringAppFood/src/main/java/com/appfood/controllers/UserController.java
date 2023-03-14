/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;

import com.appfood.pojo.User;
import com.appfood.service.UserService;
import com.appfood.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

/**
 *
 * @author thien thien
 */
@Controller
public class UserController {
    @Autowired
    private UserService userDetailsService;
    @Autowired
    private UserValidator userValidator;

    @InitBinder
    public void initBinder(WebDataBinder binder){
        binder.setValidator(userValidator);
    }

    @GetMapping("/login")
    public String login(){
        return "login";
    }
    
    @GetMapping("/register")
    public String registerView(Model model){
        model.addAttribute("user",new User());
        return "register";
    }
    
    @PostMapping("/register")
    public String register(Model model, @ModelAttribute(value = "user") User user, BindingResult result){
        String errMsg = null;
        String sucMsg = null;

        userValidator.validate(user, result);
        if (result.hasErrors())
            return "register";


        if(user.getPassword().equals(user.getConfirmPassword())){
            if(this.userDetailsService.addUser(user)==true)
                return "redirect:/login";
            else
                errMsg = "Đã có lỗi xảy ra";
        }else
            errMsg = "Mật khẩu không khớp";
        
        model.addAttribute("errMsg", errMsg);
        
        return "register";
    }
}
