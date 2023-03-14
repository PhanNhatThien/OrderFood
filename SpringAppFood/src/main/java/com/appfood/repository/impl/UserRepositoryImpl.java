/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.repository.impl;

import com.appfood.pojo.User;
import com.appfood.repository.UserRepository;

import java.util.ArrayList;
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
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author thien thien
 */
@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;


    private final int maxItemsInPage = 10;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }

    @Override
    public User getUserByUsername(String username) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<User> q = b.createQuery(User.class);
        Root root = q.from(User.class);
        q=q.select(root);

        q=q.where(b.equal(root.get("username").as(String.class), username));

        org.hibernate.query.Query query = session.createQuery(q);
        return (User) query.getSingleResult();
    }

    @Override
    public boolean addUser(User user) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try{
            session.save(user);
            
            return true;
        } catch(HibernateException ex){
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public boolean addOrUpdate(User user) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (user.getId() > 0)
                session.update(user);
            else
                session.save(user);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public User getUserById(int userId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        
        return session.get(User.class, userId);
    }

   
    @Override
    public List<User> getByRole(String role, int page, int active) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> query = builder.createQuery(User.class);
        Root root = query.from(User.class);
        query = query.select(root);

        Predicate p1 = builder.equal(root.get("userRole").as(String.class), role.trim());
        Predicate p2 = builder.equal(root.get("active").as(Integer.class), active);

        query = query.where(p1, p2);

        query = query.orderBy(builder.desc(root.get("id")));

        javax.persistence.Query q = session.createQuery(query);

        if (page != 0) {
            int max = maxItemsInPage;

            q.setMaxResults(max);
            q.setFirstResult((page - 1) * max);
        }
        return q.getResultList();
    }

    @Override
    public List<User> getUsersMultiCondition(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<User> q = builder.createQuery(User.class);
        Root root = q.from(User.class);
        q.select(root);
        q = q.orderBy(builder.desc(root.get("id")));

        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();


            if (params.containsKey("username")) {
                Predicate p8 = builder.like(root.get("username").as(String.class),
                        String.format("%%%s%%", params.get("username")));
                predicates.add(p8);
            }

            if (params.containsKey("phone")) {
                Predicate p9 = builder.like(root.get("phone").as(String.class),
                        String.format("%%%s%%", params.get("phone")));
                predicates.add(p9);
            }

            if (params.containsKey("email")) {
                Predicate p10 = builder.like(root.get("email").as(String.class),
                        String.format("%%%s%%", params.get("email")));
                predicates.add(p10);
            }

            if (params.containsKey("userRole")) {
                Predicate p11 = builder.like(root.get("userRole").as(String.class),
                        String.format("%%%s%%", params.get("userRole")));
                predicates.add(p11);
            }
            if (params.containsKey("avatar")) {
                Predicate p11 = builder.like(root.get("avatar").as(String.class),
                        String.format("%%%s%%", params.get("avatar")));
                predicates.add(p11);
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
    @Override
    public boolean delete(User user) {
        if (user.getProducts().size() == 0) {
            Session session = this.sessionFactory.getObject().getCurrentSession();
            try {
                session.delete(user);
                return true;
            } catch (HibernateException ex) {
                System.err.println(ex.getMessage());
            }
        }
        return false;
    }

    @Override
    public long count() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("Select Count(*) From User");

        return Long.parseLong(q.getSingleResult().toString());
    }

}
