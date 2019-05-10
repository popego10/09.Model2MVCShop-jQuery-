package com.model2.mvc.service.product.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDAO;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDAO {

	//filed
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//constructor
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}
	//method
	public void addProduct(Product product) throws Exception{
		sqlSession.insert("ProductMapper.insertProduct", product);
	}
	
	public Product getProduct(int prodNo) throws Exception{
		return sqlSession.selectOne("ProductMapper.findProduct", prodNo);
	}

	public List<Product> getProductList(Search search) throws Exception{
		return  sqlSession.selectList("ProductMapper.getProductList", search);
	}

	public void updateProduct(Product product) throws Exception{
		sqlSession.selectOne("ProductMapper.updateProduct", product);
	}
		
	public int getTotalCount(Search search) throws Exception{
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

}
