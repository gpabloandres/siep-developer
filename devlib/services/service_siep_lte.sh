
servicio_siep_lte() {
   MOUNT_VOLUME=$SIEP_LTE_MOUNT

   title "Ejecutando $SIEP_LTE - Montar volumen: $MOUNT_VOLUME"

   MOUNT_COMMAND=""
   if [ $MOUNT_VOLUME == 1 ]
	then
	   MOUNT_COMMAND="-v ${CURRENT_DIR}/forks/siep-lte:/var/www/html"
	pwd
   fi

   sudo docker run -itd --name $SIEP_LTE \
    -e SIEP_LARAVEL_API=$SIEP_LARAVEL_API \
    -e SIEP_AUTH_API=$SIEP_AUTH_API \
    -e SIEP_API_GW_INGRESS="http://localhost:7777" \
    -e APP_SSL=false \
    --network=$NETWORK \
    -p $SIEP_LTE_PORT \
	$MOUNT_COMMAND \
	$SIEP_LTE_IMG

   if [ $MOUNT_VOLUME == 1 ]
	then
	   echo "Ejecutar algun comando...";
	   sudo docker exec -it $SIEP_LTE sh -c "composer install --ignore-platform-reqs && chmod 777 storage -R"
   fi
}
