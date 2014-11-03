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

var LatLng = (function(lat, lon){
	
	var self = this;
	
	self.lat;
	self.lon;
	
	_init = (function(){
		
		self.lat = lat;
		self.lon = lon;
		
	})();
	
});

var Map = (function(){

	var self = this;
	var mapa = null;
	var flightPath;
	var markerInicio = null;
	var markerFinal = null;
	var markersIntermedios = [];
	
	_init = (function(){
		
		if(mapa == null || mapa == undefined)
		{
		
			var mapOptions = {
				center: new google.maps.LatLng(24.700691, -102.658801),
				zoom: 6,
			    mapTypeId: google.maps.MapTypeId.ROADMAP
			};
			
			mapa = new google.maps.Map(document.getElementById("mapa"), mapOptions);
		}
	 
	})();
	
	self.limpiarMapa = function(){
		if(flightPath != null)
			flightPath.setMap(null);
		
		if(markerFinal != null && markerInicio != null)
		{
			markerFinal.setMap(null);
			markerInicio.setMap(null);
		}
		
		for (var i = 0; i < markersIntermedios.length; i++) {
			markersIntermedios[i].setMap(null);
		}
			
		markersIntermedios = [];
	}
	
	self.dibujarRuta = function(arrlatLng, marcadores){
		
		if(arrlatLng != null && arrlatLng != undefined)
		{
			var flightPlanCoordinates = [];
			
			var i = 0;
			for(;arrlatLng[i];)
			{
				var p = arrlatLng[i];			
				flightPlanCoordinates.push(new google.maps.LatLng(p.lat, p.lon));
				i++;
			}
			
			pInicio = arrlatLng[0];
			
			markerInicio = new google.maps.Marker({
			      position: new google.maps.LatLng(pInicio.lat, pInicio.lon),
			      map: mapa
			      //icon: ""
			  });
			
			var j =0;
			for(;marcadores[j];)
			{
				
				mInter = new google.maps.Marker({
					position: new google.maps.LatLng(marcadores[j].lat, marcadores[j].lon),
					map: mapa
					//icon: ""
				});
				
				markersIntermedios.push(mInter);
				 
				j++;
			}
			
			var pFinal = arrlatLng[i-1];
			markerFinal = new google.maps.Marker({
			      position: new google.maps.LatLng(pFinal.lat, pFinal.lon),
			      map: mapa
			      //icon: ""
			  });
			
			flightPath = new google.maps.Polyline({
				path : flightPlanCoordinates,
				geodesic : true,
				strokeColor : '#FF0000',
				strokeOpacity : 1.0,
				strokeWeight : 4
			});

			var pointer = arrlatLng[0];
			
			flightPath.setMap(mapa);
			
			self.moveMap(pointer.lat, pointer.lon);
			
		}
      	 
	}
	
	self.moveMap = function(lat, lon)
	{
		mapa.panTo(new google.maps.LatLng(lat, lon));
		mapa.setZoom(7);
	}
	
	
});


var mapInterface;

function inits()
{
	mapInterface = new Map();
	
//	var latLngs = [];
//	
//	latLngs.push(new LatLng(37.772323, -122.214897));
//	latLngs.push(new LatLng(21.291982, -157.821856));
//	
//	mapInterface.dibujarRuta(latLngs);
}

//google.maps.event.addDomListener(window, 'load', inits);

$(document).ready(function(){
	inits();
})
