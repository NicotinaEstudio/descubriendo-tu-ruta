<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Modal rutas populares -->
<div class="modal fade" id="modal-rutas-populares" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Rutas populares</h4>
			</div>
			<div class="modal-body">
			
				<style>
					.stars-5{
						width: 120px;
						height: 24px;
						background: transparent url("/img/star.png");
						display: block;
					}
					.stars-4{
						width: 95px;
						height: 24px;
						background: transparent url("/img/star.png");
						display: block;
					}
					
					.stars-3{
						width: 70px;
						height: 24px;
						background: transparent url("/img/star.png");
						display: block;
					}
				</style>
				<table>
					<c:set var="item" value="5" />
					<c:forEach items="${rutasPopulares}" var="ruta">
						<tr>
							<td style="padding-left:20px;">
								<strong><a href="/home/ruta/${ruta.id}">${ruta.nombre }</a></strong>
							</td>
							<td td style="padding-left:20px;">
								<fmt:formatNumber type="number" 
           						maxFractionDigits="2" value="${ruta.popularidasd}" />
            				</td>
							<td td style="padding-left:20px;">
								<span class="stars-${item}"></span>
            				</td>
            				<c:set var="item" value="${item-1}" />
						</tr>
					</c:forEach>
				</table>
			
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal usuarios populares -->
<div class="modal fade" id="modal-usuario-populares" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Usuarios Populares</h4>
			</div>
			<div class="modal-body">
			<table>
				<c:set var="count" value="true" />
				<c:forEach items="${usuariosPopulares}" var="usuario">
					<tr>
						<td >
							<img
								src="http://graph.facebook.com/${usuario.facebookId}/picture?type=large"
								class="img-circle" width="80" />
						</td>
						<td style="padding-left:20px">${usuario.nombre }</td>
						<td width="200" style="padding-left:20px;"><strong>${usuario.puntos } pts. </strong></td>
						<td style="padding-left:100px">
							<c:if test="${count}">
								<img src="/img/iconos/insignias/insignia_3.png" width="80" />
								<c:set var="count" value="false" />
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>
<!-- Terminos y condiciones -->
<div class="modal fade" id="modal-terminos-y-condiciones" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Terminos y
					condiciones</h4>
			</div>
			<div class="modal-body">...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>
