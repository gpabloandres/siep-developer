
servicio_graphite() {
   title "Ejecutando $GRAPHITE"
 
   sudo docker run -itd --name $GRAPHITE \
    --network=$NETWORK \
    -p 3002:80 \
    -p 3003:8080 \
    -p 2003-2004:2003-2004 \
    -p 2023-2024:2023-2024 \
    -p 8125:8125/udp \
    -p 8126:8126 \
   $GRAPHITE_IMG
}