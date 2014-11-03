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

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sct.descubriendoturuta.model.Insignia;
import com.sct.descubriendoturuta.model.Puntuacion;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.Usuario;

@Service
public class InsigniaServiceImpl implements InsigniaService{

	@PersistenceContext
    EntityManager em;
	
	
	@Override
	@Transactional
	public boolean ganarInsignia(Insignia insignia) {
		
		em.persist(insignia);		
		return insignia.getId() > 0 ? true : false;
	}
	
	
	@Override
	@Transactional
	public List<Insignia> obtenerInsignias(int usuarioId) {
		
		Query query = em.createQuery("select i from Insignia i Where i.usuarioId");
		query.setParameter("p", usuarioId);
		
		return query.getResultList();
	}
	
	@Override
	@Transactional
	public List<Insignia> obtenerInsigniasPor(int usuarioId, int tipo) {
		
		Query query = em.createQuery("select i from Insignia i Where i.usuario.id = :p and i.tipo = :t");
		query.setParameter("p", usuarioId);
		query.setParameter("t", tipo);
		
		return query.getResultList();
	}
	
	@Override
	@Transactional
	public void incrementarPuntos(Usuario usuario, double puntos, int categoria) {
		
		Puntuacion p = new Puntuacion(); 
		
		p.setUsuario(usuario);
		p.setPuntuacion(puntos);
		p.setCategoria(categoria);
		
		em.persist(p);
		
	}
	
	@Override
	@Transactional
	public List<Usuario> obtenerUsuariosPopulares() {
		
		Query query = em.createQuery("select p.usuario.id, SUM(p.puntuacion) from Puntuacion p GROUP BY p.usuario.id ORDER BY SUM(p.puntuacion) DESC");
		List<Puntuacion> puntos = query.getResultList();
		List<Usuario> usuarios = new ArrayList<Usuario>();
		
		Object[] v = puntos.toArray();
		for(Object o : v)
		{
			Object[] ro = (Object[]) o;
			Usuario u = em.find(Usuario.class, ro[0]);
			u.setPuntos((Double)ro[1]);
			
			usuarios.add(u);
		}
		
		return usuarios;
	}
	
	
	
}
