# SIEP-DEVELOPER

### Requisitos
  - git
  - docker (testeado en v17.09.0-ce)

#### Crear Forks de los siguientes repos

| Fork | Repo |
| ------ | ------ |
| LaravelApi | https://github.com/MaTiUs77/LaravelApi |
| node-http-proxy | https://github.com/MaTiUs77/node-http-proxy |
| lumen-auth-api | https://github.com/MaTiUs77/lumen-auth-api |
| siep-admin | https://github.com/MaTiUs77/siep-admin |
| siep | https://github.com/decyt-tdf/siep |

### Instalación

Luego de tener los forks generados ejecutar
```sh
$ ./menu.sh
--------------------------------------------------
 SIEP DEVELOPER MENU 
--------------------------------------------------
1) Instalar		  4) Iniciar ambiente	    7) Salir
2) Download Forks	  5) Actualizar imagenes
3) Importar DB		  6) Eliminar contenedores
Seleccione una opcion:
```

### Opciones
  1) Descarga las imagenes de docker hub, inicia contenedores, monta volumenes (solo si se realizo previamente la opcion 2)
  2) Clona los repo (solo si se realizo el fork previamente)
  3) Importa la base de datos, es necesario guardar la siep.sql en la carpeta dump/
  4) Inicia los contenedores segun la configuracion de la opcion 1 (con o sin volumenes)
  5) Actualiza las imagenes desde docker hub
  6) Elimina los contenedores (la opcion 1 tambien lo hace)
