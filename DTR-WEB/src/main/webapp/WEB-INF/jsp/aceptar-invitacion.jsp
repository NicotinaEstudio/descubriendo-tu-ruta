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
    		<p><strong>${usuario.nombre }</strong>, te ha invitado a su ruta <strong>${ruta.nombre}</strong></p>
    	
    		<p>Para poder continuar primero inicia sesión con tu cuenta de Facebook.</p>
    		
    		<a href="#" onclick="inciarSesion()" id="btn-inicio-facebook" class="btn btn-default btn-lg">Aceptar Invitación</a>
    		
    	</div>
    	
    	<div class="col-md-12">
    	<hr/>
    	Políticas de privacidad</div>
    </div>
	</div>
	

    <%@include file="/tmpl-scripts.jsp" %>
    
    <script>
    	
    	function inciarSesion()
    	{
			var ruta = ${ruta.id};
   			socialMappir.registroDesdeInvitacion(function(response){
   				
   				socialMappir.aceptarInvitacion(ruta, function(r){
   	    			
   					window.location = "/home/perfil";
   					
   	    		});
   				
   			});
    	}
    
    </script>
    
</body>
</html>