package com.appfood.service.impl;

import com.appfood.repository.StatsRepository;
import com.appfood.service.StatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StatsServiceImpl implements StatsService {

    @Autowired
    private StatsRepository statsRepository;

    @Override
    public List<Object[]> userRoleStats() {
        return this.statsRepository.userRoleStats();
    }

    @Override
    public List<Object[]> productStats() {
        return this.statsRepository.productStats();
    }


}