/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.appfood.repository.impl;

import com.appfood.pojo.Category;
import com.appfood.pojo.Comment;
import com.appfood.pojo.OrderDetail;
import com.appfood.pojo.Product;
import com.appfood.pojo.Restaurant;
import com.appfood.pojo.SaleOrder;
import com.appfood.pojo.User;
import com.appfood.repository.ProductRepository;
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
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author thien thien
 */
@Repository
@PropertySource("classpath:messages.properties")
@Transactional
public class ProductRepositoryImpl implements ProductRepository {

    @Autowired
    private LocalSessionFactoryBean sessionFactory;
    private final int maxItemsInPage = 20;

    public int getMaxItemsInPage() {
        return maxItemsInPage;
    }
    @Autowired
    private Environment env;

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<Product> getProducts(Map<String, String> params, int page) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Product> q = b.createQuery(Product.class);
        Root root = q.from(Product.class);
        q.select(root);
        q = q.orderBy(b.desc(root.get("createdDate")));



        if (params != null) {
            List<Predicate> predicates = new ArrayList<>();
            String kw = params.get("kw");
            if (kw != null && !kw.isEmpty()) {
                Predicate p = b.like(root.get("name").as(String.class), String.format("%%%s%%", kw));
                predicates.add(p);
            }


            String fp = params.get("fromPrice");
            if (fp != null) {
                Predicate p = b.greaterThanOrEqualTo(root.get("price").as(Long.class), Long.parseLong(fp));
                predicates.add(p);
            }
            String tp = params.get("toPrice");
            if (tp != null) {
                Predicate p = b.lessThanOrEqualTo(root.get("price").as(Long.class), Long.parseLong(tp));
                predicates.add(p);
            }

            String cateId = params.get("cateId");
            if (cateId != null) {
                Predicate p = b.equal(root.get("categoryId"), Integer.parseInt(cateId));
                predicates.add(p);
            }


            if (params.containsKey("name")) {
                Predicate p = b.like(root.get("name").as(String.class),
                        String.format("%%%s%%", params.get("name")));
                predicates.add(p);
            }

            if (params.containsKey("description")) {
                Predicate p = b.like(root.get("description").as(String.class),
                        String.format("%%%s%%", params.get("description")));
                predicates.add(p);
            }

            if (params.containsKey("price")) {
                Predicate p = b.like(root.get("price").as(String.class),
                        String.format("%%%s%%", params.get("price")));
                predicates.add(p);
            }

            q = q.where(predicates.toArray(Predicate[]::new));

        }

        Query query = session.createQuery(q);
        if (page > 0) {
            int size = Integer.parseInt(env.getProperty("page.size").toString());
            int start = (page - 1) * size;
            query.setFirstResult(start);
            query.setMaxResults(size);


        }

//        if (page != 0) {
//            int index;
//            if (maxItems == 0) {
//                index = (page - 1) * maxItemsInPage;
//                query.setFirstResult(index);
//                query.setMaxResults(maxItemsInPage);
//            } else {
//                index = (page - 1) * maxItems;
//                query.setFirstResult(index);
//                query.setMaxResults(maxItems);
//            }
//        }




        return query.getResultList();
    }

    @Override
    public int countProduct() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Query q = session.createQuery("SELECT Count(*) FROM Product");

        return Integer.parseInt(q.getSingleResult().toString());
    }

    @Override
    public boolean deleteProduct(int id) {
        Session session = this.sessionFactory.getObject().getCurrentSession();

        try {
            Product p = session.get(Product.class, id);
            session.delete(p);

            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean addProduct(Product p) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.save(p);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Object[]> countProdsByCate() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = b.createQuery(Object[].class);

        Root rP = q.from(Product.class);
        Root rC = q.from(Category.class);

        q.where(b.equal(rP.get("categoryId"), rC.get("id")));
        q.multiselect(rC.get("id"), rC.get("name"), b.count(rP.get("id")));
        q.groupBy(rC.get("id"));

        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public List<Object[]> countProdsByUser() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = b.createQuery(Object[].class);

        Root rP = q.from(Product.class);
        Root rU = q.from(User.class);
        Root rR = q.from(Restaurant.class);

        q.where(b.equal(rP.get("postedByUser"), rU.get("id")),
                b.equal(rR.get("user"), rU.get("id")));
        q.multiselect(rU.get("id"), rR.get("name"), b.count(rP.get("id")));
        q.groupBy(rU.get("id"));

        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public List<Object[]> frequencyStats() {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = b.createQuery(Object[].class);

        
        Root rU = q.from(User.class);
        Root rO = q.from(SaleOrder.class);

        q.where(b.equal(rO.get("userId"), rU.get("id")));
        q.multiselect(b.prod(b.count(rO.get("id")), b.count(rU.get("id"))));
        q.groupBy(rU.get("id"));

        Query query = session.createQuery(q);
        return query.getResultList();
    }

    @Override
    public List<Object[]> revenueStats(int quarter, int y) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = b.createQuery(Object[].class);

        Root rP = q.from(Product.class);
        Root rD = q.from(OrderDetail.class);
        Root rO = q.from(SaleOrder.class);

        q.where(b.equal(rD.get("productId"), rP.get("id")),
                b.equal(rD.get("orderId"), rO.get("id")),
                b.equal(b.function("QUARTER", Integer.class, rO.get("createdDate")), quarter),
                b.equal(b.function("YEAR", Integer.class, rO.get("createdDate")), y));

        q.multiselect(rP.get("id"), rP.get("name"), b.sum(b.prod(rD.get("num"), rD.get("unitPrice"))));
        q.groupBy(rP.get("id"));

        Query query = session.createQuery(q);
        return query.getResultList();
    }
    @Override
    public List<Comment> getComments(int productId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder b = session.getCriteriaBuilder();
        CriteriaQuery<Comment> q = b.createQuery(Comment.class);
        Root root = q.from(Comment.class);
        q.select(root);

        q.where(b.equal(root.get("productId"), productId));

        Query query = session.createQuery(q);
        return query.getResultList();

    }

    @Override
    public Product getProductById(int productId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        return session.get(Product.class, productId);
    }

    @Override
    public Comment addComment(String content, int productId) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        Comment c = new Comment();
        c.setContent(content);
        c.setProductId(this.getProductById(productId));
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        c.setUserId(this.userRepository.getUserByUsername(authentication.getName()));

        session.save(c);

        return c;
    }

    @Override
    public boolean delete(Product product) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            session.delete(product);
            return true;
        } catch (HibernateException ex) {
            System.err.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public Boolean addOrUpdate(Product product) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        try {
            if (product.getId() > 0)
                session.update(product);
            else
                session.save(product);
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        }

        return false;
    }
    @Override
    public List<Product> getByActive(int active) {
        Session session = this.sessionFactory.getObject().getCurrentSession();
        CriteriaBuilder builder = session.getCriteriaBuilder();
        CriteriaQuery<Product> query = builder.createQuery(Product.class);
        Root root = query.from(Product.class);
        query = query.select(root);

//        Predicate p1 = builder.equal(root.get("userRole").as(String.class), role.trim());
        Predicate p1 = builder.equal(root.get("active").as(Integer.class), active);

        query = query.where(p1);

        query = query.orderBy(builder.desc(root.get("id")));

        javax.persistence.Query q = session.createQuery(query);


        return q.getResultList();
    }
}
