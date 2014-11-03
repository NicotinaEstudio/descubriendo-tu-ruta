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

package com.sct.descubriendoturuta.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.sct.descubriendoturuta.model.Insignia;
import com.sct.descubriendoturuta.model.Invitacion;
import com.sct.descubriendoturuta.model.Rate;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.RutaPoi;
import com.sct.descubriendoturuta.model.Usuario;
import com.sct.descubriendoturuta.model.Votacion;
import com.sct.descubriendoturuta.service.InsigniaService;
import com.sct.descubriendoturuta.service.UsuarioService;

@RestController
@RequestMapping("/service/usuarios")
public class UsuariosController {

	private static final String SESSION_FACEBOOK_ID = "facebookId";
	private static final String SESSION_NOMBRE_USUARIO = "nombre";

	@Autowired
	private UsuarioService usuarioService;

	@Autowired
	private InsigniaService insigniaService;
	
	@RequestMapping(
			value = "/aceptar-invitacion",
			method = RequestMethod.POST,
			produces = "application/json")
	public @ResponseBody Object aceptarInvitacion(HttpSession session,
			@RequestBody Ruta r) {

		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != ""){

			final String facebookId =
					(String) session.getAttribute(SESSION_FACEBOOK_ID);

			Usuario u = usuarioService.buscarFacebookId(facebookId);

			Ruta ruta = usuarioService.obtenerRuta(r.getId());
			
			Usuario uInvito = ruta.getUsuario();

			if (ruta == null)
			{
				JSONObject json = new JSONObject();
				try {

					json.put("mensaje", "No se encontro la ruta.");
					json.put("success", false);
					json.put("id", 0);

				} catch (JSONException e) {

				}

				return json;
			}

			Invitacion invitacion = new Invitacion();

			invitacion.setRuta(ruta);
			invitacion.setUsuario(u);
			invitacion.setAceptada(true);

			usuarioService.aceptarInvitacion(invitacion);
			
			// TODO: Si es su primera ruta compartida, ganar insignia.
			
			if(insigniaService.obtenerInsigniasPor(u.getId(), 2).size() <= 0)
			{
				Insignia insignia = new Insignia();
				insignia.setUsuario(uInvito);
				insignia.setTipo(2);
				
				insigniaService.ganarInsignia(insignia);
				
				
			}
			
			// TODO: Incrementar puntos por compartir ruta.
			insigniaService.incrementarPuntos(uInvito, 3, 2);
			
			JSONObject json = new JSONObject();

			try {

				if(invitacion.getId() > 0)
				{
					json.put("mensaje", "ok");
					json.put("success", true);				
					json.put("id", ruta.getId());
				}else
				{
					json.put("mensaje", "error");
					json.put("success", false);				
					json.put("id", 0);
				}

			} catch (JSONException e) {
				e.printStackTrace();
			}

			return json.toString();

		}
		else
		{
			return "{success:'false', msg:'error, no has iniciado sesión.'}";
		}

	}

	@RequestMapping(
			value = "/registrar",
			method = RequestMethod.POST,
			produces = "application/json")
	public @ResponseBody Object registro(HttpSession session,
			@RequestBody Usuario u) {

		/*
		 * Datos almacenados por defecto.
		 */
		u.setEsActivo(1);
		u.setFechaDeAlta(new Date());
		u.setFechaDeUltimoAcceso(new Date());
		u.setUbicacion(u.getUbicacion());

		JSONObject json = new JSONObject();
		String msg, status;

		System.out.println("LATLON" + u.getLatitud().toString() + ":" + u.getLongitud().toString());
		if (usuarioService.buscarFacebookId(u.getFacebookId()) == null) {
			if (usuarioService.agregarUsuario(u)) {

				// se almacena en la sesión el ID de facebook del usuario
				// registrado para iniciar sesión.				
				session.setAttribute("facebookId", u.getFacebookId());
				session.setAttribute("nombre", u.getNombre());

				msg = "OK";
				status = "true";

			} else
			{
				msg = "No es posible guardar el usuario.";
				status = "false";
			}
		} else {

			session.setAttribute("facebookId", u.getFacebookId());
			session.setAttribute("nombre", u.getNombre());

			msg = "El usuario ya existe.";
			status = "true";

		}

		try {
			json.put("msg", msg);
			json.put("success", status);
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return json.toString();
	}

	@RequestMapping(
			value = "/guardar-ruta",
			method = RequestMethod.POST,
			produces = "application/json")
	public @ResponseBody Object nuevaRuta(HttpSession session,
			@RequestBody Ruta ruta) {

		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != ""){

			final String facebookId =
					(String) session.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre =
					(String) session.getAttribute(SESSION_NOMBRE_USUARIO);


			List<RutaPoi> pois = new ArrayList<RutaPoi>();
			pois = ruta.getPois();

			Usuario u = usuarioService.buscarFacebookId(facebookId);
			ruta.setPois(null);

			usuarioService.agregarRuta(u, ruta);

			int pos = 0;
			for(RutaPoi p : pois)
			{
				p.setRuta(ruta);
				p.setOrden(pos);
				usuarioService.agregarPoi(p);

				pos++;
			}
			
			if(insigniaService.obtenerInsigniasPor(u.getId(), 1).size() <= 0)
			{
				Insignia insignia = new Insignia();
				insignia.setUsuario(u);
				insignia.setTipo(1);
				
				insigniaService.ganarInsignia(insignia);
				
				// TODO: Incrementar puntos por primera ruta.
				insigniaService.incrementarPuntos(u, 5, 1);
			}
			else
			{
				// TODO: Incrementar puntos por cada ruta creada.
				insigniaService.incrementarPuntos(u, 2, 1);
			}
			

			JSONObject json = new JSONObject();

			try {

				json.put("mensaje", "ok");
				json.put("success", true);
				json.put("id", ruta.getId());

			} catch (JSONException e) {
				e.printStackTrace();
			}

			return json.toString();

		}
		else
		{
			return "{success:'false', msg:'error, no has iniciado sesión.'}";
		}

	}

	@RequestMapping(
			value = "/calificar-ruta",
			method = RequestMethod.POST,
			produces = "application/json")
	public String RutaCalificar(HttpSession session,
			@RequestBody Rate rate) {



		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != ""){

			final String facebookId =
					(String) session.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre =
					(String) session.getAttribute(SESSION_NOMBRE_USUARIO);


			boolean status = true;
			String message = "";

			Usuario u = usuarioService.buscarFacebookId(facebookId);

			if(u == null)
			{
				message = "error, no has iniciado sesión.";
				status = false;
			}

			Ruta r = usuarioService.obtenerRuta(rate.getRuta());

			if(r == null)
			{
				message = "error, la ruta no exíste.";
				status = false;
			}

			Votacion votar = new Votacion();

			//			// el usuario voto esta ruta.
			//			if(usuarioService.usuarioVotoRuta(u.getId(), r.getId()))
			//			{
			//				message = "error, ya has votado esta ruta."; 
			//				status = false;
			//			}

			if(status)
			{
				votar.setRuta(r);
				votar.setUsuario(u);
				votar.setCalificacion(rate.getRank());

				usuarioService.votarRuta(votar);

				if(votar.getId() > 0)
					message = "Tu votación se ha registrado.";
				
				Usuario usuarioCreoRuta = r.getUsuario();
				
				if(rate.getRank() == 10)
				{
					// TODO: Incrementar puntos por ruta excelente.
					insigniaService.incrementarPuntos(usuarioCreoRuta, 10, 3);
				}
				else{
					// TODO: Incrementar puntos por ruta excelente.
					insigniaService.incrementarPuntos(usuarioCreoRuta, 5, 3);
				}
			}

			JSONObject json = new JSONObject();

			try {

				json.put("message", message);
				json.put("success", status);

			} catch (JSONException e) {
				e.printStackTrace();
			}

			return json.toString();

		}
		else
		{
			return "{success:'false', message:'error, no has iniciado sesión.'}";
		}
	}
}
