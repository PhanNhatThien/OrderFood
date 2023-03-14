/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.repository.impl;

import com.appfood.pojo.*;
import com.appfood.repository.OrderRepository;
import com.appfood.repository.ProductRepository;
import com.appfood.repository.UserRepository;
import com.appfood.utils.Utils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author thien thien
 */
@Repository
@Transactional
public class OrderRepositoryImpl implements OrderRepository {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private LocalSessionFactoryBean sessionFactory;
    @Autowired
    private Environment env;

    
    @Override
    @Transactional(propagation = Propagation.REQUIRED)
    public boolean addReceipt(Map<Integer, Cart> cart) {
        try {
            Session session = this.sessionFactory.getObject().getCurrentSession();
            SaleOrder order = new SaleOrder();
//            order.setUserId(this.userRepository.getUserById(6));
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            order.setUserId(this.userRepository.getUserByUsername(authentication.getName()));
            order.setCreatedDate(new Date());

            Map<String, String> stats = Utils.cartStats(cart);
            order.setAmount(Long.parseLong(stats.get("amount")));

            session.save(order);

            for (Cart c : cart.values()) {
                OrderDetail d = new OrderDetail();
                d.setOrderId(order);
                d.setProductId(this.productRepository.getProductById(c.getProductId()));
                d.setUnitPrice(c.getPrice());
                d.setNum(c.getQuantity());


                session.save(d);
            }

            return true;

        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<SaleOrder> getByActive(int active) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<SaleOrder> query = builder.createQuery(SaleOrder.class);
        Root root = query.from(SaleOrder.class);
        query = query.select(root);

//        Predicate p1 = builder.equal(root.get("userRole").as(String.class), role.trim());
        Predicate p1 = builder.equal(root.get("active").as(Integer.class), active);

        query = query.where(p1);

        query = query.orderBy(builder.desc(root.get("id")));

        javax.persistence.Query q = session.createQuery(query);


        return q.getResultList();
    }

    @Override
    public SaleOrder getOrderById(int orderId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        
        return session.get(SaleOrder.class, orderId);
    }

    @Override
    public List<SaleOrder> getOrders(Map<String, String> params, int page) {

        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<SaleOrder> q = b.createQuery(SaleOrder.class);
        Root root = q.from(SaleOrder.class);
        q = q.select(root);
        q = q.orderBy(b.desc(root.get("createdDate")));


        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
//            String kw = params.get("kw");
//            if (kw != null && !kw.isEmpty()) {
//                Predicate p = b.like(root.get("id").as(String.class), String.format("%%%s%%", kw));
//                predicates.add(p);
//            }


            if (params.containsKey("id")) {
                Predicate p = b.like(root.get("id").as(String.class),
                        String.format("%%%s%%", params.get("id")));
                predicates.add(p);
            }

            if (params.containsKey("amount")) {
                Predicate p = b.like(root.get("amount").as(String.class),
                        String.format("%%%s%%", params.get("amount")));
                predicates.add(p);
            }
            if (params.containsKey("createdDate")) {
                Predicate p = b.like(root.get("createdDate").as(String.class),
                        String.format("%%%s%%", params.get("createdDate")));
                predicates.add(p);
            }

            if (params.containsKey("active")) {
                Predicate p = b.like(root.get("active").as(String.class),
                        String.format("%%%s%%", params.get("active")));
                predicates.add(p);
            }
//
            q = q.where(predicates.toArray(Predicate[]::new));

        }

        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            int start = (page - 1) * size;
            query.setFirstResult(start);
            query.setMaxResults(size);


        }
        return query.getResultList();
    }

    @Override
    public boolean delete(SaleOrder order) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(order);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }
}


