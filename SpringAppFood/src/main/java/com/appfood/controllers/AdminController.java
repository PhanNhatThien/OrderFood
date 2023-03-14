/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;


import com.appfood.pojo.Product;
import com.appfood.service.ProductService;
import javax.validation.Valid;

import com.appfood.service.StatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author thien thien
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private ProductService productService;
    @Autowired
    private StatsService statsService;
    
    @GetMapping("/products")
    public String list(Model model) {
        model.addAttribute("product", new Product());
        return "products";
    }
    
    @PostMapping("/products")
    public String add(@ModelAttribute(value = "product") @Valid Product p,
            BindingResult rs) {
        if (rs.hasErrors())
            return "products";
        
        if (this.productService.addProduct(p) == true)
            return "redirect:/admin/products";

         return "products";
    }
    @GetMapping("/userStats")
    public String userstats(Model model){
        model.addAttribute("usersStats", this.productService.countProdsByUser());
        return "userStats";
    }

    @RequestMapping("/UserRoleStats")
    public String userRoleStats(Model model){
        model.addAttribute("userRoleStats", this.statsService.userRoleStats());
        return "stats-userRole";
    }

    @RequestMapping("/ProductStats")
    public String productStats(Model model){
        model.addAttribute("productStats", this.statsService.productStats());
        return "stats-product";
    }

}
