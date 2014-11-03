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
</head>
<body>
	<div id="mapa" style="width: 100%; height: 100%"></div>
	<%@include file="inc-menu-lateral.jsp"%>
	<%@include file="inc-menu-flotante.jsp"%>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">NUEVA RUTA</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="cincuenta-por-ciento">
							Desde: <input type="text" id="txt-desde"> <br> <br>
							Hasta: <input type="text" id="txt-hasta"> <br> <br>
						</div>
						<div class="cincuenta-por-ciento">
							Vehiculo: <select id="cbx-vehiculo"></select><br> <br>
							Ejes: <select id="cbx-ejes">
								<option value="0">Sin Ejes Excedentes</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
							</select><br> <br> Rendimiento: <select id="cbx-rendimiento"></select>
							<br> <br> Combustible: <select id="cbx-combustible"></select>
							<br> <br>
							<p><a onclick="socialMappir.invitarAmigos()">Invitar amigos</a></p>
						</div>
					</form>
					<div class="clearfix"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
					<button id='btn-buscar-ruta' type="button" class="btn btn-primary">Buscar
						Ruta</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="inc-modals.jsp"%>	
	<%@include file="/tmpl-scripts.jsp"%>	
</body>
</html>