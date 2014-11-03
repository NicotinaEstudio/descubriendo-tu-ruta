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
    <meta property="og:title" content="Mi ruta - Descubriendo tu ruta" />
    <meta property="og:url" content="http://descubriendo-tu-ruta.herokuapp.com/home/crear-ruta" />
    <meta property="og:site_name" content="Descubriendo tu ruta" />
    <meta property="og:description" content="Hey, te invito a mi ruta..." />
    <meta property="og:image" content="http://descubriendo-tu-ruta.herokuapp.com/img/face-app-icon-pequeno.png" />
    <meta property="fb:app_id" content="367054993470343" />
    <%@include file="/tmpl-head.jsp" %>
    <link rel="stylesheet" href="/css/perfil.css">
    <link rel="canonical" href="http://descubriendo-tu-ruta.herokuapp.com/home/crear-ruta" />
</head>
<body>
    <%@include file="inc-menu-lateral.jsp" %>
    <%@include file="inc-menu-flotante.jsp" %>
    <div class="contenedor-general">
    <div class="row">
    	<div id="ruta-header" class="col-md-12">
    		<div id="mapa" style="width: 100%; height: 100%"></div>
    		<div id="ruta-creada-por">
    		<h4>
    			<img class="insignia img-circle"
							src="http://graph.facebook.com/${facebookId}/picture?type=large"
							width="50px" />
			</h4>
    		</div>
    	</div>
    	<form:form method="post" action="guardar-ruta" commandName="ruta">
    	<div class="col-md-12">
    	<h1>Nueva ruta</h1>
    	<hr/>
    	<div class="form-group">
    	<div class="btn-group" data-toggle="buttons">
		  <label id="sel-publico" class="btn btn-primary">
		  <form:radiobutton path="esPublica" value="true" id="option1" label="Publica" checked="true"/> 
<!-- 		    <input type="radio" name="options" id="option1" checked> -->
		  </label>
		  <label id="sel-privado" class="btn btn-primary active">
		  <form:radiobutton path="esPublica" value="false" id="option2" label="Privada"/>
<!-- 		    <input type="radio" name="options" id="option2"> Privada -->
		  </label>
		</div>
    	</div>
    	<div class="form-group">
		    <label for="exampleInputEmail1">Nombre de la ruta</label>
				<form:input path="nombre" class="form-control" id="txt-ruta-nombre" placeholder="Ingresa el nombre de la ruta."/>
		  </div>
    	
    	</div>
    	<div class="col-md-8">
	
    	<p>Destinos:</p>
		<div id="ruta-sugerida-busqueda"
			class="ruta-sugerida-seccion text-left">
			<div class="poi">
				<div class="poi-titulo">Origen:</div>
				<div class="poi-lugar">
					<!--                 	<input type="text" id="txt-desde" placeholder="Ingresa el nombre del origen"> -->
					<form:input path="pois[0].desc" id="txt-desde" placeholder="Ingresa el nombre del origen" />
<%-- 					<form:hidden path="pois[0].idCategoria" id="poi0_idCategoria"/> --%>
<%-- 					<form:hidden path="pois[0].orden" id="poi0_orden"/> --%>
<%-- 					<form:hidden path="pois[0].idTramo" id="poi0_idTramo" value="1"/> --%>
<%-- 					<form:hidden path="pois[0].source" id="poi0_source"/> --%>
<%-- 					<form:hidden path="pois[0].target" id="poi0_target"/> --%>
<%-- 					<form:hidden path="pois[0].latitud" id="poi0_latitud"/> --%>
<%-- 					<form:hidden path="pois[0].longitud" id="poi0_longitud"/> --%>
					
				</div>
			</div>
			<div id="POI-1" class="poi">
				<div class="poi-titulo">1:</div>
				<div class="poi-lugar">
					<!-- 					<input type="text" id="txt-poi-1" placeholder="Ingresa el lugar intermedio"> -->
					<form:input path="pois[1].desc" id="txt-poi-1" placeholder="Ingresa el lugar intermedio" />
					<div class="poi-remover" onClick="removerPOIIntermedio(1);">X</div>
				</div>
			</div>
			<div id="POI-2" class="poi">
				<div class="poi-titulo">2:</div>
				<div class="poi-lugar">
<!-- 					<input type="text" id="txt-poi-2" -->
<!-- 						placeholder="Ingresa el lugar intermedio"> -->
						<form:input path="pois[2].desc" id="txt-poi-2" placeholder="Ingresa el lugar intermedio" />
					<div class="poi-remover" onClick="removerPOIIntermedio(2);">X</div>
				</div>
			</div>
			<div id="POI-3" class="poi">
				<div class="poi-titulo">3:</div>
				<div class="poi-lugar">
<!-- 					<input type="text" id="txt-poi-3" -->
<!-- 						placeholder="Ingresa el lugar intermedio"> -->
					<form:input path="pois[3].desc" id="txt-poi-3" placeholder="Ingresa el lugar intermedio" />
					<div class="poi-remover" onClick="removerPOIIntermedio(3);">X</div>
				</div>
			</div>
			<div class="poi">
				<div class="poi-titulo">Destino:</div>
				<div class="poi-lugar">
