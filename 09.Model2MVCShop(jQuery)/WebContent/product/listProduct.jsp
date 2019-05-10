<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- tablib ����ؼ� �� ���� --%>
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
	
	//null �� ""(nullString)���� ���� ======>null����
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%> --%>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetList(currentPage) {
	document.getElementById("currentPage").value = currentPage;
	//${param.menu}�� ���ڿ��� �ƴϹǷ� ""�� string���� �νĽ�������Ѵ�
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
							if (request.getParameter("menu").equals("manage")) {%> ��ǰ ���� <%
								}else if (request.getParameter("menu").equals("search")) {%> ��ǰ�����ȸ 
							<%}	%> --%>
							
							<%-- if���� c:if�� �ٲ㼭 ����غ��� :: if-else�� �������Ѵܴ� --%>
							<c:if test="${param.menu eq 'manage'}">��ǰ����</c:if>
							<c:if test="${param.menu eq 'search'}">��ǰ�����ȸ</c:if> 
							<%-- <c:choose>
								<c:when test="${param.menu == 'manage'}">��ǰ����
								</c:when>
								<c:when test="${param.menu == 'search'}">��ǰ�����ȸ
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
							
							<%-- <option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>��ǰ��ȣ</option>
							<option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>��ǰ��</option>
							<option value="2" <%= (searchCondition.equals("2") ? "selected" : "")%>>��ǰ����</option> --%>
							
							<%-- ���� Search �ν��Ͻ� �������ϰ� EL�� �̿��Ͽ� �ٷ� ���--%>
							<option value="0" ${CommonUtil.null2str.search.searchCondition == 0? "selected" : ""}>��ǰ��ȣ</option>
							<option value="1" ${CommonUtil.null2str.search.searchCondition == 1? "selected" : ""}>��ǰ��</option>
							<option value="2" ${CommonUtil.null2str.search.searchCondition == 2? "selected" : ""}>��ǰ����</option>
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
									href="javascript:fncGetProductList();">�˻�</a></td>
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
					<td colspan="11">��ü <%-- <%=resultPage.getTotalCount()%> --%> ${resultPage.totalCount }�Ǽ�, 
					���� <%-- <%=resultPage.getCurrentPage()%> --%>${resultPage.currentPage }������
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�������</td>
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
					<td align="left">�����</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				<%
					}
				%> --%>
				
				<%-- for ==> <c:forEach> ����Ͽ� �ݺ��� ������ --%>
				<c:set var="i" value="0"/> 
				<%-- items�� list�� ���� �ϳ��� �����Ͽ� �������ش� --%>
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
					<td align="left">�����</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
				</c:forEach>
</table>

<!-- navigation ���� -->			
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <%-- �ܺο��� jsp�� �ǵ鶧 hidden�� �̿��Ͽ� ���� --%>
		   <input type="hidden" id="menu" name="menu" value=""/>
		   <input type="hidden" id="search" name="search" value=""/>
		  	<jsp:include page="../common/pageNavigator.jsp"/>
	</tr>
</table>
<!-- navigation �� -->

</form>

</div>
</body>
</html>
