/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.controllers;

import com.appfood.pojo.Cart;
import com.appfood.service.OrderService;
import com.appfood.utils.Utils;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author thien thien
 */
@RestController
public class ApiCartController {
    @Autowired
    private OrderService orderService;
    
    @PostMapping("/api/cart")
    public int addToCart(@RequestBody Cart params, HttpSession session){
        
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if(cart == null)
            cart = new HashMap<>();
        
        int productId = params.getProductId();
        if(cart.containsKey(productId) == true) 
        {
            Cart c = cart.get(productId);
            c.setQuantity(c.getQuantity()+1);
            
        }else { 
            cart.put(productId, params);
        }
        
        session.setAttribute("cart", cart);
        
         return Utils.countCart(cart);
    }
    
    
    @PutMapping("/api/cart")
    public ResponseEntity<Map<String, String>> updateCartItem(@RequestBody Cart params, HttpSession session){
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if(cart == null)
            cart = new HashMap<>();
        
        int productId = params.getProductId();
        if(cart.containsKey(productId) == true) 
        {
            Cart c = cart.get(productId);
            c.setQuantity(params.getQuantity());
            
        }
        session.setAttribute("cart", cart);
        
        return new ResponseEntity<>(Utils.cartStats(cart), HttpStatus.OK);
    }
    
    @DeleteMapping("/api/cart/{productId}")
    public ResponseEntity<Map<String, String>> deleteCartItem(@PathVariable (value = "productId") int productId,
                HttpSession session){
        Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute("cart");
        if(cart !=null && cart.containsKey(productId))
        {
            cart.remove(productId);
            session.setAttribute("cart", cart);
    
        }
        return new ResponseEntity<>(Utils.cartStats(cart), HttpStatus.OK);
    }
    
    @PostMapping("/api/pay")
    public HttpStatus pay(HttpSession session){
        if(this.orderService.addReceipt((Map<Integer, Cart>) session.getAttribute("cart")) == true)
        {  
            session.removeAttribute("cart");
            return HttpStatus.OK;
        }
        return HttpStatus.BAD_REQUEST;
    }
}
