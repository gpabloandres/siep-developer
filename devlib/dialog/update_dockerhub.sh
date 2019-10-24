DOCKER_HUB_TOTAL=0
DOCKER_HUB_PROGRESS=0
DOCKER_HUB_INC=0

update_backend()
{
    let "DOCKER_HUB_TOTAL+=3"
    do_pull $SIEP_API_GW_IMG
    do_pull $SIEP_AUTH_API_IMG
    do_pull $SIEP_LARAVEL_API_IMG
}

update_frontend() {
    let "DOCKER_HUB_TOTAL+=4"
    do_pull $SIEP_CAKE_IMG
    do_pull $SIEP_LTE_IMG
    do_pull $SIEP_ADMIN_IMG
    do_pull $SIEP_PWA_IMG
}

update_dockerhub()
{
    update_backend
    update_frontend

    dialog --title 'Pull DockerHub' --msgbox 'Operacion completa' 6 30

    home
}

do_pull() 
{
    echo $DOCKER_HUB_PROGRESS | dialog --gauge "$DOCKER_HUB_INC/$DOCKER_HUB_TOTAL DockerHub PULL $1" 10 70 0
    docker pull $1
    let "DOCKER_HUB_INC+=1"
    DOCKER_HUB_PROGRESS=$(( 100*($DOCKER_HUB_INC)/$DOCKER_HUB_TOTAL ))
}
