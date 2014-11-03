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

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sct.descubriendoturuta.model.APIFoto;
import com.sct.descubriendoturuta.model.APIUsuario;
import com.sct.descubriendoturuta.model.Foto;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.service.FotoService;
import com.sct.descubriendoturuta.service.RutaService;
import com.sct.descubriendoturuta.service.UsuarioService;

@RestController
@RequestMapping("/api")
public class APIController {

	@Autowired
	private UsuarioService usuarioService;
	@Autowired
	private FotoService fotoService;
	@Autowired
	private RutaService rutaService;

	/**
	 * Bienvenida a la API de SCT
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.POST, produces = "application/json")
	public String api() {	
		return "api";
	}
	
	/**
	 * Obtiene las rutas populares
	 * @return
	 */
	@RequestMapping(value = "/rutas/rutasPopulares", method = RequestMethod.POST, produces = "application/json")
	public String getRutasPopulares() {	
		return "rutas populares";
	}
	
	/**
	 * Obtiene los usuarios de la aplicación
	 * @return
	 */
	@RequestMapping(value = "/usuarios", method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody List<APIUsuario> getUsuarios() {
		
		return usuarioService.apiObtenerUsuarios();
	}
	
	/**
	 * Obtiene las rutas de un usuario
	 * @param usuarioId
	 * @return
	 */
	@RequestMapping(value = "/obtenerRutas/{usuarioId}", method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody List<Ruta> getRutas(@PathVariable("usuarioId") Integer usuarioId) {
		
		return usuarioService.obtenerRutas(usuarioId);
	}
	
	/**
	 * Alta de fotos para ruta especifica (en demo solo para ruta 1)
	 * @param denuncia
	 * @return
	 * @throws Exception
	 *
	 */
	@Transactional
	@RequestMapping(value = "/agregarFoto/{rutaId}", method = RequestMethod.POST, produces = "application/json", consumes={"application/json", "text/html;charset=utf-8", "multipart/form-data"})	
	public @ResponseBody String agregarFoto(@PathVariable("rutaId") Integer rutaId, @RequestBody APIFoto APIFoto) throws Exception {
		
		Foto foto = new Foto();
		Ruta ruta = usuarioService.obtenerRuta(rutaId);
				
		foto.setFoto(APIFoto.getFoto());
		foto.setUsuario("11");
		foto.setRuta(ruta);

		fotoService.agregarFoto(foto);
		
		return "{ \"response\" : \"ok\" }";
	}
}