/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;

import com.appfood.pojo.Cart;
import com.appfood.service.CategoryService;
import com.appfood.service.ProductService;
import com.appfood.service.RestaurantService;
import com.appfood.service.UserService;
import com.appfood.utils.Utils;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author thien thien
 */
@Controller
@ControllerAdvice
@PropertySource("classpath:messages.properties")
public class IndexController {
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private UserService userService;
    @Autowired
    private RestaurantService restaurantService;
    
    @Autowired
    private Environment env;
    
    @ModelAttribute
    public void commonAttr(Model model, HttpSession session, Authentication authentication) {
        model.addAttribute("categories", this.categoryService.getCategories("", 0));
        model.addAttribute("cartCounter", Utils.countCart((Map<Integer, Cart>) session.getAttribute("cart")));
        if (authentication != null)
            model.addAttribute("currentUser", this.userService.getUserByUsername(authentication.getName()));
    }
    
    @RequestMapping("/")
    public String index(Model model,
            @RequestParam Map<String, String> params) {
        int page = Integer.parseInt(params.getOrDefault("page", "1"));
        model.addAttribute("products", this.productService.getProducts(params, page));
        model.addAttribute("restaurants", this.restaurantService.getRestaurant(params, page));
        model.addAttribute("users", this.userService.getUsersMultiCondition(params, page));
        model.addAttribute("productCounter", this.productService.countProduct());
        model.addAttribute("pageSize", Integer.parseInt(env.getProperty("page.size")));
        
        return "index";
    }

    @GetMapping("/products/{productId}")
    public String productDetails(Model model, @PathVariable(value = "productId") int id) {
        model.addAttribute("product", this.productService.getProductById(id));
        return "details";
    }
}