/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.service.impl;

import com.appfood.pojo.Comment;
import com.appfood.pojo.Product;
import com.appfood.pojo.SaleOrder;
import com.appfood.repository.ProductRepository;
import com.appfood.repository.UserRepository;
import com.appfood.service.ProductService;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

/**
 *
 * @author thien thien
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private Cloudinary cloudinary;
    
    @Override
    public List<Product> getProducts(Map<String, String> params, int page) {
        return this.productRepository.getProducts(params, page);
    }

    @Override
    public int countProduct() {
        return this.productRepository.countProduct();
    }

    @Override
    public boolean deleteProduct(int id) {
        return this.productRepository.deleteProduct(id);
    }

    @Override
    public boolean addProduct(Product p) {
//        p.setImage("https://res.cloudinary.com/dtswvj7fd/image/upload/v1660674849/cld-sample-4.jpg");
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        p.setPostedByUser(this.userRepository.getUserByUsername(authentication.getName()));
        p.setCreatedDate(new Date());
        return this.productRepository.addProduct(p);
    }

    @Override
    public List<Object[]> countProdsByCate() {
        return this.productRepository.countProdsByCate();
    }
    
    @Override
    public List<Object[]> countProdsByUser() {
        return this.productRepository.countProdsByUser();
    }
    
    @Override
    public List<Object[]> frequencyStats() {
        return this.productRepository.frequencyStats();
    }

    @Override
    public List<Object[]> revenueStats(int quarter, int year) {
        return this.productRepository.revenueStats(quarter, year);
    }


     @Override
    public List<Comment> getComments(int productId) {
        return this.productRepository.getComments(productId);
    }

    @Override
    public Product getProductById(int productId) {
        return this.productRepository.getProductById(productId);
    }

    @Override
    public Comment addComment(String content, int productId) {
        return this.productRepository.addComment(content, productId);
    }
    @Override
    public int getMaxItemsInPage() {
        return this.productRepository.getMaxItemsInPage();
    }

    @Override
    public boolean delete(Product product) {
        return this.productRepository.delete(product);
    }
    @Override
    public Boolean addOrUpdate(Product product) {

        String image = product.getImage();

        if (!product.getFile().isEmpty()) {
            Map r = null;
            try {
                r = this.cloudinary.uploader().upload(product.getFile().getBytes(),
                        ObjectUtils.asMap("resource_type", "auto"));
            } catch (IOException e) {
                e.printStackTrace();
            }

            if (r != null)
                product.setImage((String) r.get("secure_url"));
            else
                product.setImage(image);
        }

        return this.productRepository.addOrUpdate(product);
    }
    @Override
    public List<Product> getByActive(int active) {
        return this.productRepository.getByActive(active);
    }
}
