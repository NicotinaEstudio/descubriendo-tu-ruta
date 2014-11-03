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

package com.sct.descubriendoturuta.service;

import java.util.List;

import com.sct.descubriendoturuta.model.Invitacion;
import com.sct.descubriendoturuta.model.APIUsuario;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.RutaPoi;
import com.sct.descubriendoturuta.model.Usuario;
import com.sct.descubriendoturuta.model.Votacion;


public interface UsuarioService {

	/**
	 * Almacena la información del usuario.
	 * @param usuario
	 */
	public boolean agregarUsuario(Usuario usuario);
	
	/**
	 * Obtiene la información del usuario que coincida
	 * con el parametro especificado.
	 * @param id Identificador primario del usuario.
	 */
	public Usuario buscarUsuario(Integer id);
	
	public Usuario buscarFacebookId(String facebookId);
	
	public boolean agregarRuta(Usuario usuario, Ruta ruta);

	public boolean agregarPoi(RutaPoi poi);

	public List<Ruta> obtenerRutas(int usuarioId);
	
	public Ruta obtenerRuta(int idRuta);
	
	public boolean aceptarInvitacion(Invitacion invitacion);

	public List<Invitacion> obtenerRutasInvitadas(int usuarioId);

	public List<Invitacion> obtenerUsuariosInvitados(int rutaId);
	
	public List<APIUsuario> apiObtenerUsuarios();

	public boolean votarRuta(Votacion votar);

	public boolean usuarioVotoRuta(int usuarioId, int rutaId);

	List<Ruta> obtenerRutasPopulares();
	
}
