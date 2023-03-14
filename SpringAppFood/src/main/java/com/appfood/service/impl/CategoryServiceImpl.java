/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.service.impl;

import com.appfood.pojo.Category;
import com.appfood.repository.CategoryRepository;
import com.appfood.service.CategoryService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author thien thien
 */
@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> getCategories(String name, int page) {

        return this.categoryRepository.getCategories(name, page);
    }

    @Override
    public Category getById(int id) {
        return this.categoryRepository.getById(id);
    }

    @Override
    public long count() {
        return this.categoryRepository.count();
    }
    @Override
    public int getMaxItemsInPage() {
        return this.categoryRepository.getMaxItemsInPage();
    }
    @Override
    public boolean addOrUpdate(Category category) {
        return this.categoryRepository.addOrUpdate(category);
    }
    @Override
    public boolean delete(Category category) {
        return this.categoryRepository.delete(category);
    }
}
