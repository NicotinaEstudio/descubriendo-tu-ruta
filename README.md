
README Descubriendo Tu Ruta
============

El presente proyecto es un prototipo funcional para la final del Reto **#DescubriendoTuRuta** y es desarrollado por [Nicotina Estudio](http://www.nicotinaestudio.com). 

##Descripción
**Descubriendo Tu Ruta** tiene por objetivo incrementar la funcionalidad de la aplicación actual MAPPIR y darle más visibilidad haciendola totalmente social.

##Tecnología

La APP móvil de este prototipo está desarrollada para iPhone (IOS 7 y 8). Utilizamos Ccocoapods como manejador de dependencias para manter el código más limpio y fácil de utilizar.

En su Backend **Descubriendo Tu Ruta** está desarrollado con Java utilizando el framework Spring MVC, una base de datos PostgreSQL, se utliza Heroku como servidor de aplicaciones, Amazon S3 para el alamacenamiento de las fotografías y video y Amazon SNS para las notificaciones PUSH.

##Funcionamiento
**Descubriendo Tu Ruta** utiliza Facebook como medio para llegar a los usurios potenciales mediante la creación de rutas en las que puedan invitar a sus amigos de Facebook, utiliza un sistema de calificación de rutas y usuarios para fomentar la participación, a los usuarios se les dan unas insignias por activades especificas realizadas como crear su primera ruta, crear una ruta compartida con amigos, ser el usuario más valioso.

Se manejan perfiles especiales para las dependencias que requieren rutas especificas como seria el caso de SECTUR que le permita crear rutas para fomentar el turismo.

##Dependencias
**IOS**
- AFNetworking
- AWSiOSSDKv2
- AWSCognitoSync
- SWRevealViewController 2.3.0
- BlurryModalSegue
- Google-Maps-iOS-SDK

**BACKEND**
- Spring MVC 4.1.1.RELEASE
- Hibernate 3.6.10.Final
- PostgreSQL 9.1-901-1.jdbc4
- jackson JSON processor 2.3.0
- Amazon AWS 1.9.2
- Zxing
- Maven

##Instalación / Configuración 
La forma más fácil es importa este repositorio desde el IDE eclipse mediante el plugin de heroku disponible en la siguiente URL: [http://eclipse-plugin.herokuapp.com](http://eclipse-plugin.herokuapp.com)

Para publicar el sitio en Heroku:
Como todas las dependencias se encuentran en el archívo pom.xml solo se requieren dos pasos para publicar la APP en Heroku.
- Crear una APP en heroku ($heroku create)
- Publicar hacia la APP ($git push heroku master)

##Screenshots
![alt tag](https://s3.amazonaws.com/nicotina-estudio/retos-publicos/dtr-2.jpg)
![alt tag](https://s3.amazonaws.com/nicotina-estudio/retos-publicos/dtr-1.jpg)
![alt tag](https://s3.amazonaws.com/nicotina-estudio/retos-publicos/dtr-3.jpg)

##Demo
- [http://descubriendo-tu-ruta.herokuapp.com](http://descubriendo-tu-ruta.herokuapp.com)

##¿Preguntas o problemas? 
Mantenemos la conversación del proyecto en nuestra página de problemas [issues] (https://github.com/NicotinaEstudio/descubriendo-tu-ruta/issues). Si usted tiene cualquier otra pregunta, nos puede contactar por correo <soporte@nicotinaestudio.mx>.

##Contribuye
Para contribuir en el proyecto **Catalogarte** haga click en el siguiente enlace ([Contribuir](#))

##Empresa

**Nuestra Misión**

> *Solucionar de forma creativa e innovadora problemas sociales y empresariales que sobrepasen sus expectativas y generen experiencias excepcionales. [Nicotina Estudio](http://www.nicotinaestudio.com)*

##Licencia

Copyright 2014 Nicotina Estudio

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
