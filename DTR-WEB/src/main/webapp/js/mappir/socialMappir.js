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

var socialMappir = null;

window.fbAsyncInit = function() {	

	FB.init({
		//appId : '373956322780210', // Local - //'373956322780210'
		appId : '367054993470343', // Producción
		xfbml : true,
		version : 'v2.1'
	});

	socialMappir = new SocialMappir();	

};

(function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {
		return;
	}
	js = d.createElement(s);
	js.id = id;
	js.src = "//connect.facebook.net/es_LA/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


var SocialMappir = (function(){

	var self = this;


	/**
	 * Autenticacion del usuario.
	 */
	self.loginFacebook = function()
	{		
		FB.login(function(response) {
			if (response.authResponse) {			     
				FB.api('/me', function(response) {

				});
			} else {

			}
		},{
			scope: 'public_profile', 
			return_scopes: true
		});

	}

	function registrarUsuario(fx)
	{
		FB.api('/me', function(response) {

			var usuario = new Usuarios();

			usuario.facebookId = response.id;
			usuario.genero = response.gender == "male" ? 'M' : 'F';
			usuario.edadRango = "21-30";
			usuario.ubicacion = response.locale;
			usuario.nombre = response.name;
			usuario.latitud = mappir.usuario.latitud;
			usuario.longitud = mappir.usuario.longitud;

			var controller = new UsuariosController();
			controller.guardar(usuario, function(){

				if(fx != undefined)
					fx();
			});
		});
	}

	/*
	 * Verficia el status del usuario.  
	 */
	self.checkLoginStatus = (function()
			{
		FB.getLoginStatus(function(response) {

			if (response.status === 'connected') {

				var uid = response.authResponse.userID;
				var accessToken = response.authResponse.accessToken;

				registrarUsuario(function(){
					window.location = "/";
				});

			} else if (response.status === 'not_authorized')
				self.loginFacebook();
			else
				self.loginFacebook();
		});
			});

	/*
	 * Verficia funcion para aceptar 
	 */
	self.registroDesdeInvitacion= (function(fx) {
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				if(fx!=undefined && fx!=null)
					registrarUsuario(fx);
			} else if (response.status === 'not_authorized') {
				self.loginFacebook();
			} else {
				self.loginFacebook();
			}
		});
	});

	self.aceptarInvitacion = function(idRuta, fx){


		$.ajax({
			url        : mappir.servers.socialApi + "usuarios/aceptar-invitacion",
			dataType   : "json",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify({id:idRuta}),
			crossDomain: true,
			success: function (data) {
				if(fx != undefined)
				{
					fx(data);
				}
			},
			error:function(a, b, c)
			{
				alert(b);
			}
		});

	};

	self.invitarAmigos = (function()
			{
		FB.ui({method: 'apprequests',
			title: "Descubriendo tu ruta - LOCAL",
			message: "Descubre tu ruta en www.descubriendo-tu-ruta.com.mx/",
			//action_type:'turn',
//			object_id:'99999999999',
			url:"http://www.google.com"
		}, function(response){

//			if(fx != undefined && fx != null)
//			fx();

			console.log(response);
		});

		FB.api(
				'me/objects/descubriendoturuta:invitacion',
				'post',
				{
					app_id: '367054993470343',
					type: 'descubriendoturuta:invitacion',
					url: 'http://samples.ogp.me/379802682195574',
					title: 'Sample Invitacion',
					image: 'https://fbstatic-a.akamaihd.net/images/devsite/attachment_blank.png',
					description: 'none'
				},
				function(response) {
					// handle the response
				}
		);
			});


	self.obtenerAmigos = (function(){



		FB.api('/me/friends', function(response) {

			if(response.error)
				console.log("Error: " + response.error.message);

			if (response && !response.error) {
				console.log("face");
			}

		});

		return 0;
	});

	self.enviarInvitacion = (function(url, fx){

		FB.ui({
			method: 'send',
			link: url
			//redirect_uri: "/"
		});

	});

});

