/**
* Copyright 2014 Nicotina Estudio
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
*     http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
**/

var mappir =  {		
		usr : "sct",
		key: "sct",
		servers:{
			//serverPath: "http://localhost:8080/home/", 
			serverPath: "http://descubriendo-tu-ruta.herokuapp.com/home/",
			//socialApi:"http://localhost:8080/home/service/",
			socialApi:"http://descubriendo-tu-ruta.herokuapp.com/home/service/",
			geoSearchLocationSvt : "https://dtr.azurewebsites.net/api/geosearchlocationsvt",
			geoRouteSvt : "https://dtr.azurewebsites.net/api/georoutesvt"
		},
		mapa:{
			origen: null,
			destinos: [],
			vehiculo: {
				"tipo"       : 1,
	            "subtipo"    : 1,
	            "rendimiento": 1,
	            "combustible": 3,
	            "costoltgas" : 12.80,
		        "excedente"  : 0
			},
			casetas: false,
			alertas: false,
			clima: false			
		},
		ruta:{
			titulo: null,
			descripcion: null,
			tipo: 0,
			casetasNo: 0,
			casetasTotal: 0,
			tiempoTotal: 0,
			distanciaTotal: 0,
			gasConsumida: 0,
			gasTotal: 0,
			total: 0,
		},
		usuario:{
			latitud: null,
			longitud: null,
		}
	}

