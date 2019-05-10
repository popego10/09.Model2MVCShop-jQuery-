<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- tablib 사용해서 다 제거 --%>
<%-- <%@ page import="java.util.*"%>
<%@ page import="com.model2.mvc.common.Search"%>
<%@ page import="com.model2.mvc.common.Page"%>
<%@ page import="com.model2.mvc.service.domain.Product"%>
<%@ page import="com.model2.mvc.common.util.ConvertKO"%>
<%@ page import="com.model2.mvc.common.util.CommonUtil" %>

<%
	List<Product> list= (List<Product>) request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	Search search = (Search)request.getAttribute("search");
	
	//null 을 ""(nullString)으로 변경 ======>null방지
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%> --%>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
	//${param.menu}는 문자열이 아니므로 ""로 string으로 인식시켜줘야한다
	document.getElementById("menu").value = "${param.menu}";
   	document.detailForm.submit();		
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listProduct.do?menu=<%-- <%= request.getParameter("menu") %> --%> ${param.menu} method="post">

<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
			<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">
							<%-- <%
							if (request.getParameter("menu").equals("manage")) {%> 상품 관리 <%
								}else if (request.getParameter("menu").equals("search")) {%> 상품목록조회 
							<%}	%> --%>
							
							<%-- if문을 c:if로 바꿔서 사용해보자 :: if-else는 미지원한단다 --%>
							<c:if test="${param.menu eq 'manage'}">상품관리</c:if>
							<c:if test="${param.menu eq 'search'}">상품목록조회</c:if> 
							<%-- <c:choose>
								<c:when test="${param.menu == 'manage'}">상품관리
								</c:when>
								<c:when test="${param.menu == 'search'}">상품목록조회
								</c:when>
							</c:choose> --%>
								</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="right">
					<select name="searchCondition" class="ct_input_g" style="width: 80px">
							
							<%-- <option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>상품번호</option>
							<option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>상품명</option>
							<option value="2" <%= (searchCondition.equals("2") ? "selected" : "")%>>상품가격</option> --%>
							
							<%-- 위에 Search 인스턴스 생성안하고 EL을 이용하여 바로 사용--%>
							<option value="0" ${CommonUtil.null2str.search.searchCondition == 0? "selected" : ""}>상품번호</option>
							<option value="1" ${CommonUtil.null2str.search.searchCondition == 1? "selected" : ""}>상품명</option>
							<option value="2" ${CommonUtil.null2str.search.searchCondition == 2? "selected" : ""}>상품가격</option>
					</select> 
					<input type="text" name="searchKeyword"	value="${CommonUtil.null2str.search.searchKeyword}" class="ct_input_g"
						style="width: 200px; height: 19px" />
					</td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetProductList();">검색</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">전체 <%-- <%=resultPage.getTotalCount()%> --%> ${resultPage.totalCount }건수, 
					현재 <%-- <%=resultPage.getCurrentPage()%> --%>${resultPage.currentPage }페이지
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">가격</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">등록일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">현재상태</td>
				</tr>

				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<%-- <%
					for (int i = 0; i <list.size(); i++) {
						Product product = list.get(i);
				%> 
				<tr class="ct_list_pop">
					<td align="center"><%=i+1 %></td>
					<td></td>

					<td align="left"><a
						href="/getProduct.do?menu=<%=request.getParameter("menu")%>&
						
						prodNo=<%=product.getProdNo()%>">

							<%=product.getProdName()%></a></td>
					<td></td>
					<td align="left"><%=product.getPrice()%></td>
					<td></td>
					<td align="left"><%=product.getRegDate()%></td>
					<td></td>
					<td align="left">배송중</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				<%
					}
				%> --%>
				
				<%-- for ==> <c:forEach> 사용하여 반복문 돌리자 --%>
				<c:set var="i" value="0"/> 
				<%-- items는 list의 값을 하나씩 추출하여 정리해준다 --%>
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop">
					<td align="center">${i}</td>
					<td></td>
					<td align="left"><a	href="/getProduct.do?menu=${param.menu}&prodNo=${product.prodNo}">${product.prodName}</a></td>
					
					
					<td></td>
					<td align="left">${product.price}</td>
					<td></td>
					<td align="left">${product.regDate}</td>
					<td></td>
					<td align="left">배송중</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				</c:forEach>
</table>

<!-- navigation 시작 -->			
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <%-- 외부에서 jsp를 건들때 hidden을 이용하여 접근 --%>
		   <input type="hidden" id="menu" name="menu" value=""/>
		   <input type="hidden" id="search" name="search" value=""/>
		  	<jsp:include page="../common/pageNavigator.jsp"/>
	</tr>
</table>
<!-- navigation 끝 -->

</form>

</div>
</body>
</html>
