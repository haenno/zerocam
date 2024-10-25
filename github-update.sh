#!/bin/bash
# quick script to update zerocam, install in cron with crontab -e and add the following line:
# */5 * * * * ~/zerocam/github-update.sh >> ~/zerocam/github-update.log 2>&1
# it checks if the remote git repo is newer than the local one and if so, it pulls the changes and restarts the containers

THIS_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $THIS_SCRIPT_DIR
now=$(date "+%F %H:%M:%S")
echo "$now --> Remote git repo quick check zerocam > Starting..."
git -C $THIS_SCRIPT_DIR fetch origin
if [ $(git -C $THIS_SCRIPT_DIR rev-list HEAD...origin/main --count) != 0 ]; then
    echo "$now --> Remote git repo quick check zerocam > Remote is newer > Start update..."

    git -C $THIS_SCRIPT_DIR reset --hard origin/main
    git -C $THIS_SCRIPT_DIR pull
    sudo chmod +x $THIS_SCRIPT_DIR/*.sh

    echo "$now --> Remote git repo quick check zerocam > Update done!"

    echo "$now --> After update work > Starting..."

    # copy ./html to /var/www/html
    sudo cp -r $THIS_SCRIPT_DIR/html/* /var/www/html/

    # copy ./html/placeholder.jpg to /var/www/html/image.jpg
    sudo cp -r $THIS_SCRIPT_DIR/html/placeholder.jpg /var/www/html/image.jpg

    # copy last 100 log lines to /var/www/html/log.txt
    sudo tail -n 100 $THIS_SCRIPT_DIR/github-update.log >/var/www/html/log.txt

    echo "$now --> After update work > done!"

else
    echo "$now --> Remote git repo quick check zerocam > Remote is same as local > Nothing to do!"
fi
echo "$now --> Remote git repo quick check zerocam > Finished!"
