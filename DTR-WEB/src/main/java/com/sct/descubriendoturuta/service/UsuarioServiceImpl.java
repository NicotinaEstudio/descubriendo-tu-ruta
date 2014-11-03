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
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sct.descubriendoturuta.model.Invitacion;
import com.sct.descubriendoturuta.model.APIUsuario;
import com.sct.descubriendoturuta.model.Person;
import com.sct.descubriendoturuta.model.Ruta;
import com.sct.descubriendoturuta.model.RutaPoi;
import com.sct.descubriendoturuta.model.Usuario;
import com.sct.descubriendoturuta.model.Votacion;

@Service
public class UsuarioServiceImpl implements UsuarioService {

	@PersistenceContext
    EntityManager em;
	
	@Override
	@Transactional
	public boolean agregarUsuario(Usuario usuario) {
		
		em.persist(usuario);
		return usuario.getId() > 0 ? true: false;
	}

	@Override
	@Transactional
	public Usuario buscarUsuario(Integer id) {
		Query query = em.createQuery("select u from Usuario u Where u.id = :fid order by u.id");		
		query.setMaxResults(1);
		query.setParameter("fid", id);
		
		List<Usuario> r = query.getResultList();
		
		return r.isEmpty() ? null: r.get(0);
	}
	
	@Override
	@Transactional
	public Usuario buscarFacebookId(String facebookId)
	{
		
		Query query = em.createQuery("select u from Usuario u Where u.facebookId = :fid order by u.id");		
		query.setMaxResults(1);
		query.setParameter("fid", facebookId);
		
		List<Usuario> r = query.getResultList();
		
		return r.isEmpty() ? null: r.get(0);
	}

	@Override
	@Transactional
	public boolean agregarRuta(Usuario usuario, Ruta ruta) {
		
		ruta.setUsuario(usuario);
		em.persist(ruta);
		
		return ruta.getId() > 0 ? true: false;
	}
	
	@Override
	@Transactional
	public List<Ruta> obtenerRutas(int usuarioId)
	{
		Query query = em.createQuery("select r from Ruta r Where r.usuario.id = :p order by r.id desc");
		query.setParameter("p", usuarioId);
		
		return query.getResultList();
	}
	
	@Override
	@Transactional
	public List<Invitacion> obtenerRutasInvitadas(int usuarioId){
		
		Query query = em.createQuery("select i from Invitacion i WHERE i.usuario.id = :p");
		
		query.setParameter("p", usuarioId);
		
		return query.getResultList();
	}
	
	@Override
	@Transactional
	public List<Invitacion> obtenerUsuariosInvitados(int rutaId){
		
		Query query = em.createQuery("select i from Invitacion i WHERE i.ruta.id = :p");
		query.setParameter("p", rutaId);
		
		return query.getResultList();
	}

	@Override
	@Transactional
	public boolean agregarPoi(RutaPoi poi) {
		
		em.persist(poi);
		
		return poi.getId() > 0 ? true: false;
	}

	@Override
	@Transactional
	public Ruta obtenerRuta(int idRuta) {
		
		Ruta r = em.find(Ruta.class, idRuta);
		return r;
	}

	@Override
	@Transactional
	public boolean aceptarInvitacion(Invitacion invitacion) {
		
		em.persist(invitacion);
			
		return invitacion.getId() > 0 ? true: false;
	}
	
	@Override
	@Transactional
	public boolean votarRuta(Votacion votar) {
		
		em.persist(votar);
		return votar.getId() > 0 ? true: false;
	}
	
	/**
	 * Verifica si el usuario realizo la votación por la ruta.
	 * @param votar
	 * @return
	 */
	@Override
	@Transactional
	public boolean usuarioVotoRuta(int usuarioId, int rutaId) {
		
		Query query = em.createQuery("select v from Votacion v WHERE v.usuario.id = :u and v.ruta.id = :r ");
		query.setParameter("u", usuarioId);
		query.setParameter("r", rutaId);
		
		return query.getResultList().size() > 0 ? true : false;
	}
	
	
	@Override
	@Transactional
	public List<Ruta> obtenerRutasPopulares() {
		
		Query query = em.createQuery("select v.ruta.id, SUM(v.calificacion)/MAX(v.id) as rate from Votacion v GROUP BY v.ruta.id ORDER BY SUM(v.calificacion)/MAX(v.id) DESC");
		
		List<Votacion> votaciones = query.getResultList();
		List<Ruta> rutas = new ArrayList<Ruta>();
		
		Object[] v = votaciones.toArray();
		for(Object o : v)
		{
			Object[] ro = (Object[]) o;
			Ruta r = em.find(Ruta.class, ro[0]);
			r.setPopularidasd((Double)ro[1]);
			
			rutas.add(r);
		}
		return rutas;
	}
	
	
	@Override
	public List<APIUsuario> apiObtenerUsuarios(){
		Query query = em.createQuery("select NEW com.sct.descubriendoturuta.model.APIUsuario(r.id, r.genero) from Usuario r order by r.id desc");
		return query.getResultList();
	}
}
