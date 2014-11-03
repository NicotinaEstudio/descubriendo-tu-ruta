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

package com.sct.descubriendoturuta.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Transient;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;


@Entity
public class Ruta {

	
    @Id
    @GeneratedValue
    private Integer id;
        
    @ManyToOne(optional=false)
    @JoinColumn(name="usuarioId")
    private Usuario usuario;
    
    @LazyCollection(LazyCollectionOption.FALSE)
    @OneToMany(mappedBy="ruta", cascade = CascadeType.ALL,
			targetEntity=RutaPoi.class)
	private List<RutaPoi> pois;
    
    @LazyCollection(LazyCollectionOption.FALSE)
    @OneToMany(mappedBy="ruta", cascade = CascadeType.ALL,
			targetEntity=Foto.class)
	private List<Foto> fotos;
       
    private String nombre;
    
    private boolean esPublica;
    
    private boolean esActiva;
    
    private String resena;
    
    @Transient
    private Double popularidasd;

	public boolean getEsPublica() {
		return esPublica;
	}

	public void setEsPublica(boolean esPublica) {
		this.esPublica = esPublica;
	}

	public boolean getEsActiva() {
		return esActiva;
	}

	public void setEsActiva(boolean esActiva) {
		this.esActiva = esActiva;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public List<RutaPoi> getPois() {
		return pois;
	}

	public void setPois(List<RutaPoi> pois) {
		this.pois = pois;
	}
	
	public List<Foto> getFotos() {
		return fotos;
	}

	public void setFotos(List<Foto> fotos) {
		this.fotos = fotos;
	}

	public String getResena() {
		return resena;
	}

	public void setResena(String resena) {
		this.resena = resena;
	}

	public Double getPopularidasd() {
		return popularidasd;
	}

	public void setPopularidasd(Double popularidasd) {
		this.popularidasd = popularidasd;
	}
    
}
