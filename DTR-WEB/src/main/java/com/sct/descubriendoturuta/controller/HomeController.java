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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sct.descubriendoturuta.model.Foto;
import com.sct.descubriendoturuta.model.Insignia;
import com.sct.descubriendoturuta.model.Invitacion;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.RutaPoi;
import com.sct.descubriendoturuta.model.Usuario;
import com.sct.descubriendoturuta.model.Votacion;
import com.sct.descubriendoturuta.service.InsigniaService;
import com.sct.descubriendoturuta.service.RutaService;
import com.sct.descubriendoturuta.service.UsuarioService;

@Controller
@RequestMapping("/")
public class HomeController {

	private static final String SESSION_FACEBOOK_ID = "facebookId";
	private static final String SESSION_NOMBRE_USUARIO = "nombre";

	@Autowired
	private UsuarioService usuarioService;

	@Autowired
	private RutaService rutaService;
	
	@Autowired
	private InsigniaService insigniaService;

	//	@RequestMapping(value="/error", produces="application/json")
	//    @ResponseBody
	//    public Map<String, Object> handle(HttpServletRequest request) {
	//
	//        Map<String, Object> map = new HashMap<String, Object>();
	//        map.put("status", request.getAttribute("javax.servlet.error.status_code"));
	//        map.put("reason", request.getAttribute("javax.servlet.error.message"));
	//
	//        return map;
	//    }

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(HttpSession session, Map<String, Object> map) {

		/*
		 * Se verifica que exista la seción. de ser así se carga el perfil del
		 * usuario.
		 */
		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != "") {

			final String facebookId = (String) session
					.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre = (String) session
					.getAttribute(SESSION_NOMBRE_USUARIO);

			Usuario u = usuarioService.buscarFacebookId(facebookId);
			
			if (u != null) {
				
				map.put("facebookId", facebookId);
				map.put("nombre", nombre);
				
			} else {
				// Se limpia la sesión.
				session.invalidate();
			}
			
			
		}
		
		List<Ruta> rutas = usuarioService.obtenerRutasPopulares();
		List<Usuario> usuarios = insigniaService.obtenerUsuariosPopulares();
		
		map.put("rutasPopulares", rutas);
		map.put("usuariosPopulares", usuarios);

