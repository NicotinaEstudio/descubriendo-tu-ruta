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

/**
 * Class Usuario.
 * Representa el modelo usuarios.
 */

var Usuarios = (function(){
	this.id;
	this.facebookId;
	this.nombre;
	this.edadRango;
	this.edad;
	this.ubicacion;
	this.latitud;
	this.longitud;
});

/**
 * Class UsuariosController
 * Gestiona los usuarios de la aplicación. 
 */
var UsuariosController = (function(){

	var self = this;

	/**
	 * Almacena un usuario en la aplicacion.
	 */
	self.guardar = function(usuario, fx){

		if(usuario == null || usuario == undefined)
			return null;		
		
		 $.ajax({
		      url        : mappir.servers.socialApi + "usuarios/registrar",
		      dataType   : "json",
		      type: "POST",
		      contentType: "application/json",
		      data: JSON.stringify(usuario),
		      crossDomain: true,
		      success: function (data) {
		    	  if(fx != undefined)
		    	  {
		    		  fx();
		    	  }
		      },
		      error:function(a, b, c)
		      {
		    	  alert("error");
		      }
		  });
		
	};
	
	
	
	
	
});

