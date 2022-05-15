#/bin/bash
name=hero
exit=1
while getopts "en:" optname
do
	case $optname in
		"e")
			exit=0
		;;
		"n")
			name=$OPTARG
		;;
		"?")
			echo "unknow arg in arg list!"
			exit 4
		;;
		":")
			echo "lost an expected argument"
			exit 3
		;;
		"*")  echo "unknow error when parse params"
			exit 2
		;;
	esac
done
xhost +
docker container start $name || docker container restart $name
if [ exit ]; then
	docker attach $name 
else
	docker exec -it $name
fi
