set -e

cd /mnt/etc/nixos/flakes

function set_root_passwd {
	echo $'\e[1;32mSet your root login password:\e[0m'
	while true; do
		read -s -p "Enter root password: " root_pass
		echo
		read -s -p "Confirm root password: " root_pass_confirm
		echo

		if [ "$root_pass" != "$root_pass_confirm" ]; then
			echo "Passwords do not match. Please try again."
		else
			echo "Password confirmed."
			root_passwd_hash=$(echo $root_pass | mkpasswd -m sha-512 -s 2>/dev/null)
			break
		fi
	done
}
function set_user_passwd {
	echo $'\e[1;32mSet your user login password:\e[0m'
	while true; do
		read -s -p "Enter user password: " user_pass
		echo
		read -s -p "Confirm user password: " user_pass_confirm
		echo

		if [ "$user_pass" != "$user_pass_confirm" ]; then
			echo "Passwords do not match. Please try again."
		else
			echo "Password confirmed."
			user_passwd_hash=$(echo $user_pass | mkpasswd -m sha-512 -s 2>/dev/null)
			break
		fi
	done
}
while true; do
	echo "The partition is now complete, need to set password for the root? (y/n)"
	read root_passwd_choice
	if [ "$root_passwd_choice" = "y" ]; then
		set_root_passwd
		for hosts_profiles_dir in ./hosts/profiles/*; do
			sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$root_passwd_hash\";" ./hosts/profiles/"$hosts_profiles_dir"/password/host.nix
		done
	elif [ "$root_passwd_choice" = "n" ]; then
		break
	else
		echo "Invalid input, please try again."
	fi
done

while true; do
	echo "please select the device you wish to install:"
	echo "1. ltp-zbook-nix"
	echo "2. tower-qtj1-nix"
	read -p $'\e[1;32mEnter your choice(number): \e[0m' -r device

	case $device in
	1)
		set_user_passwd
		sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$user_passwd_hash\";" ./hosts/profiles/ltp-zbook-nix/password/home.nix
		nixos-install --no-root-passwd --flake .#ltp-zbook-nix
		break
		;;
	2)
		set_user_passwd
		sed -i "/initialHashedPassword/c\ \ \ \ initialHashedPassword\ =\ \"$user_passwd_hash\";" ./hosts/profiles/tower-qtj1-nix/password/home.nix
		nixos-install --no-root-passwd --flake .#tower-qtj1-nix
		break
		;;
	*)
		echo "Invalid choice, please try again."
		;;
	esac
done
