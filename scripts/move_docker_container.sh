#/bin/bash
name=hero
kill_all=0
while getopts "n:a" optname
do
	case $optname in
	"n")
		name=$OPTARG
		;;
	"a")
		kill_all="1"
		;;
	"?")
		echo "unknow arg in arg list!"
		exit 4
		;;
	":")
		echo "lost an expected argument"
		exit 3
		;;
	"*")  
		echo "unknow error when parse params"
		exit 2
		;;
	esac
done
if [ $kill_all -eq 0 ]; then
docker container kill $name 
docker container rm $name
else
	docker container prune
fi
