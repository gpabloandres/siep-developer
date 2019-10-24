#!/usr/bin/env bash

# set -x
set -eo pipefail

CURRENT_PWD=$(pwd)
CURRENT_DIR=${CURRENT_PWD} #$(dirname "$0")
LIB_DIR=${CURRENT_DIR}/devlib
SERVICE_DIR=${LIB_DIR}/services

source ${CURRENT_DIR}/default.conf
source ${LIB_DIR}/core.sh

source ${SERVICE_DIR}/service_api_gw.sh
source ${SERVICE_DIR}/service_auth_api.sh
source ${SERVICE_DIR}/service_laravel_api.sh
source ${SERVICE_DIR}/service_siep_admin.sh
source ${SERVICE_DIR}/service_siep_db.sh
source ${SERVICE_DIR}/service_siep_pwa.sh
source ${SERVICE_DIR}/service_siep_cake.sh
source ${SERVICE_DIR}/service_siep_lte.sh

source ${SERVICE_DIR}/service_grafana.sh
source ${SERVICE_DIR}/service_graphite.sh

prettyConf () {
	title "SIEP DEVELOPER MENU"
	echo -e "${GREEN} Configuracion en default.conf"
	echo -e "${NC} PUERTO \t IMAGEN"
	dockerimg $SIEP_LTE_IMG $SIEP_LTE_PORT $SIEP_LTE_MOUNT $SIEP_LTE_RUN
	dockerimg $SIEP_CAKE_IMG $SIEP_CAKE_PORT $SIEP_CAKE_MOUNT $SIEP_CAKE_RUN
	dockerimg $SIEP_AUTH_API_IMG $SIEP_AUTH_API_PORT $SIEP_AUTH_API_MOUNT $SIEP_AUTH_API_RUN
	dockerimg $SIEP_LARAVEL_API_IMG $SIEP_LARAVEL_API_PORT $SIEP_LARAVEL_API_MOUNT $SIEP_LARAVEL_API_RUN
	dockerimg $SIEP_API_GW_IMG $SIEP_API_GW_PORT $SIEP_API_GW_MOUNT $SIEP_API_GW_RUN
	dockerimg $SIEP_ADMIN_IMG $SIEP_ADMIN_PORT $SIEP_ADMIN_MOUNT $SIEP_ADMIN_RUN
	dockerimg $SIEP_PWA_IMG $SIEP_PWA_PORT $SIEP_PWA_MOUNT $SIEP_PWA_RUN
	dockerimg $DB_ADMIN_IMG $DB_ADMIN_PORT 0 1
	dockerimg $DB_IMG $DB_PORT 1 1

	dockerimg $GRAFANA_IMG $GRAFANA_PORT $GRAFANA_MOUNT $GRAFANA_RUN
	dockerimg $GRAPHITE_IMG $GRAPHITE_PORT $GRAPHITE_MOUNT $GRAPHITE_RUN
	echo -e "${NC}"
  echo -e "${BLUE} PATH ${CURRENT_PWD}"
	echo -e "${NC}"

}

docker_pull () {
	docker pull $SIEP_AUTH_API_IMG
	docker pull $SIEP_API_GW_IMG
	docker pull $SIEP_LARAVEL_API_IMG
	docker pull $SIEP_CAKE_IMG
	docker pull $SIEP_ADMIN_IMG
	docker pull $SIEP_PWA_IMG
	docker pull $SIEP_LTE_IMG;
}

eliminar_conenedores () {
   title "Contenedores (stop y remove)"
   try
   (
   	docker stop \
	$SIEP_ADMIN \
	$SIEP_PWA \
	$SIEP_AUTH_API \
	$SIEP_LARAVEL_API \
	$SIEP_API_GW \
	$SIEP_CAKE \
	$SIEP_LTE \
	$DB \
	$DB_ADMIN \
	$GRAFANA \
	$GRAPHITE
   )

   try
   (
   docker rm \
	$SIEP_ADMIN \
	$SIEP_PWA \
	$SIEP_AUTH_API \
	$SIEP_LARAVEL_API \
	$SIEP_API_GW \
	$SIEP_CAKE \
	$SIEP_LTE \
	$DB \
	$DB_ADMIN \
	$GRAFANA \
	$GRAPHITE
	)
} 

remove_current_install() {
  sudo rm -rf ${CURRENT_DIR}/siep
  sudo rm -rf ${CURRENT_DIR}/siep-lte
  sudo rm -rf ${CURRENT_DIR}/siep-admin
  sudo rm -rf ${CURRENT_DIR}/siep-pwa
  sudo rm -rf ${CURRENT_DIR}/apis
  mkdir ${CURRENT_DIR}/apis
}

download_forks() {
  # Cona repos
  cd ${CURRENT_DIR} && git clone https://github.com/${1}/siep.git
  cd ${CURRENT_DIR} && git clone https://github.com/${1}/siep-lte.git
  cd ${CURRENT_DIR} && git clone https://github.com/${1}/siep-admin.git
  cd ${CURRENT_DIR} && git clone https://github.com/${1}/siep-pwa.git
  cd ${CURRENT_DIR}/apis && git clone https://github.com/${1}/lumen-auth-api.git
  cd ${CURRENT_DIR}/apis && git clone https://github.com/${1}/node-http-proxy.git
  cd ${CURRENT_DIR}/apis && git clone https://github.com/${1}/LaravelApi.git
}

downloader () {
  # Limpia carpeta
  title 'Confirma eliminar todo, y realizar una instalacion nueva?: '
  read -p " (s/n)? " CONFIRMA_ELIMINACION_DE_FORKS

  if [ $CONFIRMA_ELIMINACION_DE_FORKS == "s" ]
  then
      title "Por favor ingrese su nombre de usuario en GITHUB"
      read -p " (Github user)? " GITHUB_USER
      remove_current_install
      download_forks $GITHUB_USER
      menu
    else
      if [ $CONFIRMA_ELIMINACION_DE_FORKS != "n" ]
      then
        echo "Opcion invalida"
        downloader
      fi
   fi
}

orquestar () {
   # Al orquestar se limpian siempre todos los contenedores
   try
   (
    eliminar_conenedores
   )

   title "Iniciar Network"

   try
   (
    sudo docker network create -d bridge $NETWORK
   )

   title "Iniciando Orquestacion"

   servicio_db_admin
   servicio_db

   if [ $SIEP_API_GW_RUN == 1 ]
      then
	   servicio_siep_api_gw
   fi
   if [ $SIEP_AUTH_API_RUN == 1 ]
      then
      servicio_siep_auth_api
   fi
   if [ $SIEP_LARAVEL_API_RUN == 1 ]
      then
	   servicio_siep_laravel_api
   fi
   if [ $SIEP_CAKE_RUN == 1 ]
      then
	   servicio_siep_cake
   fi
   if [ $SIEP_LTE_RUN == 1 ]
      then
	   servicio_siep_lte
   fi
   if [ $SIEP_ADMIN_RUN == 1 ]
      then
	   servicio_siep_admin
   fi
   if [ $SIEP_PWA_RUN == 1 ]
      then
	   servicio_siep_pwa
   fi
   if [ $GRAFANA_RUN == 1 ]
      then
	   servicio_grafana
   fi
   if [ $GRAPHITE_RUN == 1 ]
      then
	   servicio_graphite
   fi
}

clear
menu
