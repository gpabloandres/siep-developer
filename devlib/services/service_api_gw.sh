
servicio_siep_api_gw() {
   MOUNT_VOLUME=$SIEP_API_GW_MOUNT
   title "Ejecutando $SIEP_API_GW - Montar volumen: $MOUNT_VOLUME"

   MOUNT_COMMAND=""
   if [ $MOUNT_VOLUME == 1 ]
	then
	   cd ${CURRENT_DIR}/apis/node-http-proxy/app && npm install
	   MOUNT_COMMAND="-v ${CURRENT_DIR}/apis/node-http-proxy/app:/siep-gw"
	pwd
   fi
   sudo docker run -itd --name $SIEP_API_GW \
	-e SIEP_AUTH_API="http://$SIEP_AUTH_API" \
	-e SIEP_LARAVEL_API="http://$SIEP_LARAVEL_API" \
	--network=$NETWORK \
	-p $SIEP_API_GW_PORT \
	$MOUNT_COMMAND \
	$SIEP_API_GW_IMG
}