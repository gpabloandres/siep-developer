servicio_siep_admin() {
   title "Ejecutando $SIEP_ADMIN"

   sudo docker run -itd --name $SIEP_ADMIN \
    -e SIEP_API_GW_INGRESS="http://localhost:7777" \
    --network=$NETWORK \
    -p $SIEP_ADMIN_PORT \
	$SIEP_ADMIN_IMG
}