		return "index";
	}

	/**
	 * Vista para mostrar las rutas guardadas en el perfil del usuario.
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/perfil", method = RequestMethod.GET)
	public String perfil(HttpSession session, Map<String, Object> map) {
		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != "") {

			final String facebookId = (String) session
					.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre = (String) session
					.getAttribute(SESSION_NOMBRE_USUARIO);

			Usuario u = usuarioService.buscarFacebookId(facebookId);

			List<Ruta> rutas = u.getRutas();
			List<Invitacion> invitadas = usuarioService.obtenerRutasInvitadas(u
					.getId());

			List<Insignia> insignias = u.getInsignias();
			
			map.put("facebookId", facebookId);
			map.put("nombre", nombre);
			map.put("rutas", rutas);
			map.put("invitaciones", invitadas);
			map.put("insignias", insignias);
			
			
		} else {
			// return "redirect:/";
			return "perfil";
		}

		List<Ruta> rutasPopulares = usuarioService.obtenerRutasPopulares();
		List<Usuario> usuariosPopulares = insigniaService.obtenerUsuariosPopulares();
		
		map.put("rutasPopulares", rutasPopulares);
		map.put("usuariosPopulares", usuariosPopulares);
		
		return "perfil";
	}

	/**
	 * Vista para mostrar los perfiles públicos.
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/perfil/{id}", method = RequestMethod.GET)
	public String perfilPublico(HttpSession session, @PathVariable("id") Integer id, Map<String, Object> map) {

		List<Ruta> rutasPopulares = usuarioService.obtenerRutasPopulares();
		List<Usuario> usuariosPopulares = insigniaService.obtenerUsuariosPopulares();
		
		map.put("rutasPopulares", rutasPopulares);
		map.put("usuariosPopulares", usuariosPopulares);
		
		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != "") {

			final String facebookId = (String) session
					.getAttribute(SESSION_FACEBOOK_ID);

			Usuario u = usuarioService.buscarFacebookId(facebookId);

			map.put("facebookId", facebookId);

			Usuario usuarioPublico = usuarioService.buscarUsuario(id);

			List<Ruta> rutas = usuarioPublico.getRutas();

			map.put("usrfacebookId", usuarioPublico.getFacebookId());
			map.put("nombre", usuarioPublico.getNombre());
			map.put("rutas", rutas);

			return "perfil-publico";

		} else {
			return "redirect:/";
		}
	}

	/**
	 * Vista para crear nuevas rutas en el perfil del usuario.
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/crear-ruta", method = RequestMethod.GET)
	public String rutaNueva(HttpSession session, Map<String, Object> map) {
		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != "") {

			final String facebookId = (String) session
					.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre = (String) session
					.getAttribute(SESSION_NOMBRE_USUARIO);

			List<Ruta> rutasPopulares = usuarioService.obtenerRutasPopulares();
			List<Usuario> usuariosPopulares = insigniaService.obtenerUsuariosPopulares();
			
			map.put("rutasPopulares", rutasPopulares);
			map.put("usuariosPopulares", usuariosPopulares);
			
			map.put("facebookId", facebookId);
			map.put("nombre", nombre);
			map.put("ruta", new Ruta());

			return "ruta-nueva";
		} else {
			return "redirect:/";
		}
	}

	@RequestMapping(value = "/guardar-ruta", method = RequestMethod.POST)
	public String guardarRuta(HttpSession session, Map<String, Object> map,
			@ModelAttribute("ruta") Ruta ruta) {
		if (session.getAttribute(SESSION_FACEBOOK_ID) != null
				&& session.getAttribute(SESSION_FACEBOOK_ID) != "") {

			final String facebookId = (String) session
					.getAttribute(SESSION_FACEBOOK_ID);

			final String nombre = (String) session
					.getAttribute(SESSION_NOMBRE_USUARIO);

			List<RutaPoi> pois = new ArrayList<RutaPoi>();
			pois = ruta.getPois();

			Usuario u = usuarioService.buscarFacebookId(facebookId);
			ruta.setPois(null);

			usuarioService.agregarRuta(u, ruta);

			// TODO: Registrar insignia si es la primera ruta del usuario.
			
			if(insigniaService.obtenerInsigniasPor(u.getId(), 1).size() <= 0)
			{
				Insignia insignia = new Insignia();
				insignia.setUsuario(u);
				insignia.setTipo(1);
				
				insigniaService.ganarInsignia(insignia);
				
				// TODO: Incrementar puntos por compartir ruta.
				insigniaService.incrementarPuntos(u, 3, 1);
			}
			
			for (RutaPoi p : pois) {
				p.setRuta(ruta);
				usuarioService.agregarPoi(p);
			}
		} else {
			 return "redirect:perfil";
		}

		return "redirect:perfil";
	}

	/**
	 * Obtenemos la ruta
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/ruta/{id}", method = RequestMethod.GET)
	public String mostrarRuta(HttpSession session, @PathVariable("id") Integer id, Map<String, Object> map) {

		Ruta r = usuarioService.obtenerRuta(id);
		Usuario usuario = usuarioService.buscarUsuario(r.getUsuario().getId());

		List<RutaPoi> pois = r.getPois();
		List<Foto> fotos = r.getFotos();
		List<Invitacion> invitadas = usuarioService.obtenerUsuariosInvitados(r.getId());

		try 
		{
			int i = 0;
			int totalPois = pois.size();
			
			for (RutaPoi poi : pois) {
				JSONObject json = new JSONObject();

				json.put("idTramo", poi.getIdTramo());
				json.put("desc", poi.getDesc());
				json.put("idCategoria", poi.getIdCategoria());
				json.put("orden", poi.getOrden());
				json.put("source", poi.getSource());
				json.put("target", poi.getTarget());
				json.put("x", poi.getX());
				json.put("y", poi.getY());
				
				if (i == 0) 
					map.put("origen", json.toString());
				
				if(i == 1 && totalPois > 2)
					map.put("intermedio_1", json.toString());	
				
				if(i == 2 && totalPois > 3)
					map.put("intermedio_2", json.toString());
				
				if(i == 3 && totalPois > 4)
					map.put("intermedio_3", json.toString());
					
				if(i+1 == totalPois)
					map.put("destino", json.toString());
				
				i++;
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		List<Ruta> rutasPopulares = usuarioService.obtenerRutasPopulares();
		List<Usuario> usuariosPopulares = insigniaService.obtenerUsuariosPopulares();
		
		map.put("rutasPopulares", rutasPopulares);
		map.put("usuariosPopulares", usuariosPopulares);
		
		map.put("ruta", r);
		map.put("invitaciones", invitadas);
		map.put("fotos", fotos);
		map.put("usrfacebookId", usuario.getFacebookId());
		
		// Si es privada
		if(!r.getEsPublica())
		{
			// Solo usuarios registrados pueden ver rutas privadas
			if (session.getAttribute(SESSION_FACEBOOK_ID) != null && session.getAttribute(SESSION_FACEBOOK_ID) != "") 
			{
				final String facebookId = (String) session.getAttribute(SESSION_FACEBOOK_ID);
				final String nombre = (String) session.getAttribute(SESSION_NOMBRE_USUARIO);
				
				// Si es el dueño de la ruta
				if(r.getUsuario().getId() == usuario.getId())
					return "ruta";
				
				// Validamos si el usuario tiene acceso a la ruta
				for(Invitacion invitacion : invitadas)
					if(invitacion.getUsuario().getFacebookId() == facebookId)
						return "ruta";
			}
			
			return "redirect:/";
		}
		else
			return "ruta-publica";
	}

	@RequestMapping(value = "/aceptar-invitacion/{idRuta}", method = RequestMethod.GET)
	public String mostrarInvitacion(@PathVariable("idRuta") Integer idRuta,
			Map<String, Object> map) {
		Ruta r = usuarioService.obtenerRuta(idRuta);

		List<Ruta> rutasPopulares = usuarioService.obtenerRutasPopulares();
		List<Usuario> usuariosPopulares = insigniaService.obtenerUsuariosPopulares();
		
		map.put("rutasPopulares", rutasPopulares);
		map.put("usuariosPopulares", usuariosPopulares);
		map.put("ruta", r);
		map.put("usuario", r.getUsuario());

		return "aceptar-invitacion";
	}

	/**
	 * Metodo para eliminar la sesión de facebook.
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@RequestMapping(value = "/no-registrado")
	public String logout() {
		return "no-registrado";
	}

	@RequestMapping(value = "/facebook")
	public String facebookCanvas() {
		return "facebook-canvas";
	}

	@RequestMapping(value = "/rutas/{id}", method = RequestMethod.GET)
	public String redirectRuta(@PathVariable("id") Integer id) {
		return "redireccionar";
	}
}
