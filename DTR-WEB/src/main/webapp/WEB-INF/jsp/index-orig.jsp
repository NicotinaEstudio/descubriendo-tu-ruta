<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8" />
<title>Hello Heroku! by Nocotina Estudio</title>
<link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
<link rel="stylesheet" href="/css/mappir.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">

<script type="text/javascript" src="/js/jquery/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/jquery/jquery-ui.min.js"></script>

<style>
.ui-autocomplete-category {
	font-weight: bold;
	padding: .2em .4em;
	margin: .8em 0 .2em;
	line-height: 1.5;
}
</style>
<script type="text/javascript">
	
	var mappir =  {		
		usr : "sct",
		key: "sct",
		mapa:{
			origen: null,
			destinos: [],
			vehiculo: {
				"tipo"       : null,
	            "subtipo"    : null,
	            "rendimiento": null,
	            "combustible": null,
	            "costoltgas" : null,
		        "excedente"  : null
			},
			casetas: false,
			alertas: false,
			clima: false			
		}
	}
	
	$.widget("custom.catcomplete", $.ui.autocomplete, {
		_create : function() {
			this._super();
			this.widget().menu("option", "items",
					"> :not(.ui-autocomplete-category)");
		},
		_renderMenu : function(ul, items) {
			var that = this, currentCategory = "";
			$.each(items, function(index, item) {
				var li;
				if (item.category != currentCategory) {
					ul.append("<li class='ui-autocomplete-category'>"
							+ item.category + "</li>");
					currentCategory = item.category;
				}
				li = that._renderItemData(ul, item);
				if (item.category) {
					li.attr("aria-label", item.category + " : " + item.label);
				}
			});
		}
	});

	$(document).ready(function() {

		$("#txt-desde, #txt-hasta").catcomplete({			
			
			source : function(request, response){
				$.ajax({
	                url        : 'http://ttr.sct.gob.mx/TTR/rest/GeoSearchLocationSvt',
	                dataType   : "jsonp",
	                crossDomain: true,
	                data       : {
	                    search: request.term,
	                    usr   : 'sct',
	                    key   : 'sct'
	                },
	                success    : function (data) {	                	
	                	
	                	if (data !== undefined && data.results !== undefined) {
		                    var dataArreglado = $.map(data.results, function (categoria) {
		                        var toReturn = [];
		                        if (categoria !== null && categoria.items !== null && categoria.items.length !== null) {
			                        if (0 < categoria.items.length) {
			                            var items = categoria.items;
			                            for (var j in items) {
			                                var item = items[j];
			                                item.idCategoria = categoria.idCategoria;
			                                toReturn.push({
			                                    label   : item.desc,
			                                    value   : item.desc,
			                                    data    : item,
			                                    category: categoria.categoria
			                                });
			                            }
			                        }
		                        }
		                        return toReturn;
		                    });
		                    
		                    //if (undefined !== dataArreglado && undefined !== dataArreglado[0]) {
		                    //    MappirInterface.primeraOcurrenciaDeResultados = dataArreglado[0];
		                    //}
		                    
		                    response(dataArreglado);
	                	}
	                }
	                
		        });
			},		
			minLength:2,
			select: function( event, ui ) {
		        console.log( ui.item ?
		          "Selected: " + ui.item.label :
		          "Nothing selected, input was " + this.value);
		      },
		      change   : function (event, ui) {
		    	 $( this ).removeClass("ui-autocomplete-loading");		    	 
		      }
		});
		
		
		/*
			Funcion para cargar los datos del select vehiculos.
		*/
		function cargarVehiculos()
		{
			$.ajax({
                url        : "http://ttr.sct.gob.mx/mappir/servicios/geo/obtenerVehiculos/",
                dataType   : "json",                
                crossDomain: true,                
                success    : function (data) {	                	
                	
                	if(data.error === false)
                	{
                		var categoria = "";                		
                		var optGroup;
                		
                		$.each(data.data, function(i, val){
                			
                			// Si las categorias son diferentes indica
                			// que se trata de un item de otra.
                			if(val.categoria != categoria )
                			{	
                				categoria = val.categoria;
                				
                				optGroup = $("<optGroup label = '"+ categoria + "'/>");                				
                				optGroup.append("<option value='"+ val.id +"'>"+val.nombre+"</option>");
                				
                			}               			
                			else{
                				optGroup.append("<option value='"+ val.id +"'>"+val.nombre+"</option>")
                			}
                			
                			// se agrega el cambio
                			$("#cbx-vehiculo").append(optGroup);
                			
                		});
                	}
                	
                }                
	        });
		}
		
		/* Carga el rendimiento del km/lt */
		function cargarRendimiento()
		{
			for(i=1; i<=49; i++)
			{
				$("#cbx-rendimiento").append("<option value='"+ i.toString() +"'>"+i.toString()+" km/lt</option>");	
			}
		}
		
		function cargarCombustible()
		{
			$.ajax({
                url        : "http://ttr.sct.gob.mx/mappir/servicios/geo/obtenerCombustibles/",
                dataType   : "json",                
                crossDomain: true,                
                success    : function (data) {	                	
                	
                	if(data.error === false)
                	{                		                		
                		$.each(data.data, function(i, val){                			
                		
                			$("#cbx-combustible").append("<option value='"+ val.id +"'>"+val.nombre+ " " + val.costo + " $/lt</option>");
                			
                		});
                	}
                	
                }                
	        });
		}
		
		/* Evento para trazar la ruta en el mapa. */
		$("#btn-buscar-ruta").click(function(e)
		{
			e.preventDefault();
			
			paramsBuscarRuta = {
					"usr": mappir.usr,
					"key": mappir.key,
					"origen" : {
 							"idCategoria":"A-2",
 							"desc":"Morelia, Michoacán de Ocampo",
 							"idTramo":138246,
 							"source":2104192,
 							"target":2104189,
 							"x":-101.1924595,
 							"y":19.70327575
 					},
					"destinos" :[{
						 "idCategoria":"A-2",
							 "desc":"Nocupétaro, Michoacán de Ocampo",
							 "idTramo":121838,
							 "source":2089813,
							 "target":2089844,
							 "x":-101.16258,
							 "y":19.0437
					}],
					"opciones" : {
						"casetas" : false,
						"alertas" : false,				
					},
					"vehiculo": 
					{
						"tipo"       : 1,
			            "subtipo"    : 1,
			            "rendimiento": 16,
			            "combustible": 1,
			            "costoltgas" : 12,
				        "excedente"  : 0
					}
					
			}
			
			$.ajax({
				//type : 'POST',
				url : 'http://ttr.sct.gob.mx/TTR/rest/GeoRouteSvt',
				data:{
					"json":JSON.stringify({
						"usr" : paramsBuscarRuta.usr,
 						"key" : paramsBuscarRuta.key,
 						"origen": paramsBuscarRuta.origen,
 						"destinos": paramsBuscarRuta.destinos,
						"opciones":paramsBuscarRuta.opciones,
						"vehiculo":paramsBuscarRuta.vehiculo,
						"ruta":1
 					})
				}, 							
				contentType : 'application/json',
				dataType : 'jsonp',
				crossDomain: true,
				success : function(resp) {
					console.log(resp);
				},
				error : function(jqXHR, textStatus, errorThrown){
					console.log("Resp", resp);
					if (textStatus != "abort") {
						console.log(textStatus);
					}
				}
			});
			
			
			
			
		});
		
		cargarVehiculos();
		cargarRendimiento();
		cargarCombustible();
		
	});
</script>
</head>
<body>

	<!--     <menu id="menu-lateral"> -->
	<!--         seccion lateral -->
	<!--     </menu> -->
	<!--     <secion id="mapa"> -->
	<!--         mapa -->
	<!--     </secion> -->
	<!-- 	<a href="#">Test eclipse</a> -->

	<form>
		Desde: <input type="text" id="txt-desde"> <br> <br>
		Hasta: <input type="text" id="txt-hasta"> <br> <br>
		
		Vehiculo: <select id="cbx-vehiculo"></select><br> <br>
		Ejes: 
		<select id="cbx-ejes">
			<option value="0">Sin Ejes Excedentes</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
		</select><br> <br>
		Rendimiento: <select id="cbx-rendimiento"></select> <br> <br>
		Combustible: <select id="cbx-combustible"></select> <br> <br>	
			

		<input id='btn-buscar-ruta' type="button" value="Buscar Ruta" />
	</form>

</body>
</html>