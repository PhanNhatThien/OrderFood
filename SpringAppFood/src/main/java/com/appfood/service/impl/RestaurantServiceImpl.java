package com.appfood.service.impl;


import com.appfood.repository.RestaurantRepository;
import com.appfood.service.RestaurantService;
import org.springframework.stereotype.Service;
import com.appfood.pojo.Restaurant;
import com.appfood.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


@Service
public class RestaurantServiceImpl implements RestaurantService {

    @Autowired
    RestaurantRepository restaurantRepository;

    @Override
    public Restaurant getByUserId(int userId) {
        return this.restaurantRepository.getByUserId(userId);
    }
    @Override
    public boolean addOrUpdate(Restaurant restaurant) {
        return this.restaurantRepository.addOrUpdate(restaurant);
    }
    @Override
    public List<Restaurant> getRestaurant(Map<String, String> params, int page) {
        return this.restaurantRepository.getRestaurant(params, page);
    }

}