/*
 * La variable almacena los destinos seleccionados hasta un máximo
 * de cinco.
 */
	var destinos = {
			origen: null,
			intermedio1: null,
			intermedio2:null,
			intermedio3:null,
			destino:null
	};
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
		
		$("#txt-desde, #txt-hasta, #txt-poi-1, #txt-poi-2, #txt-poi-3").catcomplete({
			source : function(request, response){
				$.ajax({
                    url        : mappir.servers.geoSearchLocationSvt,
                    type       : 'POST',
	                dataType   : "jsonp",
	                crossDomain: true,
	                data       : {
	                    search: request.term,
	                    usr   : 'sct',
	                    key   : 'sct'
	                },
	                success    : function (data) {	                	
	                	
	                	data = jQuery.parseJSON(data);
	                	
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
		                    
		                    response(dataArreglado);
	                	}
	                }
	                
		        });
			},		
			minLength:2,
			select: function( event, ui ) {
				
				var id = $(this).attr("id");
				
				if(id === "txt-desde"){
					destinos.desde = ui.item.data;
				}
				else{
					if(id === "txt-hasta")
					{
						destinos.hasta = ui.item.data;
					}
					
					if(id === "txt-poi-1")
					{
						destinos.intermedio_1 = ui.item.data;
					}
					
					if(id === "txt-poi-2")
					{
						destinos.intermedio_2 = ui.item.data;
					}
					
					if(id === "txt-poi-3")
					{
						destinos.intermedio_3 = ui.item.data;
					}
				}
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
                				optGroup.append("<option value='"+ val.id +"' tipo='"+val.categoria_id+"'>"+val.nombre+"</option>");
                				
                			}               			
                			else{
                				optGroup.append("<option value='"+ val.id +"' tipo='"+val.categoria_id+"'>"+val.nombre+"</option>");
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
                		               			
                			$("#cbx-combustible").append("<option value='"+ val.id +"' costo='"+val.costo+"'>"+val.nombre+ " " + val.costo + " $/lt</option>");
                			
                		});
                	}
                	
                }                
	        });
		}
		
		
		/*
		 * Evento para seleccionar el tipo de vehiculo.
		 */

		$("#cbx-vehiculo").change(function(e){
			mappir.mapa.vehiculo.subtipo = $(this).val();
			mappir.mapa.vehiculo.tipo = $("#cbx-vehiculo option:selected").attr("tipo");
		});
		
		/*
		 * Evento para seleccionar los ejes
		 */
		$("#cbx-ejes").change(function(e){
			mappir.mapa.vehiculo.excedente = $(this).val();
		});
		
		/*
		 * Evento para saleccionar el rendimiento.
		 */
		$("#cbx-rendimiento").change(function(e){
			mappir.mapa.vehiculo.rendimiento = $(this).val();
		});
		
		/*
		 * Evento para seleccionar el combustible
		 */
		$("#cbx-combustible").change(function(e){
			mappir.mapa.vehiculo.combustible = $(this).val();
			mappir.mapa.vehiculo.costoltgas = $("#cbx-combustible option:selected").attr("costo");
		});
		
		
		/* Evento para trazar la ruta en el mapa. */
		$("#btn-buscar-ruta, .btn-buscar-ruta").click(function(e)
		{
			e.preventDefault();
						
			cargarRuta(null, this);
		});
		
		
		cargarVehiculos();
		cargarRendimiento();
		cargarCombustible();

	});
	
	
	
	var puntosIntermedios = 0;
	
	function restablecerValores()
	{
		mappir.mapa.vehiculo.subtipo = 1;
	}
	
	function convertirHora(valor)
	{
		var h = Math.floor( valor / 60);          
	    var m = Math.floor(valor % 60);
	    
	    if(m < 10)
	    	m = "0"+ m;
	    
	    if(h < 10)
	    	h = "0" + h;
	    
		return h + ":" + m;
	}
	
	function agregarPOIIntermedio(){
		$("#POI-" + (puntosIntermedios + 1)).css("display", "block");
		puntosIntermedios++;
	}	
	function removerPOIIntermedio(poi){
		
		if(poi == 1)
			destinos.intermedio_1 = null;
		if(poi == 2)
			destinos.intermedio_2 = null;
		if(poi == 3)
			destinos.intermedio_3 = null;
		
		$("#POI-" + (poi)).css("display", "none");
		puntosIntermedios--;
	}

	function abrirMenuBusqueda(){
		$("#menu-lateral-busqueda").attr("style", "display:block");
		$( "#menu-lateral-busqueda" ).animate({
		    width: 310
		  }, 500, function() {
		    // Animation complete.
		  });
	}
	
	function cerrarMenuBusqueda(){
		$( "#menu-lateral-busqueda" ).animate({
		    width: 0
		  }, 500, function() {
		   		$("#menu-lateral-busqueda").attr("style", "display:none");
		  });
	}
	
	/*
	 * Despliega un panel con la información detallada de la ruta. 
	 */
	function mostrarInformacionRuta(ruta)
	{
		$(".txt-tiempo").text(convertirHora(ruta.tiempoTotal));
		$(".txt-distancia").text(Math.floor(ruta.distanciaTotal/1000) + " Km");
		$(".txt-casetas").text("$ "+ ruta.casetasTotal + " MXN");
		$(".txt-combustible").text("$ "+ ruta.gasConsumida + " MXN");
		$(".txt-total").text("$ "+ ruta.total + " MXN");
		$(".txt-detalle").text($("#cbx-vehiculo option:selected").text() + $("#cbx-rendimiento option:selected").text() + $("#cbx-combustible option:selected").text() );
	}
	
	var GeoLocation = (function(fn){
		
		
		var fx = fn; // Determina la
		
		var self = this;
		
		self.getLocation = function()
		{
			if(fx == undefined || fx == null)
			{
				throw "La funcion de geolocation no debe ser null";
				return false;
			}
			if (navigator.geolocation) {
		        navigator.geolocation.getCurrentPosition(showPosition, showError);
		    } else {
		    	fx({
		        	status: false, 
		        	message: "Su navegador no soporta Geolocation.",
		        	position: null
		        });
		    }
		}
		
		function showPosition(position) {
			
			fx({
				status: true, 
	        	message: "ok",
	        	position: {
	        		lat: position.coords.latitude,
	        		lon: position.coords.longitude
	        	}
			});
		}
		
		function showError(error) {
			
			var message;
			
		    switch(error.code) {
		        case error.PERMISSION_DENIED:
		        	message = "El usuario no permitío la geolocalización."
		            break;
		        case error.POSITION_UNAVAILABLE:
		        	message = "La información de ubicación no esta disponible."
		            break;
		        case error.TIMEOUT:
		        	message = "La petición para la ubicacion tardo demasiado."
		            break;
		        case error.UNKNOWN_ERROR:
		        	message = "Ha ocurrido un error desconocido."
		            break;
		    }
		    
		    fx({
		    	status: false, 
	        	message: message,
	        	position: null
		    });
		}
	});
	
	var geo = new GeoLocation(function(response)
	{
		if(response.status == true)
		{
			mappir.usuario.latitud = response.position.lat;
			mappir.usuario.longitud = response.position.lon;
		}
		else{
			alert(response.message);
		}
	});
	
	geo.getLocation();
	
	function cargarRuta(fx, self)
	{

		if(destinos.desde == null || destinos.hasta == null)
		{
			alert("Debes ingresar el origen y destino");
			return false;
		}
		
		var pois = [];
		
		if(destinos.intermedio_1 != null)
			pois.push(destinos.intermedio_1);
		
		if(destinos.intermedio_2 != null)
			pois.push(destinos.intermedio_2);
		
		if(destinos.intermedio_3 != null)
			pois.push(destinos.intermedio_3);
		
		pois.push(destinos.hasta);
		
		paramsBuscarRuta = {
			"usr": mappir.usr,
			"key": mappir.key,
			"origen" : destinos.desde,
			"destinos" :pois,
			"opciones" : {
				"casetas" : mappir.mapa.casetas,
				"alertas" : mappir.mapa.alertas,
			},
			"vehiculo": 
			{
				"tipo"       : mappir.mapa.vehiculo.tipo,
	            "subtipo"    : mappir.mapa.vehiculo.subtipo,
	            "rendimiento": mappir.mapa.vehiculo.rendimiento,
	            "combustible": mappir.mapa.vehiculo.combustible,
	            "costoltgas" : mappir.mapa.vehiculo.costoltgas,
		        "excedente"  : mappir.mapa.vehiculo.excedente
			}
		}
		
		$(self).addClass("btn-send-data");
		
		$.ajax({
			type : 'POST',
			url : mappir.servers.geoRouteSvt,
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
				resp = jQuery.parseJSON(resp);
				if (resp.status == "OK" && resp.results !== undefined && resp.results[0] !== undefined 
                		&& resp.results[0].grafo !== undefined && resp.results[0].grafo.length > 0) {
					
					var ruta = resp.results[0].grafo;
					var latLngs = [];
					
					var k = 0;
					var marcadores = [];
					
					
					
					for(;ruta[k];)
					{
						var i=0;
						
						var tramo = ruta[k][11];
						var isIntermedio = false;
						
						if(ruta[k][15])
							marcadores.push(new LatLng(tramo[i][1], tramo[i][0]));
							
						for(;tramo[i];)
						{
							var latLon = tramo[i];
							latLngs.push(new LatLng(latLon[1], latLon[0]));
							
							i++;
						}
						
						k++;
					}
					
					mapInterface.limpiarMapa();
					mapInterface.dibujarRuta(latLngs, marcadores);
					
					
					mappir.ruta.titulo = resp.results[0].titulo;
					mappir.ruta.descripcion = resp.results[0].descripcion;
					mappir.ruta.tipo = resp.results[0].tipo;
					mappir.ruta.casetasNo = resp.results[0].casetasNo;
					mappir.ruta.casetasTotal = resp.results[0].casetasTotal;
					mappir.ruta.tiempoTotal = resp.results[0].tiempoTotal;
					mappir.ruta.distanciaTotal = resp.results[0].distanciaTotal;
					mappir.ruta.gasConsumida = resp.results[0].gasConsumida;
					mappir.ruta.gasTotal = resp.results[0].gasTotal;
					mappir.ruta.total = resp.results[0].total;
					
					mostrarInformacionRuta(mappir.ruta);
					abrirMenuBusqueda();
					
					if(fx != undefined && fx != null)
						fx();
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				if (textStatus != "abort") {
					alert("No es posible realizar la busqueda");
				}
			},
			complete: function(data)
			{
				$(self).removeClass("btn-send-data");
			}
		});
		
		
		
		
	}
