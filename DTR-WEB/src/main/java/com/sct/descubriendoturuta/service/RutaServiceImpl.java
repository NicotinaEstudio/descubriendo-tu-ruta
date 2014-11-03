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

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sct.descubriendoturuta.model.Foto;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.Usuario;

@Service
public class RutaServiceImpl implements RutaService{

	@PersistenceContext
    EntityManager em;
	
	@Override
	@Transactional
	public boolean guardarRuta(Usuario usuario, Ruta ruta) {
		
		ruta.setUsuario(usuario);		
		em.persist(ruta);
		
		return true;
	}

	@Override
	@Transactional
	public List<Ruta> obtenerRutas(int usuarioId) {
				
		Query query = em.createQuery("select r from Ruta r Where r.usuarioId = :p order by r.id desc");
		query.setParameter("p", usuarioId);
		
		return query.getResultList();
	}
}
