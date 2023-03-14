package com.appfood.repository;

import java.util.List;

public interface StatsRepository {

    List<Object[]> userRoleStats();

    List<Object[]> productStats();
//
//    List<Object[]> jobPostStatsByJobType();

}

