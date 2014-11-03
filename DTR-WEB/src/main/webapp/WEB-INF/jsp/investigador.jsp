<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/tmpl-html.jsp"%>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Investigadores</title>

<!-- Bootstrap -->
<link href="/css/bootstrap/bootstrap.min.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<style type="text/css">
#map-canvas {
	height: 400px;
	margin: 0;
	padding: 0;
}
</style>
<script src="/js/chart/Chart.js"></script>
<script>
	var randomScalingFactor = function() {
		return 100
	};

	var barChartData = {
		labels : [ "Hombres - Mujeres" ],
		datasets : [ {
			fillColor : "rgba(151,187,205,0.5)",
			strokeColor : "rgba(151,187,205,0.8)",
			highlightFill : "rgba(151,187,205,0.75)",
			highlightStroke : "rgba(151,187,205,1)",
			data : [ 61 ]
		}, {
			fillColor : "rgba(220,220,220,0.5)",
			strokeColor : "rgba(220,220,220,0.8)",
			highlightFill : "rgba(220,220,220,0.75)",
			highlightStroke : "rgba(220,220,220,1)",
			data : [ 72 ]
		} ]

	}
	window.onload = function() {
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myBar = new Chart(ctx).Bar(barChartData, {
			responsive : true
		});
	}
</script>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDIo2urS4W_mmgF0xYMNWQcrDowJ-aFsaI"></script>
<script type="text/javascript">
	var usuariosMapa = {};
	usuariosMapa['morelia'] = {
		center : new google.maps.LatLng(19.7039643, -101.2085714),
		numeroUsuarios : 250
	};
	usuariosMapa['df'] = {
		center : new google.maps.LatLng(19.3200988, -99.1521845),
		numeroUsuarios : 2000
	};

	var usuarioCirculo;

	function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(19.3200988, - 99.1521845),
			zoom : 6
		};
		var map = new google.maps.Map(document.getElementById('map-canvas'),
				mapOptions);

		for ( var ciudad in usuariosMapa) {

			var numeroUsuariosOpciones = {
				strokeColor : '#FF0000',
				strokeOpacity : 0.8,
				strokeWeight : 2,
				fillColor : '#FF0000',
				fillOpacity : 0.35,
				map : map,
				center : usuariosMapa[ciudad].center,
				radius : Math.sqrt(usuariosMapa[ciudad].numeroUsuarios) * 1000
			};

			usuarioCirculo = new google.maps.Circle(numeroUsuariosOpciones);
		}
	}
	google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">Descubriendo tu ruta</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>

	<div class="container theme-showcase" role="main">
		<br />
		<div class="page-header">
			<h1>Rutas</h1>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div id="map-canvas"></div>
			</div>
			<div class="col-md-4">
				<h3>Rutas populares</h3>
				<ol>
					<c:forEach items="${lstRutasPopulares}" var="ruta">
						<li><a href="ruta/${ruta.id}"> ${ruta.nombre } </a></li>
					</c:forEach>
				</ol>
			</div>
			<div class="col-md-4">
				<h3>Destinos frecuentes</h3>
				<ol>
					<c:forEach items="${lstDestinosFrecuentes}" var="poi">
						<li><a href="ruta/${ruta.id}"> ${ruta.nombre } </a></li>
					</c:forEach>
				</ol>
			</div>
			<div class="col-md-4">
				<h3>Origenes frecuentes</h3>
				<ol>
					<c:forEach items="${lstDestinosFrecuentes}" var="poi">
						<li><a href="ruta/${ruta.id}"> ${ruta.nombre } </a></li>
					</c:forEach>
				</ol>
			</div>
		</div>
		<div class="page-header">
			<h1>Usuarios</h1>
		</div>
		<div class="row">
			<div class="col-md-4">
				<h3>Estadisticas</h3>
				<dl class="dl-horizontal">
					<dt>Edad promedio</dt>
					<dd>25 - 30</dd>
					<dt>Ubicación + activa</dt>
					<dd>Mexico DF</dd>
					<dt>Ubicación - activa</dt>
					<dd>Guanajuatp</dd>
					<dt>Hombres</dt>
					<dd>72</dd>
					<dt>Mujeres</dt>
					<dd>61</dd>
				</dl>
			</div>
			<div class="col-md-8">
				<canvas id="canvas" height="250" width="600"></canvas>
			</div>
		</div>
	</div>
	<script src="/js/jquery/jquery-1.11.1.min.js"></script>
	<script src="/js/bootstrap/bootstrap.min.js"></script>
</body>
</html>