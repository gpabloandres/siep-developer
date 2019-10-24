servicio_db() {
   title "Ejecutando $DB"

   try
   (
    sudo docker volume create $DB_VOLUME
   )  

   sudo docker run -itd --name $DB \
	--network=$NETWORK \
	-p $DB_PORT \
	-e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASSWORD \
	-e MYSQL_DATABASE=$DB_DATABASE \
	-e MYSQL_USER=$DB_USERNAME \
	-e MYSQL_PASSWORD=$DB_PASSWORD \
	-v ${CURRENT_DIR}/dump:/home \
	--mount source=$DB_VOLUME,target=/var/lib/mysql \
 	$DB_IMG
}

servicio_db_admin() {
   title "Ejecutando $DB_ADMIN"
   sudo docker run -itd --name $DB_ADMIN \
    --network=$NETWORK \
    -p $DB_ADMIN_PORT \
	$DB_ADMIN_IMG
}

service_db_import() {
  #title 'Elimino de forma manual la base de datos actual?: '
  #read -p " (s/n)? " CONFIRMA_ELIMINACION_DB

  #if [ $CONFIRMA_ELIMINACION_DB == "s" ]
  #then
      echo "Ingresar clave de DB"
      sudo  docker exec -it $DB bash -c "mysql -u root -p -e 'DROP DATABASE IF EXISTS siep;CREATE DATABASE siep;'"
      sudo  docker exec -it $DB bash -c "cd /home && mysql -u root -p siep < siep.sql"
      menu
  #  else
  #    if [ $CONFIRMA_ELIMINACION_DB != "n" ]
  #    then
  #      echo "Opcion invalida"
  #      service_db_import
  #    fi
  # fi
}
