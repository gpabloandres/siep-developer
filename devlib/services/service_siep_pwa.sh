
servicio_siep_pwa() {
   title "Ejecutando $SIEP_PWA"

   sudo docker run -itd --name $SIEP_PWA \
    -e SIEP_API_GW_INGRESS="http://localhost:7777" \
    --network=$NETWORK \
    -p $SIEP_PWA_PORT \
	$SIEP_PWA_IMG
}