/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.repository;

import com.appfood.pojo.User;
import java.util.List;
import java.util.Map;

/**
 *
 * @author thien thien
 */
public interface UserRepository {
    boolean addUser(User user);
    boolean addOrUpdate(User user);
    User getUserById(int userId);
    User getUserByUsername(String username);
    List<User> getByRole(String role,int page, int active);
    int getMaxItemsInPage();
    long count();
    List<User> getUsersMultiCondition(Map<String, String> params, int page);
    boolean delete(User user);


}
