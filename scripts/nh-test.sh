#!/usr/bin/env bash

function traverseArray() {
    local array=("$@")
    for i in "${!array[@]}"; do
        echo "$((i + 1)). ${array[i]}"
    done
}

################
# system_types #
################
system_types=("desktop" "server")

echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
echo "Please select the system type:"
traverseArray "${system_types[@]}"
read -p "Enter your choice(number):" system_choice
if [[ "${system_choice}" > "${#system_types[@]}" ]]; then
    echo "Invalid choice"
    exit 1
fi
system_selected=${system_types[$((system_choice - 1))]}

if [ "${system_selected}" == "desktop" ]; then
    hosts=("dashao")
    options=("xorg" "wayland")
    options_name="graphics protocol"
elif [ "${system_selected}" == "server" ]; then
    hosts=("")
    options=("homelab" "cloud")
    options_name="server location"
fi

############
# hostname #
############
echo "========================================"
echo "Please select the hostname:"
traverseArray "${hosts[@]}"
read -p "Enter your choice(number):" host_choice
if [[ "${host_choice}" > "${#hosts[@]}" ]]; then
    echo "Invalid choice"
    exit 1
fi
host_selected=${hosts[$((host_choice - 1))]}

###########
# options #
###########
echo "========================================"
echo "Please select the ${options_name}:"
traverseArray "${options[@]}"
read -p "Enter your choice(number):" option_choice
if [[ "${option_choice}" > "${#options[@]}" ]]; then
    echo "Invalid choice"
    exit 1
fi
option_selected=${options[$((option_choice - 1))]}

if [ "$system_selected" == "desktop" ]; then
    detailed_options_name="desktop environment"
    if [[ "$option_selected" == "xorg" ]]; then
        detailed_options=("gnome" "kde" "none")
    elif [[ "$option_selected" == "wayland" ]]; then
        detailed_options=("gnome" "kde" "none")
    fi
elif [ "$system_selected" == "server" ]; then
    detailed_options_name="function position"
    if [[ "$option_selected" == "homelab" ]]; then
        detailed_options=("")
    elif [[ "$option_selected" == "cloud" ]]; then
        detailed_options=("")
    fi
fi

###########
# details #
###########
echo "========================================"
echo "Please select the ${detailed_options_name}:"
traverseArray "${detailed_options[@]}"
read -p "Enter your choice(number):" detailed_choice
if [[ "${detailed_choice}" > "${#detailed_options[@]}" ]]; then
    echo "Invalid choice"
    exit 1
fi
detailed_selected=${detailed_options[$((detailed_choice - 1))]}

if [ "$system_selected" == "desktop" ]; then
    if [[ "$option_selected" == "xorg" ]]; then
        if [[ "$detailed_selected" == "gnome" ]]; then
            wm_options=("mutter")
        elif [[ "$detailed_selected" == "kde" ]]; then
            wm_options=("kwin")
        elif [[ "$detailed_selected" == "none" ]]; then
            wm_options=("i3")
        fi
    elif [[ "$option_selected" == "wayland" ]]; then
        if [[ "$detailed_selected" == "gnome" ]]; then
            wm_options=("mutter")
        elif [[ "$detailed_selected" == "kde" ]]; then
            wm_options=("kwin")
        elif [[ "$detailed_selected" == "none" ]]; then
            wm_options=("hyprland" "gamescope")
        fi
    fi

    echo "========================================"
    echo "Please select the window manager:"
    traverseArray "${wm_options[@]}"
    read -p "Enter your choice(number):" wm_choice
    if [[ "${wm_choice}" > "${#wm_options[@]}" ]]; then
        echo "Invalid choice"
        exit 1
    fi
    wm_selected=${wm_options[$((wm_choice - 1))]%%:*}
else
    wm_selected=""
fi

command="nh os test -H $system_selected-$host_selected-$option_selected-$detailed_selected"
if [ -n "$wm_selected" ]; then
    command="$command-$wm_selected"
fi

echo "########################################"
echo "$command"
echo "########################################"
echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
read -p "exec?(y/N)" whether_exec

if [[ "$whether_exec" == "y" ]]; then
    eval "$command"
    exit 0
else
    exit 1
fi
