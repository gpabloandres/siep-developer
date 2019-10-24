
servicio_grafana() {
   title "Ejecutando $GRAFANA"
 
   sudo docker run -itd --name $GRAFANA \
    --network=$NETWORK \
    -p $GRAFANA_PORT \
   $GRAFANA_IMG
}