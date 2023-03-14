package com.appfood.repository.impl;


import com.appfood.pojo.Restaurant;
import com.appfood.repository.RestaurantRepository;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
@Transactional
public class RestaurantRepositoryImpl implements RestaurantRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;
    private final int maxItemsInPage = 5;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public Restaurant getByUserId(int userId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Restaurant> query = builder.createQuery(Restaurant.class);
        Root root = query.from(Restaurant.class);
        query = query.select(root);

        query = query.where(builder.equal(root.join("user").get("id").as(Integer.class), userId));

        org.hibernate.query.Query q = session.createQuery(query);
        return (Restaurant) q.getSingleResult();
    }
    @Override
    public boolean addOrUpdate(Restaurant restaurant) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (restaurant.getId() > 0)
                session.update(restaurant);
            else
                session.save(restaurant);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }
    @Override
    public List<Restaurant> getRestaurant(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Restaurant> q = builder.createQuery(Restaurant.class);
        Root root = q.from(Restaurant.class);
        q.select(root);
        q = q.orderBy(builder.asc(root.get("id")));

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            if (params.containsKey("name")) {
                Predicate p1 = builder.like(root.get("name").as(String.class),
                        String.format("%%%s%%", params.get("name")));
                predicates.add(p1);
            }
            if (params.containsKey("description")) {
                Predicate p2 = builder.like(root.get("description").as(String.class),
                        String.format("%%%s%%", params.get("description")));
                predicates.add(p2);
            }

            if (params.containsKey("location")) {
                Predicate p3 = builder.like(root.get("location").as(String.class),
                        String.format("%%%s%%", params.get("location")));
                predicates.add(p3);
            }

            if (params.containsKey("contact")) {
                Predicate p4 = builder.like(root.get("contact").as(String.class),
                        String.format("%%%s%%", params.get("contact")));
                predicates.add(p4);
            }

            q = q.where(predicates.toArray(new Predicate[]{}));
        }

        Query query = session.createQuery(q);

        if (page != 0) {
            int max = maxItemsInPage;
            query.setMaxResults(max);
            query.setFirstResult((page - 1) * max);
        }

        return query.getResultList();
    }
}