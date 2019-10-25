
servicio_siep_laravel_api() {
   MOUNT_VOLUME=$SIEP_LARAVEL_API_MOUNT
   title "Ejecutando $SIEP_LARAVEL_API - Montar volumen: $MOUNT_VOLUME"

   MOUNT_COMMAND=""
   if [ $MOUNT_VOLUME == 1 ]
	then
	   MOUNT_COMMAND="-v ${CURRENT_DIR}/forks/siep-laravel-api:/var/www/html"
	pwd
   fi
 
   sudo docker run -itd --name $SIEP_LARAVEL_API \
    -e SIEP_AUTH_API="http://$SIEP_AUTH_API" \
    -e SIEP_LARAVEL_API="http://$SIEP_LARAVEL_API" \
    -e SIEP_API_GW_INGRESS="http://localhost:7777" \
    -e CACHE_DRIVER="file" \
    -e DB_HOST=$DB \
    -e DB_DATABASE=$DB_DATABASE \
    -e DB_USERNAME=$DB_USERNAME \
    -e DB_PASSWORD=$DB_PASSWORD \
    --network=$NETWORK \
    -p $SIEP_LARAVEL_API_PORT \
	$MOUNT_COMMAND \
	$SIEP_LARAVEL_API_IMG

   if [ $MOUNT_VOLUME == 1 ]
	then
	   sudo docker exec -it $SIEP_LARAVEL_API sh -c "composer install && chmod 777 storage/ -R && php artisan migrate"
	pwd
   fi
}
