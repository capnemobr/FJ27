<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib tagdir="/WEB-INF/tags" prefix="cdc" %>
<cdc:page title="listagem de Produtos"  >


<label> ${sucesso} </label>

    <sec:authorize access="isAuthenticated()">
    <c:url value="/logout" var="logout" />
    <a href="${logout}" > Logout</a>
       <sec:authentication property="principal" var="user"/>
       <div>
          Olá ${user.name}
       </div>
    </sec:authorize>
    
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <c:url value="/products/form" var="formLink" />
        <a href="${formLink}">
           Cadastrar novo produto
        </a>
    </sec:authorize>
    <table>
		<tr>
			<th>Título</th>
			<th>Valores</th>
			<th>Detalhes</th>
		</tr>
		<c:forEach items="${products}" var="product">
			<tr>
				<td>${product.title}</td>
				<td><c:forEach items="${product.prices}" var="price">
                            [${price.value} - ${price.bookType}]
                        </c:forEach></td>
                <td>
                 <c:url value="/products/${product.id}" var="linkDetalhar"/>
                 <a href="${linkDetalhar}">
                     Detalhar
                 </a>
                </td>
			</tr>
		</c:forEach>
	</table>

</cdc:page>