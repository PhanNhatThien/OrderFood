/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.formatters;

import com.appfood.pojo.User;
import java.text.ParseException;
import java.util.Locale;
import org.springframework.format.Formatter;

/**
 *
 * @author thien thien
 */
public class UserFormatter implements Formatter<User> {

    @Override
    public String print(User user, Locale locale) {

        return String.valueOf(user.getId());
    }

    @Override
    public User parse(String s, Locale locale) throws ParseException {
        User user = new User();
        user.setId(Integer.parseInt(s));
        return user;
    }

}