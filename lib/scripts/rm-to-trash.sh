dest_dir="/home/enkai/.trash"
timestamp=$(date +"%Y%m%d_%H%M%S")

for file in "$@"; do
	if [ -e "$file" ]; then
		filename=$(basename "$file")
		new_name="${filename}_$timestamp"
		mv "$file" "$dest_dir/$new_name"
		echo "Moved $file to $dest_dir/$new_name."
	else
		echo "File $file not found."
	fi
done
