package com.model2.mvc.web.product;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@Controller
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping("/addProductView")
	public String addProductView() throws Exception {

		System.out.println("/addProductView");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping("/addProduct")
	
	public String addProduct( @ModelAttribute("product") Product product, @RequestParam("file") MultipartFile[] files, 
								MultipartHttpServletRequest request, Model model) throws Exception {

		System.out.println("/addProduct");
		
		/////////////////다중 file upload 처리////////////////////
				
		String uploadPath = "C:\\Users\\USER\\git\\06MVC2\\06.Model2MVCShop(Presentation+BusinessLogic)\\WebContent\\images\\uploadFiles";
		String fileOriginName ="";
		String fileMultiName ="";
		
		for (int i = 0; i < files.length; i++) {
			fileOriginName = files[i].getOriginalFilename();
			System.out.println(fileOriginName);
			File fff = new File(uploadPath+"\\"+fileOriginName);
			files[i].transferTo(fff);
			if(i==0) {
				fileMultiName += fileOriginName;
			}else {
				fileMultiName += ","+ fileOriginName;
			}
		}//end of for
		product.setFileName(fileMultiName);
		
		productService.addProduct(product);
		model.addAttribute("product", product);
				
		return "redirect:/product/addProduct.jsp";
		
		
//		//Business Logic
//		productService.addProduct(product);
//		
//		System.out.println(product);
//		
//		return "redirect:/product/addProduct.jsp";
	}
	
	@RequestMapping("/getProduct")
	public String getUser( @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
		
		System.out.println("/getProduct");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping("/updateProductView")
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping("/updateProduct")
	public String updateProduct( @ModelAttribute() Product product , Model model , HttpSession session) throws Exception{

		System.out.println("/updateProduct");
		//Business Logic
		productService.updateProduct(product);
		
		int prodNo = product.getProdNo();
		System.out.println(prodNo);
		
		return "redirect:/getProduct.do?prodNo="+prodNo;
	}
	
	@RequestMapping("/listProduct")
	public String listUser( @ModelAttribute() Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
}