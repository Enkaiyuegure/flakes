set -e

common_dir="$FLAKE_ROOT/lib/disko_layout"

function ask_edit {
	while true; do
		echo -n "Would you like to edit this layout? (y/n): "
		read choice
		if [ "$choice" = "y" ]; then
			nvim $partition_layout
			break
		elif [ "$choice" = "n" ]; then
			break
		else
			echo "Invalid input, please try again."
		fi
	done
}
function review_and_edit {
	clear
	{
		echo -e "\e[42mReviewing the partition layout with 'less'\e[0m"
		cat "$partition_layout"
	} | less

	while true; do
		echo -n "Would you like to edit this layout again? (y/n): "
		read edit_choice
		if [ "$edit_choice" = "y" ]; then
			nvim "$partition_layout"
			break
		elif [ "$edit_choice" = "n" ]; then
			break
		else
			echo "Invalid input, please try again."
		fi
	done
}

# Select the disk partition layout and edit it
while true; do
	echo "Please select a disk partition layout:"
	echo "1. ltp-zbook-nix"
	echo "2. tower-qtj1-nix"
	echo "3. router-n100-nix"
	read -p $'\e[1;32mEnter your choice(number): \e[0m' choice

	case $choice in
	1)
		partition_layout="$common_dir/ltp-zbook-nix.nix"
		hostName="ltp-zbook-nix"
		ask_edit
		review_and_edit
		break
		;;
	2)
		partition_layout="$common_dir/tower-qtj1-nix.nix"
		hostName="tower-qtj1-nix"
		ask_edit
		review_and_edit
		break
		;;
	3)
		partition_layout="$common_dir/router-n100-nix.nix"
		hostName="router-n100-nix"
		ask_edit
		review_and_edit
		break
		;;
	*)
		echo "Invalid choice, please try again."
		;;
	esac
done

nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode zap_create_mount "$partition_layout"

mkdir -p /mnt/etc/nixos
mkdir -p /mnt/persist/etc/nixos
mount -o bind /mnt/persist/etc/nixos /mnt/etc/nixos
nixos-generate-config --no-filesystems --root /mnt
cd /mnt/etc/nixos
cp hardware-configuration.nix "$FLAKE_ROOT"/hosts/profiles/"$hostName"/hardware-configuration.nix

cp -r "$FLAKE_ROOT" /mnt/etc/nixos/
lsblk
