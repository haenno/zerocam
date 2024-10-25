#!/bin/bash
# quick script to update zerocam, install in cron with crontab -e and add the following line:
# */5 * * * * /-your-path-to-this-script-/github-update.sh >> /var/log/github-update.log 2>&1
# it checks if the remote git repo is newer than the local one and if so, it pulls the changes and restarts the containers

HAENNO_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd $HAENNO_SCRIPT_DIR
now=$(date "+%F %H:%M:%S")
echo "$now --> Remote git repo quick check zerocam > Starting..."
git -C $HAENNO_SCRIPT_DIR fetch origin
if [ $(git -C $HAENNO_SCRIPT_DIR rev-list HEAD...origin/main --count) != 0 ]; then
    echo "$now --> Remote git repo quick check zerocam > Remote is newer > Start update..."

    git -C $HAENNO_SCRIPT_DIR reset --hard origin/main
    git -C $HAENNO_SCRIPT_DIR pull
    sudo chmod +x $HAENNO_SCRIPT_DIR/*.sh

    echo "$now --> Remote git repo quick check zerocam > Update done!"

    echo "$now --> After update work > Starting..."

    # copy ./html to /var/www/html
    sudo cp -r $HAENNO_SCRIPT_DIR/html/* /var/www/html/

    # copy ./html/placeholder.jpg to /var/www/html/image.jpg
    sudo cp -r $HAENNO_SCRIPT_DIR/html/placeholder.jpg /var/www/html/image.jpg

    echo "$now --> After update work > done!"

else
    echo "$now --> Remote git repo quick check zerocam > Remote is same as local > Nothing to do!"
fi
echo "$now --> Remote git repo quick check zerocam > Finished!"