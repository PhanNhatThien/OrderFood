/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.service;

import com.appfood.pojo.User;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.userdetails.UserDetailsService;

/**
 *
 * @author thien thien
 */
public interface UserService extends UserDetailsService{
    boolean addUser(User user);
    boolean addOrUpdate(User user);
    User getUserByUsername(String username);
    User getUserById(int userId);
    List<User> getByRole(String role,int page, int active);
    int getMaxItemsInPage();
    long count();
    List<User> getUsersMultiCondition(Map<String, String> params, int page);
    boolean delete(User user);
}
