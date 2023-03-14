/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.repository;

import com.appfood.pojo.Category;
import java.util.List;

/**
 *
 * @author thien thien
 */
public interface CategoryRepository {
    List<Category> getCategories(String name, int page);
    Category getById(int id);
    long count();
    int getMaxItemsInPage();
    boolean addOrUpdate(Category category);
    boolean delete(Category category);

    interface StatsRepository {
    }
}