<!-- Terminos y condiciones -->
<div class="modal fade" id="modal-aviso-privacidad" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Politica de
					privacidad</h4>
			</div>
			<div class="modal-body">
				<p>Por medio de nuestra política de privacidad le ponemos al
					tanto de las debidas condiciones de uso en este sitio.</p>
				<p>La utilización de estos implica su aceptación plena y sin
					reservas a todas y cada una de las disposiciones incluidas en este
					Aviso Legal, por lo que si usted no está de acuerdo con cualquiera
					de las condiciones aquí establecidas, no deberá usar u/o acceder a
					este sitio.</p>
				<p>Reservamos el derecho a modificar esta Declaración de
					Privacidad en cualquier momento. Su uso continuo de cualquier
					porción de este sitio tras la notificación o anuncio de tales
					modificaciones constituirá su aceptación de tales cambios.
				<h2>Galletas o Cookies.</h2>
				<p>Este sitio hace uso de cookies, el cual son pequeños ficheros
					de datos que se generan en su ordenador, el cual envía información
					sin proporcionar referencias que permitan deducir datos personales
					de este.</p>
				<p>Usted podrá configurar su navegador para que notifique y
					rechace la instalación de las cookies enviadas por este sitio, sin
					que ello perjudique la posibilidad de acceder a los contenidos. Sin
					embargo, no nos responsabilizamos de que la desactivación de los
					mismos impida el buen funcionamiento de la del sitio.</p>

				<h2>Marcas Web o Web Beacons.</h2>
				<p>Al igual que las cookies este sitio también puede contener
					web beacons, un archivo electrónico gráfico que permite
					contabilizar a los usuarios que acceden al sitio o acceden a
					determinadas cookies del mismo, de esta manera, podremos ofrecerle
					una experiencia aún más personalizada.</p>

				<h2>Acciones De Terceros.</h2>
				<p>Asimismo, usted encontrará dentro de este sitio, páginas,
					promociones, micrositios, tiendas virtuales, encuestas,
					patrocinadores, publicistas, contratistas y/o socios y servicios
					comerciales, en conjunto con otros servicios compartidos, propios o
					cobrandeados con terceros (”Sitios Cobrandeados”) que le podrán
					solicitar Información, los cuales este sitio le podrá revelar
					información proporcionada por usted.</p>
				<p>La Información que se proporcione en estos Sitios
					Cobrandeados esta sujeta a las políticas de privacidad o leyendas
					de responsabilidad de Información que se desplieguen en dichos
					Sitios y no estará sujeta a esta política de privacidad. Por lo que
					recomendamos ampliamente a los Usuarios a revisar detalladamente
					las políticas de privacidad que se desplieguen en los Sitios
					Cobrandeados.</p>

				<p>Política De Privacidad De La Publicidad Proporcionada En Este
					Sitio: Google Adsense:
					http://www.google.com/intl/es_ALL/privacypolicy.html Reviewme:
					https://www.reviewme.com/privacy.php Shopping Ads:
					https://shoppingads.com/privacy/ SponsoredReviews:
					http://www.sponsoredreviews.com/privacy.asp Linklift:
					http://www.linklift.es/data-protection/?</p>

				<p>Nosotros estudiamos las preferencias de nuestros usuarios,
					sus características demográficas, sus patrones de tráfico, y otra
					información en conjunto para comprender mejor quiénes constituyen
					nuestra audiencia y qué es lo que usted necesita. El rastreo de las
					preferencias de nuestros usuarios también nos ayuda a servirle a
					usted los avisos publicitarios más relevantes.</p>

				<p>Política De Privacidad De Fuentes De Rastreo Utilizadas En
					Este Sitio: Google (Analytics):
					http://www.google.com/intl/es_ALL/privacypolicy.html MyBlogLog:
					http://info.yahoo.com/privacy/us/yahoo/mybloglog/</p>

				<h2>Política De Protección De Datos Personales</h2>
				<p>Para utilizar algunos de los servicios o acceder a
					determinados contenidos, deberá proporcionar previamente ciertos
					datos de carácter personal, que solo serán utilizados para el
					propósito que fueron recopilados.</p>
				<p>El tipo de la posible Información que se le sea solicitada
					incluye, de manera enunciativa más no limitativa, su nombre,
					dirección de correo electrónico (e-mail), fecha de nacimiento,
					sexo, ocupación, país y ciudad de origen e intereses personales,
					entre otros, no toda la Información solicitada al momento de
					participar en el sitio es obligatoria de proporcionarse, salvo
					aquella que consideremos conveniente y que así se le haga saber.</p>
				<p>Cómo principio general, este sitio no comparte ni revela
					información obtenida, excepto cuando haya sido autorizada por
					usted, o en los siguientes casos:</p>
				<p>a) Cuando le sea requerido por una autoridad competente y
					previo el cumplimiento del trámite legal correspondiente y b)
					Cuando a juicio de este sitio sea necesario para hacer cumplir las
					condiciones de uso y demás términos de esta página, o para
					salvaguardar la integridad de los demás usuarios o del sitio.
					Deberá estar consciente de que si usted voluntariamente revela
					información personal en línea en un área pública, esa información
					puede ser recogida y usada por otros. Nosotros no controlamos las
					acciones de nuestros visitantes y usuarios.</p>

				<h2>Conducta Responsable.</h2>
				<p>Toda la información que facilite deberá ser veraz. A estos
					efectos, usted garantiza la autenticidad de todos aquellos datos
					que comunique como consecuencia de la cumplimentación de los
					formularios necesarios para la suscripción de los Servicios, acceso
					a contenidos o áreas restringidas del sitio. En todo caso usted
					será el único responsable de las manifestaciones falsas o inexactas
					que realice y de los perjuicios que cause a este sitio o a terceros
					por la información que facilite.</p>
				<p>Usted se compromete a actuar en forma responsable en este
					sitio y a tratar a otros visitantes con respeto.</p>

				<h2>Contacto.</h2>
				<p>Si tiene preguntas o cuestiones sobre esta Política, no dude
					en contactarse en cualquier momento a través del formulario de
					contacto disponible en el sitio o por medio del correo electrónico
					tuemail@tusitio.com</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
			</div>
		</div>
	</div>
</div>
