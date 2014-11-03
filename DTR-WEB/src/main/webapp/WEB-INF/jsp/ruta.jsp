<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<!--[if lt IE 7 ]> <html class="ie6"> <![endif]-->
<!--[if IE 7 ]>    <html class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <html class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <html class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html class="" lang="es">
<!--<![endif]-->
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MAPPIR by Nicotina Estudio</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/css/mappir.css">
<link rel="stylesheet" href="/css/perfil.css">
<link rel="stylesheet" href="/css/jRating.jquery.css">
<link rel="stylesheet" href="/css/colorbox/colorbox.css" />
<style type="text/css">
#galeria, #galeria li {
	margin: 0;
	padding: 0;
	list-style: none;
}
#galeria li {
	float: left;
	margin: 5px;
	border: #979797 solid 1px;
}
</style>
</head>
<body>
	<%@include file="inc-menu-lateral.jsp"%>
	<%@include file="inc-menu-flotante.jsp"%>
	<div class="contenedor-general">
		<div class="row">
			<div id="ruta-header" class="col-md-12">
				<div id="mapa" style="width: 100%; height: 100%"></div>
				<div id="ruta-creada-por">
					<h4>
						<u></u> <img class="insignia img-circle"
							src="http://graph.facebook.com/${facebookId}/picture?type=large"
							width="50px" />
					</h4>
				</div>
			</div>
			<div class="col-md-12">
				<div class="rank" data-average="1" data-id="0"></div>
				<h3>${ ruta.nombre }</h3>
				<input type="hidden" value="${ruta.id}" id="rutaId" />
				<hr />
			</div>
			<div class="col-md-8">
				<div id="social">
					<a href="#"><img src="/img/iconos/ico_twitter.png" /></a> <a
						href="#"><img src="/img/iconos/ico_facebook.png" /></a> <a
						href="#"><img src="/img/iconos/ico_compartir.png" /></a>
				</div>
				<p>Destinos:</p>
				<ol>
					<c:forEach items="${ruta.pois}" var="poi">
						<li>${poi.desc}</li>
					</c:forEach>
				</ol>
				<hr />

				<ul id="myTab" class="nav nav-tabs" role="tablist">
					<li class="active"><a href="#resena" role="tab"
						data-toggle="tab">Reseña</a></li>
					<li class=""><a href="#costos" role="tab" data-toggle="tab">Costos</a></li>
					<li class=""><a href="#indicaciones" role="tab"
						data-toggle="tab">Indicaciones</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<div class="tab-pane fade active in" id="resena">
						<p>
							<c:out value="${ ruta.resena }"></c:out>
						</p>
					</div>
					<div class="tab-pane fade" id="costos">

						<p>Tiempo total</p>
						<p id="txt-tiempo-total"></p>

						<p>Total</p>
						<p id="txt-costo-caseta"></p>

					</div>
					<div class="tab-pane fade" id="indicaciones">
						<p>Indicaciónes.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<p>invitados:</p>
				<c:forEach items="${invitaciones}" var="invitacion">
					<img class="insignia img-circle"
						src="http://graph.facebook.com/${invitacion.usuario.facebookId}/picture?type=large"
						width="100px" />
				</c:forEach>
			</div>
			<div class="col-md-12">
				<hr />
				Fotografías:
				<ul id="galeria">
					<c:forEach items="${ruta.fotos}" var="foto">
						<li><a class="galeria"
							href="https://s3.amazonaws.com/descubriendo-tu-ruta/${foto.foto}"><img
								src="https://s3.amazonaws.com/descubriendo-tu-ruta/${foto.foto}"
								width="150px" /></a></li>
					</c:forEach>
				</ul>
				<div class="clear"></div>
				<hr />
				Comentarios:
				<div class="fb-comments"
					data-href="http://descubriendo-tu-ruta.herokuapp.com/ruta.jsp"
					data-width="690" data-numposts="5" data-colorscheme="light"></div>
			</div>
			<div class="col-md-12">
				<hr />
				Políticas de privacidad
			</div>
		</div>
	</div>
	<%@include file="inc-modals.jsp"%>
    <%@include file="/tmpl-scripts.jsp" %>
    <script src="/js/jrating/jRating.jquery.min.js"></script>
    <script>
    	
    	$(document).ready(function(){
    		
     		destinos.desde = ${ origen };
 			destinos.hasta = ${ destino };
			
 			<c:if test="${!empty intermedio_1}">
 				destinos.intermedio_1 = ${ intermedio_1 };
	 		</c:if>
	 		
	 		<c:if test="${!empty intermedio_2}">
				destinos.intermedio_2 = ${ intermedio_2 };
	 		</c:if>
	 		
	 		<c:if test="${!empty intermedio_3}">
				destinos.intermedio_3 = ${ intermedio_3 };
			</c:if>
	 		
	 		
			cargarRuta(function(){
				
				$("#txt-costo-caseta").text(
						"$ " + mappir.ruta.total  + " MXN"
				);
				
				$("#txt-tiempo-total").text(convertirHora(mappir.ruta.tiempoTotal));
			});
			
			$(".rank").jRating({
				step:true,
				length : 5,
				canRateAgain : false,
				nbRates : 1,
				bigStarsPath: "/img/jrating/stars.png",
				smallStarsPath: "/img/jrating/small.png",
				rateMax: 10,
				sendRequest: false,
				onClick: function(element, rate){
										
					$.ajax({
						url:mappir.servers.serverPath + "service/usuarios/calificar-ruta",
					      dataType   : "json",
					      type: "POST",
					      contentType: "application/json",
					      data: JSON.stringify({
					    	  ruta: $("#rutaId").val(),
					    	  rank: rate
					      }),
					      crossDomain: true,
					      success: function (data) {
					    	  alert(data.message)
					      },
					      error:function(a, b, c)
					      {
					    	  alert("error");
					      }
					  });
					
				}
			});
			
    	});
    	
    </script>

</body>
</html>