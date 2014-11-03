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

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table (name="usuarios")
public class Usuario implements Serializable{

	@Id
	@GeneratedValue
	private Integer id;
	
	private String nombre;
	
	@OneToMany(mappedBy="usuario",
			fetch=FetchType.EAGER,
			targetEntity=Ruta.class)
	private List<Ruta> rutas;
	
	private String facebookId;	
	private String genero;
	private Integer esActivo;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date fechaDeAlta;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date fechaDeUltimoAcceso;
	
	private String edadRango;
	private String ubicacion;
	private Double latitud;
	private Double longitud;
	
	@Transient
	private Double puntos;	
	
	@LazyCollection(LazyCollectionOption.FALSE)
    @OneToMany(mappedBy="usuario", cascade = CascadeType.ALL,
			targetEntity=Insignia.class)
	private List<Insignia> insignias;
		
	public String getFacebookId() {
		return facebookId;
	}

	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}

	public String getGenero() {
		return genero;
	}

	public void setGenero(String genero) {
		this.genero = genero;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int isEsActivo() {
		return esActivo;
	}

	public void setEsActivo(int esActivo) {
		this.esActivo = esActivo;
	}

	public Date getFechaDeAlta() {
		return fechaDeAlta;
	}

	public void setFechaDeAlta(Date fechaDeAlta) {
		this.fechaDeAlta = fechaDeAlta;
	}

	public Date getFechaDeUltimoAcceso() {
		return fechaDeUltimoAcceso;
	}

	public void setFechaDeUltimoAcceso(Date fechaDeUltimoAcceso) {
		this.fechaDeUltimoAcceso = fechaDeUltimoAcceso;
	}

	public String getEdadRango() {
		return edadRango;
	}

	public void setEdadRango(String edadRango) {
		this.edadRango = edadRango;
	}

	public String getUbicacion() {
		return ubicacion;
	}

	public void setUbicacion(String ubicacion) {
		this.ubicacion = ubicacion;
	}

	@Transient
	public String getNombre() {
		return nombre;
	}

	@Transient
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public List<Ruta> getRutas() {
		return rutas;
	}

	public void setRutas(List<Ruta> rutas) {
		this.rutas = rutas;
	}

//	public Ruta getRuta() {
//		return ruta;
//	}
//
//	public void setRuta(Ruta ruta) {
//		this.ruta = ruta;
//	}
	
	//private String 
	
	@Transient
	public Double getLatitud() {
		return latitud;
	}

	@Transient
	public void setLatitud(Double latitud) {
		this.latitud = latitud;
	}
	
	@Transient
	public Double getLongitud() {
		return longitud;
	}

	@Transient
	public void setLongitud(Double longitud) {
		this.longitud = longitud;
	}

	public List<Insignia> getInsignias() {
		return insignias;
	}

	public void setInsignias(List<Insignia> insignias) {
		this.insignias = insignias;
	}
	
	public Double getPuntos() {
		return puntos;
	}

	public void setPuntos(Double puntos) {
		this.puntos = puntos;
	}
}
