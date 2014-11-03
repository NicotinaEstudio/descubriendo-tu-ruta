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
					<c:choose>
						<c:when test="${empty facebookId}">
							<img class="insignia"
								src="/img/iconos/ico_usuario_no_logueado.png" width="100px" />
						</c:when>
						<c:otherwise>
							<img class="insignia img-circle"
								src="http://graph.facebook.com/${facebookId}/picture?type=large"
								width="100px" />
							<div id="perfil-calificacion-head">
								<img src="/img/stars.png" />
							</div>
						</c:otherwise>
					</c:choose>
				</h1>

			</div>
			<div class="col-md-12">
				<h3>
					Mis Insignias<span class="badge">3</span>
				</h3>
				<hr />
<!-- 				<img class="insignia" src="/img/iconos/insignias/insignia_2.png" -->
<!-- 					 width="100px" /> -->
<!-- 				<img class="insignia" src="/img/iconos/insignias/insignia_3.png" -->
<!-- 					width="100px" /> -->

				<c:forEach items="${insignias}" var="insignia">
					<img class="insignia" src="/img/iconos/insignias/insignia_${insignia.tipo}.png"
						width="100px" />
				</c:forEach>
			</div>
			<div class="col-md-12">
				<h3>
					Mis Rutas<span class="badge">${rutas.size()}</span>
				</h3>
				<hr />
			</div>
			<div class="col-md-8">
				<ol>
					<c:forEach items="${rutas}" var="ruta">
						<li>
							<a href="ruta/${ruta.id}">
								${ruta.nombre }
							</a>
						</li>
					</c:forEach>
				</ol>
			</div>
			<div class="col-md-12">
				<h3>
					Invitaciones<span class="badge">${invitaciones.size()}</span>
				</h3>
				<hr />
			</div>
			<div class="col-md-8">
				<ol>
					<c:forEach items="${invitaciones}" var="invitacion">
						<li><a href="ruta/${invitacion.ruta.id}">${invitacion.ruta.nombre }</a></li>
					</c:forEach>
				</ol>
			</div>
			<div class="col-md-4">
				<button type="button" class="btn btn-default btn-lg">
					<span class="glyphicon glyphicon-plus"></span> <a
						href="/home/crear-ruta">Crear nueva ruta</a>
				</button>
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