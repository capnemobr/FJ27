<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de livros</title>
</head>
<form:form action="${spring:mvcUrl('PC#save').build()}" method="post" commandName="product" 
            enctype="multipart/form-data">
	<div>
		<label for="title">T�tulo</label>
		<form:input path="title" id="title" />
		<form:errors path="title" />
	</div>
	<div>
		<label for="description">Descri��o</label>
		<form:textarea path="description" rows="10" cols="20" id="description" />
		<form:errors path="description" />
	</div>
	<div>
		<label for="numberOfPages">N�mero de p�ginas</label>
		<form:input path="numberOfPages" id="numberOfPages" />
		<form:errors path="numberOfPages" />
	</div>
	<div>
		<c:forEach items="${types}" var="bookType" varStatus="status">
			<div>
				<label for="price_${bookType}">${bookType}</label> 
				<form:input type="text" path="prices[${status.index}].value" id="price_${bookType}" /> 
				<form:input type="hidden" path="prices[${status.index}].bookType" value="${bookType}" />
			</div>
		</c:forEach>
	</div>
	<div>
	   <label for="releaseDate"> Data de lan�amento</label>
	   <form:input path="releaseDate" type="date" id="releaseDate"/>
	   <form:errors path="releaseDate" />
	</div>

	<div>
		<label for="summary">Sumario do livro</label> 
		<input type="file" name="summary" id="summary" />
		<form:errors path="summaryPath" />
	</div>

	<div>
		<input type="submit" value="Enviar">
	</div>
</form:form>

</body>
</html>