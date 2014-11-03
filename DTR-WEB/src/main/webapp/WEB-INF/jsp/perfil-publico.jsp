<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/tmpl-html.jsp"%>
<!--[if (gt IE 9)|!(IE)]><!-->
<html class="" lang="es">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>MAPPIR by Nicotina Estudio</title>
<%@include file="/tmpl-head.jsp"%>
<link rel="stylesheet" href="/css/perfil.css">
</head>
<body>
	<%@include file="inc-menu-lateral.jsp"%>
	<%@include file="inc-menu-flotante.jsp"%>
	<div class="contenedor-general">
		<div class="row">
			<div class="col-md-12 header">
				<h1>
					<c:out value="${nombre}" />
					<img class="insignia img-circle"
						src="http://graph.facebook.com/${usrfacebookId}/picture?type=large"
						width="100px" />
					<div id="perfil-calificacion-head">
						<img src="/img/stars.png" />
					</div>
				</h1>

			</div>
			<div class="col-md-12">
				<h3>
					Insignias<span class="badge">3</span>
				</h3>
				<hr />
				<img class="insignia" src="/img/iconos/insignias/insignia_1.png"
					width="100px" /> <img class="insignia"
					src="/img/iconos/insignias/insignia_2.png" width="100px" /> <img
					class="insignia" src="/img/iconos/insignias/insignia_3.png"
					width="100px" />
			</div>
			<div class="col-md-12">
				<h3>
					Rutas<span class="badge">${rutas.size()}</span>
				</h3>
				<hr />
			</div>
			<div class="col-md-12">
				<ol>
					<c:forEach items="${rutas}" var="ruta">
						<li><a href="ruta/${ruta.id}">${ruta.nombre }</a></li>
					</c:forEach>
				</ol>
			</div>
			<div class="col-md-12">
				<hr />
				<%@include file="/tmpl-pie-seccion.jsp"%></div>
		</div>
	</div>
	<%@include file="inc-modals.jsp"%>
	<%@include file="/tmpl-scripts.jsp"%>
</body>
</html>