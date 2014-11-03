<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<menu id="menu-lateral">
	<a href="/"> <img src="/img/logo_sct.png" />
	</a>
	<h2>Descubriendo tu Ruta</h2>
	<section id="perfil">
		<c:choose>
			<c:when test="${empty facebookId}">
				<img src="/img/iconos/ico_usuario_no_logueado.png" width="150px"
					class="img-circle" />
			</c:when>
			<c:otherwise>
				<img
					src="http://graph.facebook.com/${facebookId}/picture?type=large"
					class="img-circle" width="150px" />
			</c:otherwise>
		</c:choose>
		<c:if test="${!empty facebookId}">
			<div id="perfil-calificacion">
				<img src="/img/stars.png" />
			</div>
		</c:if>
		<menu id="mnu-perfil">
			<ul>
				<c:if test="${!empty facebookId}">
					<li><a href="/home/perfil"><img
							src="/img/iconos/ico_corazon.png" class="tip"
							data-toggle="tooltip" data-placement="right" title="Mi perfil" /></a></li>
				</c:if>
				<li><img src="/img/iconos/ico_telefono.png" class="tip"
					data-toggle="tooltip" data-placement="right"
					title="Asistencia telefónica" /></li>
				<li><img src="/img/iconos/ico_audifono.png" class="tip"
					data-toggle="tooltip" data-placement="right"
					title="Asistencia en línea" /></li>
			</ul>
		</menu>
		<div class="clearfix"></div>
		<div id="login">
			<fb:login-button scope="public_profile" 
				onlogin="socialMappir.checkLoginStatus();"></fb:login-button>
		</div>
		<div class="clearfix"></div>
		<c:if test="${empty facebookId}">
            Inicia sesión con tu cuenta de facebook<br />
			<div class="terminos">
				<a href="#" data-toggle="modal"
					data-target="#modal-terminos-y-condiciones">Terminos y
					condiciones</a> | <a href="#" data-toggle="modal"
					data-target="#modal-aviso-privacidad">Aviso de privacidad</a>
			</div>
		</c:if>
		<div class="separador"></div>
	</section>
	<section id="ruta-sugerida">
		<c:choose>
			<c:when test="${empty esBusqueda}">
				<div id="ruta-sugerida-top-rapida">
					<p>Busqueda rápida:</p>
				</div>
			</c:when>
			<c:otherwise>
				<div id="ruta-sugerida-top">
					<p>Ruta sugerida:</p>
					<div id="social">
						<a href="#"><img src="/img/iconos/ico_twitter.png" /></a> <a
							href="#"><img src="/img/iconos/ico_facebook.png" /></a> <a
							href="#"><img src="/img/iconos/ico_compartir.png" /></a>
					</div>
				</div>
			</c:otherwise>
		</c:choose>


		<div id="ruta-sugerida-busqueda"
			class="ruta-sugerida-seccion text-left">
			<div class="poi">
				<div class="poi-titulo">Origen:</div>
				<div class="poi-lugar">
					<input type="text" id="txt-desde"
						placeholder="Ingresa el nombre del origen" va>
				</div>
			</div>
			<div id="POI-1" class="poi">
				<div class="poi-titulo">1:</div>
				<div class="poi-lugar">
					<input type="text" id="txt-poi-1"
						placeholder="Ingresa el lugar intermedio">
					<div class="poi-remover" onClick="removerPOIIntermedio(1);">X</div>
				</div>
			</div>
			<div id="POI-2" class="poi">
				<div class="poi-titulo">2:</div>
				<div class="poi-lugar">
					<input type="text" id="txt-poi-2"
						placeholder="Ingresa el lugar intermedio">
					<div class="poi-remover" onClick="removerPOIIntermedio(2);">X</div>
				</div>
			</div>
			<div id="POI-3" class="poi">
				<div class="poi-titulo">3:</div>
				<div class="poi-lugar">
					<input type="text" id="txt-poi-3"
						placeholder="Ingresa el lugar intermedio">
					<div class="poi-remover" onClick="removerPOIIntermedio(3);">X</div>
				</div>
			</div>
			<div class="poi">
				<div class="poi-titulo">Origen:</div>
				<div class="poi-lugar">
					<input type="text" id="txt-hasta"
						placeholder="Ingresa el nombre del destino">
				</div>
			</div>
			<a onClick="agregarPOIIntermedio();" style="margin-left: 10px;">Agregar
				punto intermedio +</a>
			<button type="button" class="btn btn-verde btn-buscar-ruta">Buscar
				mi ruta</button>
		</div>

	</section>
</menu>
<menu id="menu-lateral-busqueda" style="display: none;">
	<div onClick="cerrarMenuBusqueda();">CERRAR X</div>
	<div id="ruta-sugerida-resumen" class="ruta-sugerida-seccion">

		<div class="ruta-sugerida-resumen-concepto">
			<img src="/img/iconos/ico_tiempo.png" />
			<h4>Tiempo</h4>
			<p class="txt-tiempo">47 min</p>
		</div>
		<div class="ruta-sugerida-resumen-concepto">
			<img src="/img/iconos/ico_localizacion.png" />
			<h4>Distancia</h4>
			<p class="txt-distancia">54 Km</p>
		</div>
		<div class="ruta-sugerida-resumen-concepto">
			<img src="/img/iconos/ico_caseta.png" />
			<h4>Casetas</h4>
			<p class="txt-casetas">$0 MXN</p>
		</div>
		<div class="ruta-sugerida-resumen-concepto">
			<img src="/img/iconos/ico_gasolina.png" />
			<h4>Combustible</h4>
			<p class="txt-combustible">$42.59 MXN</p>
		</div>
		<div class="clear"></div>

		<div>
			Costo Total: <span id="gran-total" class="txt-total">$42.59
				MXN</span>
		</div>
		<p>Costos aproximados para:</p>
		<p class="txt-detalle">Auto chico, rendimiento: 16 km/lt, sin
			pasajes, sin incidentes.</p>
	</div>
	<div id="ruta-sugerida-detalle" class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="ruta-sugerida-detalle"
						href="#collapseOne"> + DETALLES </a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse">
				<div class="panel-body">
					<div class="ruta-sugerida-seccion">
						<table class="table">
							<tr>
								<th>Nombre</th>
								<th>Estado</th>
								<th>Km</th>
								<th>Caseta</th>
							</tr>
							<tr>
								<td>Morelia - La huerta</td>
								<td>Mich.</td>
								<td>18.100</td>
								<td>0</td>
							</tr>
							<tr>
								<td>Morelia - La huerta</td>
								<td>Mich.</td>
								<td>18.100</td>
								<td>0</td>
							</tr>
							<tr>
								<td>Morelia - La huerta</td>
								<td>Mich.</td>
								<td>18.100</td>
								<td>0</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</menu>


