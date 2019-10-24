title()
{
	#printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
	printf '%50s\n' | tr ' ' -
  	echo -e "${BLUE} $1 ${NC}${NC}"
	printf '%50s\n' | tr ' ' -
}

dockerimg()
{
	puerto=$(echo $2| cut -d':' -f 1)
        developer="${RED}latest"
	image=" ${YELLOW}$1"
        montar=""
	ejecutar=""
	if [ "$3" ]
	then
		if [ "$3" == 1 ]
        	then
        	   montar="mount"
		fi
        fi
	if [ "$4" ]
        then
                if [ "$4" == 1 ]
                then
                   ejecutar="run"
                fi
        fi

	echo -e "${NC} $puerto \t ${image/latest/$developer} ${PURPLE} $ejecutar ${GREEN} $montar"
}

try()
{
    [[ $- = *e* ]]; SAVED_OPT_E=$?
    set +e
}

menu () {
   prettyConf
	PS3="Seleccione una opcion: "
	options=("Orquestar" "Docker PULL" "Re/Instalar forks" "Importar DB" "Salir")
	select opt in "${options[@]}"
	do
	    case $opt in
		"Re/Instalar forks")
		    downloader
		    ;;
		"Orquestar")
		    orquestar
		    ;;
		"Importar DB")
		    service_db_import
		    ;;
		"Docker PULL")
		    docker_pull
		    ;;
		"Salir")
		    break
		    ;;
		*) echo "La opcion $REPLY es invalida";;
	    esac
	done
} 
