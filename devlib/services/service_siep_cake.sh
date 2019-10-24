
servicio_siep_cake() {
   MOUNT_VOLUME=$SIEP_CAKE_MOUNT

   title "Ejecutando $SIEP_CAKE - Montar volumen: $MOUNT_VOLUME"

   MOUNT_COMMAND=""
   if [ $MOUNT_VOLUME == 1 ]
	then
	   MOUNT_COMMAND="-v ${CURRENT_DIR}/siep:/var/www/html"
	pwd
   fi

   sudo docker run -itd --name $SIEP_CAKE \
    -e MYSQL_HOST=$DB \
    -e CAKEPHP_DEBUG=$SIEP_CAKE_DEBUGMODE \
    -e SIEP_LARAVEL_API=$SIEP_LARAVEL_API \
    -e SIEP_AUTH_API=$SIEP_AUTH_API \
    -e HOSTAPI=$SIEP_LARAVEL_API \
    -e SIEP_API_GW_INGRESS="http://localhost:7777" \
    -e XHOSTCAKE=$SIEP_CAKE_XHOSTCAKE \
    --network=$NETWORK \
    -p $SIEP_CAKE_PORT \
	$MOUNT_COMMAND \
	$SIEP_CAKE_IMG

   if [ $MOUNT_VOLUME == 1 ]
	then

	   sudo docker exec -it $SIEP_CAKE sh -c "mkdir -p /var/www/html/tmp && mkdir -p /var/www/html/tmp/cache && mkdir -p /var/www/html/tmp/cache/persistent && mkdir -p /var/www/html/tmp/cache/models && mkdir -p /var/www/html/tmp/logs && chmod 777 /var/www/html/tmp -R"
	   sudo docker exec -it $SIEP_CAKE sh -c "composer install --ignore-platform-reqs"
   fi
}
