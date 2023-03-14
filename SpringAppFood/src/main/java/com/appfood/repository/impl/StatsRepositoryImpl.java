package com.appfood.repository.impl;

import com.appfood.pojo.Product;
import com.appfood.pojo.Category;
import com.appfood.pojo.User;
import com.appfood.repository.StatsRepository;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Repository
@Transactional
public class StatsRepositoryImpl implements StatsRepository {

    @Autowired
    private LocalSessionFactoryBean localSessionFactoryBean;

    @Override
    public List<Object[]> userRoleStats() {
        Session session = this.localSessionFactoryBean.getObject().getCurrentSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = criteriaBuilder.createQuery(Object[].class);
        Root rootUser = q.from(User.class);

        q.multiselect(rootUser.get("userRole"), criteriaBuilder.count(rootUser.get("id")));

        q.groupBy(rootUser.get("userRole"));

        Query query = session.createQuery(q);

        return query.getResultList();
    }

    @Override
    public List<Object[]> productStats() {
        Session session = this.localSessionFactoryBean.getObject().getCurrentSession();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Object[]> q = criteriaBuilder.createQuery(Object[].class);
        Root rootP = q.from(Product.class);

        q.multiselect(rootP.get("createdDate"), criteriaBuilder.count(rootP.get("id")));

        q.groupBy(criteriaBuilder.function("MONTH", Integer.class, rootP.get("createdDate")));

        q = q.orderBy(criteriaBuilder.desc(rootP.get("createdDate")));

        Query query = session.createQuery(q);

        return query.getResultList();
    }


}
