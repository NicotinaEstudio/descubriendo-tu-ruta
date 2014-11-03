<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/tmpl-html.jsp" %>
<!--[if (gt IE 9)|!(IE)]><!-->
<html class="" lang="es">
<!--<![endif]-->
<head>
    <meta charset="utf-8" />
    <title>MAPPIR by Nicotina Estudio</title>
    <%@include file="/tmpl-head.jsp" %>
    <link rel="stylesheet" href="/css/perfil.css">
</head>
<body>
    <%@include file="inc-menu-lateral.jsp" %>
    <%@include file="inc-menu-flotante.jsp" %>
    <div class="contenedor-general">
    <div class="row">
    	<div class="col-md-12">
    		<h1>¡Bienvenido a MAPPIR!</h1>
    		<hr/>
    		<p>MAPPIR es una plataforma que....
    		<p>Para poder utilizar está plataforma por favor inicia sesión con tu cuenta de Facebook.</p>
    	</div>
    	
    	<div>
    	
    		
    	</div>
    	
    	<div class="col-md-12">
    	<hr/>
    	Políticas de privacidad</div>
    </div>
	</div>
    <%@include file="/tmpl-scripts.jsp" %>
</body>
</html>