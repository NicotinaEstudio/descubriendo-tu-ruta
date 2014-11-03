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

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;


@Entity
public class Foto {

    @Id
    @GeneratedValue
    private Integer id;
    private String usuarioId;
    @ManyToOne(optional=false)
    @JoinColumn(name="rutaId")
    private Ruta ruta;
    private String foto;
    private boolean esActiva;


    public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getUsuarioID() {
		return usuarioId;
	}

	public void setUsuario(String usuarioId) {
		this.usuarioId = usuarioId;
	}
	
	public String getFoto() {
		return foto;
	}
	
	public void setRuta(Ruta ruta) {
		this.ruta = ruta;
	}
	
	public Ruta getRuta() {
		return ruta;
	}

	public void setFoto(String foto) {
		this.foto = foto;
	}
	
	public boolean getEsActiva() {
		return esActiva;
	}

	public void setEsActiva(boolean esActiva) {
		this.esActiva = esActiva;
	}	
}