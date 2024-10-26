# run python script ./save_image.py to get image from camera
# add to crontab for every 1 minute
# */1 * * * * ~/zerocam/get-image.sh >> ~/zerocam/get-image.log 2>&1

THIS_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
python3 ~/zerocam/save_image.py

# copy new_image.jpg to /var/www/html/image.jpg
sudo cp -r ~/zerocam/new_image.jpg /var/www/html/image.jpg

# copy again with timestamp to archive
now=$(date "+%F_%H-%M-%S")
# create folder if not exist: /var/www/html/images/
sudo mkdir -p /var/www/html/images
sudo cp -r ~/zerocam/new_image.jpg /var/www/html/image_$now.jpg

# get last 100 log lines
tail -n 100 ~/zerocam/get-image.log >~/zerocam/imagelog.txt

# copy to /var/www/html/imagelog.txt
sudo cp -r ~/zerocam/imagelog.txt /var/www/html/imagelog.txt
