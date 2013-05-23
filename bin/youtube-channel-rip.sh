#!/usr/bin/env bash

CHANNEL_NAME=${1:-0}
MAX_RESULTS=${2:-10}
DOWNLOAD_LOCATION=${3:-`PWD`}
FILE_DOWNLOADED_LIST="$HOME/.youtube-downloaded"

DOWNLOAD_LOCATION="$DOWNLOAD_LOCATION/%(title)s.%(ext)s"

for i in $(curl -s http://gdata.youtube.com/feeds/api/users/"$CHANNEL_NAME"/uploads\?max-results\=$MAX_RESULTS | grep -Eo "url='http://www.youtube.com/watch\?v=[^[:space:]\"\'\\]{11}" | uniq | cut -d= -f3);
do

  if ! grep -iq "http://www.youtube.com/watch?v=$i" $FILE_DOWNLOADED_LIST ; then

    growlnotify -t "youtube-channel-rip" -m "Downloading video of $CHANNEL_NAME"

    youtube-dl -w -c -f 22/18 -o "$DOWNLOAD_LOCATION" "http://www.youtube.com/watch?v=$i"

    if [ $? -eq 0 ]; then
      echo "http://www.youtube.com/watch?v=$i" >> $FILE_DOWNLOADED_LIST
    fi

  fi

done;


