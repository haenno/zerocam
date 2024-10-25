# run python script ./save_image.py to get image from camera

THIS_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
python3 $THIS_SCRIPT_DIR/save_image.py

# copy new_image.jpg to /var/www/html/image.jpg
sudo cp -r $THIS_SCRIPT_DIR/new_image.jpg /var/www/html/image.jpg

# copy again with timestamp to archive
now=$(date "+%F_%H-%M-%S")
sudo cp -r $THIS_SCRIPT_DIR/new_image.jpg /var/www/html/image_$now.jpg