<!-- 					<input type="text" id="txt-hasta" -->
<!-- 						placeholder="Ingresa el nombre del destino"> -->
					<form:input path="pois[4].desc" id="txt-hasta" placeholder="Ingresa el nombre del destino" />
				</div>
			</div>
			<a onClick="agregarPOIIntermedio();">Agregar punto intermedio
				+</a>
			<button type="button" class="btn btn-verde btn-buscar-ruta">Trazar mi
				ruta</button>
		</div>
		<hr/>
    		
    <p>Reseña:</p>
    <form:textarea path="resena" class="form-control" rows="10" id="txt-ruta-resena"/>
<!--     <textarea class="form-control" rows="10"></textarea>     -->
    <input type="button" class="btn btn-verde" id="btn-guardar" value="Guardar">
    </div>
    </form:form>
  
    	<div class="col-md-4">
<!--     	<div id="ruta-amigos"> -->
<!--     		<p><a data-toggle="modal" data-target="#modal-amigos" onclick="socialMappir.invitarAmigos()">Invitar amigos</a></p> -->
<!--     		<img class="insignia" src="img/iconos/ico_usuario_no_logueado.png" width="100px" /> -->
<!--     	</div> -->
    	</div>
    	
    	<div class="col-md-12">
    	</div>
    	<div class="col-md-12">
    	<hr/>
    	<%@include file="/tmpl-pie-seccion.jsp" %></div>
    </div>
	</div>
     <!-- Modal -->
<div class="modal fade" id="modal-amigos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">NUEVA RUTA</h4>
      </div>
      
      <div class="modal-body">
          Amigos...
          <div class="clearfix"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        <button id='btn-buscar-ruta' type="button" class="btn btn-primary">Buscar Ruta</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="modal-confirmacion" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">INVITAR AMIGOS</h4>
      </div>
      <div class="modal-body">
          
          <p>Tu ruta ha sido creada
          
          ¿Te gustaría invitar a tus amigos?</p>
          
          <div class="clearfix"></div>
      </div>
      <div class="modal-footer">
        <button id='btn-aceptar' type="button" class="btn btn-default">Listo termine</button>
        <button id='btn-invitar-amigos' type="button" class="btn btn-primary">Si quiero invitar a mis amigos</button>
      </div>
    </div>
  </div>
</div>
<%@include file="inc-modals.jsp"%>	
<%@include file="/tmpl-scripts.jsp" %>
<script type="text/javascript">

$( document ).ready(function() {
	
	
	var idRuta = null;
	
    $("#ruta-sugerida").remove();
    
    $("#sel-publico").click(function() {
   	  	//$("#ruta-amigos").hide("slow");
   	});
    $("#sel-privado").click(function() {
   	  	//$("#ruta-amigos").show("slow");
   	});
    
    $("#btn-aceptar").click(function(e){
    	window.location = "perfil";
    });
    
    $("#btn-invitar-amigos").click(function(e){
    	e.preventDefault();
    	
    	if(idRuta != null)
    		socialMappir.enviarInvitacion(mappir.servers.serverPath + "aceptar-invitacion/" + idRuta);
    });
    
    $("#btn-guardar").click(function(e){
    	
		var pois = [];
		
		pois.push(destinos.desde);
		
		if(destinos.intermedio_1 != null)
			pois.push(destinos.intermedio_1);
		
		if(destinos.intermedio_2 != null)
			pois.push(destinos.intermedio_2);
		
		if(destinos.intermedio_3 != null)
			pois.push(destinos.intermedio_3);
		
		pois.push(destinos.hasta);
    	
    	var ruta = {
    	    	nombre: $("#txt-ruta-nombre").val(),
    	    	esPublica: $('input[name="esPublica"]:checked').val(),
    	    	esActiva:true,
    	    	resena:$("#txt-ruta-resena").val(),
    	    	pois: pois
    	    }
    	$(this).addClass("btn-send-data");
	    $.ajax({
		      url        : mappir.servers.serverPath + "service/usuarios/guardar-ruta",
		      dataType   : "json",
		      type: "POST",
		      contentType: "application/json",
		      data: JSON.stringify(ruta),
		      crossDomain: true,
		      success: function (data) {
		    	  		    	  
		    	  
		    	  if(data.success === true)
		    	  {
		    		if(data.id !=null )
	    			{
		    			idRuta = data.id.toString();
		    			$("#modal-confirmacion").modal();
	    			}
		    	  }
		    	  else
		    		 alert('Lo sentimos no es posible guardar tu ruta.');
		    	  
		      },
		      error:function(jqXHR, textStatus, errorThrown)
		      {
		    	  alert(errorThrown);
		      },
		      complete: function(data)
		      {
		    	  $("#btn-guardar").removeClass("btn-send-data");
		      }
		  });
    });
});	
</script>
</body>
</html>