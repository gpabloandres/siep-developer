
servicio_siep_auth_api() {
   MOUNT_VOLUME=$SIEP_AUTH_API_MOUNT
   title "Ejecutando $SIEP_AUTH_API - Montar volumen: $MOUNT_VOLUME"

   MOUNT_COMMAND=""
   if [ $MOUNT_VOLUME == 1 ]
	then
	   echo -e "MONTANDO VOLUMEN"
	   MOUNT_COMMAND="-v ${CURRENT_DIR}/apis/lumen-auth-api:/var/www/html"
	pwd
   fi
 
   sudo docker run -itd --name $SIEP_AUTH_API \
    -e DB_HOST=$DB \
    -e DB_DATABASE=$DB_DATABASE \
    -e DB_USERNAME=$DB_USERNAME \
    -e DB_PASSWORD=$DB_PASSWORD \
    --network=$NETWORK \
    -p $SIEP_AUTH_API_PORT \
	$MOUNT_COMMAND \
	$SIEP_AUTH_API_IMG

   if [ $MOUNT_VOLUME == 1 ]
	then
	   sudo docker exec -it $SIEP_AUTH_API sh -c "composer install && chmod 777 storage/ -R"
	pwd
   fi
}