#/bin/bash
name=hero
while getopts "p:n:" optname 
do
	case $optname in
		"p")
			if [ $OPTARG = "x86" ]; then
				platform="x86"
			elif [ -o $OPTARG = "arm" ]; then
				platform="armv8"
			else
				echo "unknow platform for arg '-p', it must be 'x86' or 'arm'."
				exit 1
			fi
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
		*)  echo "unknow error when parse params"
			exit 2
		;;
	esac
done

xhost +
docker run -v /home/$USER:/root/$USER --device /dev/dri:/dev/dri -v /tmp/.X11-unix:/tmp/.X11-unix  -e DISPLAY=unix$DISPLAY -e GDK_SCALE  -e GDK_DPI_SCALE --network host -it --name ${name}_${platform} zig175/hero2022_${platform} zsh
