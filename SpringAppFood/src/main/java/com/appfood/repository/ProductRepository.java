/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.appfood.repository;

import com.appfood.pojo.Comment;
import com.appfood.pojo.Product;
import com.appfood.pojo.SaleOrder;

import java.util.List;
import java.util.Map;

/**
 *
 * @author thien thien
 */
public interface ProductRepository {
    List<Product> getProducts(Map<String, String> params, int page);
    int countProduct();
    boolean deleteProduct(int id);
    boolean addProduct(Product p);
    List<Object[]> countProdsByCate();
    List<Object[]> countProdsByUser();
    List<Object[]> revenueStats(int quarter, int year);
    List<Object[]> frequencyStats();
    List<Comment> getComments(int productId);
    Product getProductById(int productId);
    Comment addComment(String content, int productId);
    int getMaxItemsInPage();
    boolean delete(Product product);
    Boolean addOrUpdate(Product product);
    List<Product> getByActive(int active);

}
