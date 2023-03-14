package com.appfood.service;

import com.appfood.pojo.Restaurant;
import com.appfood.pojo.User;

import java.util.List;
import java.util.Map;


public interface RestaurantService {
    Restaurant getByUserId(int userId);
    boolean addOrUpdate(Restaurant restaurant);
    List<Restaurant> getRestaurant(Map<String, String> params, int page);
}

