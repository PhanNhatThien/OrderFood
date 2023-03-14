/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.appfood.repository;

import com.appfood.pojo.Cart;
import com.appfood.pojo.Product;
import com.appfood.pojo.SaleOrder;

import java.util.List;
import java.util.Map;

/**
 *
 * @author thien thien
 */
public interface OrderRepository {
    boolean addReceipt(Map<Integer, Cart> cart);
    List<SaleOrder> getByActive(int active);
    SaleOrder getOrderById(int orderId);
    List<SaleOrder> getOrders(Map<String, String> params, int page);
    boolean delete(SaleOrder order);
}
