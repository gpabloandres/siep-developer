#!/usr/bin/env bash

# set -x
set -eo pipefail

CURRENT_DIR=$(dirname "$0")
LIB_DIR=${CURRENT_DIR}/devlib
DIALOG_DIR=${LIB_DIR}/dialog
SERVICE_DIR=${LIB_DIR}/services

source ${CURRENT_DIR}/default.conf
source ${LIB_DIR}/core.sh

source ${DIALOG_DIR}/update_dockerhub.sh

source ${SERVICE_DIR}/service_api_gw.sh
source ${SERVICE_DIR}/service_auth_api.sh
source ${SERVICE_DIR}/service_laravel_api.sh
source ${SERVICE_DIR}/service_siep_admin.sh
source ${SERVICE_DIR}/service_siep_db.sh
source ${SERVICE_DIR}/service_siep_pwa.sh
source ${SERVICE_DIR}/service_siep_cake.sh

source ${SERVICE_DIR}/service_grafana.sh
source ${SERVICE_DIR}/service_graphite.sh

home()
{
    cmd=(dialog --menu "SIEP - Desarrollador:" 22 76 10)
    options=(
        1 "Orquestar Imagenes"
        2 "Actualizar Imagenes (pull dockerhub)"
        3 "Descargar Forks"
        4 "Restaurar DB"
        5 "Configuracion"
        )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Orquestando imagenes"
                ;;
            2)
                update_dockerhub
                ;;
            3)
                echo "Descargando Forks"
                ;;
            4)
                echo "Restaurando DB"
                ;;
            5)
                echo "Configuracion"
                dialog_configuracion
                ;;
        esac
    done
}

dialog_configuracion()
{
    cmd=(dialog --separate-output --checklist "SIEP - Desarrollador:" 22 76 16)
    options=(1 "Montar CAKE" on
            2 "Montar PWA" off
            3 "Montar ADMIN" off
            4 "Montar API GATEWAY" on)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
        case $choice in
            1)
                echo "Montando CAKE"
                ;;
            2)
                echo "Montando PWA"
                ;;
            3)
                echo "Montando ADMIN"
                ;;
            4)
                echo "Montando API GATEWAY"
                ;;
        esac
    done

    home
}


home