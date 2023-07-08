#!/usr/bin/env bash

dir="$HOME/.config/polybar"
dir2="$HOME/.config/polybar/pwidgets"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

	# Launch the bar
	if [[ "$style" == "hack" || "$style" == "cuts" ]]; then
		polybar -q top -c "$dir/$style/config.ini" &
		polybar -q bottom -c "$dir/$style/config.ini" &
	elif [[ "$style" == "pwidgets" ]]; then
		bash "$dir"/pwidgets/launch.sh --main &
	elif [[ "$style" == "hdmi" ]]; then
    polybar -c "$dir/docky/config.ini" & 
    polybar -q primary -c $dir2/main.ini &
	  polybar -q secondary -c $dir2/main.ini &
	  polybar -q bottom -c $dir2/main.ini &
    polybar -q top -c $dir2/main.ini &
	else
		polybar -q main -c "$dir/$style/config.ini" &	
	fi
}

if [[ "$1" == "--material" ]]; then
	style="material"
	launch_bar

elif [[ "$1" == "--shades" ]]; then
	style="shades"
	launch_bar

elif [[ "$1" == "--hack" ]]; then
	style="hack"
	launch_bar

elif [[ "$1" == "--docky" ]]; then
	style="docky"
	launch_bar

elif [[ "$1" == "--cuts" ]]; then
	style="cuts"
	launch_bar

elif [[ "$1" == "--shapes" ]]; then
	style="shapes"
	launch_bar

elif [[ "$1" == "--grayblocks" ]]; then
	style="grayblocks"
	launch_bar

elif [[ "$1" == "--blocks" ]]; then
	style="blocks"
	launch_bar

elif [[ "$1" == "--colorblocks" ]]; then
	style="colorblocks"
	launch_bar

elif [[ "$1" == "--forest" ]]; then
	style="forest"
	launch_bar

elif [[ "$1" == "--pwidgets" ]]; then
	style="pwidgets"
	launch_bar

elif [[ "$1" == "--panels" ]]; then
	style="panels"
	launch_bar

elif [[ "$1" == "--hdmi" ]]; then
	style="hdmi"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
	--blocks    --colorblocks    --cuts      --docky
	--forest    --grayblocks     --hack      --material
	--panels    --pwidgets       --shades    --shapes
	--hdmi
	EOF
fi
