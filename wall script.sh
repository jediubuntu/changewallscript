#!/bin/bash

PID=$(pgrep gnome-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

countervar=1;
finish=0;
cd /home/guinness/.rwallpaper/
if [ -f counter ]
then
    countervar=`cat counter`
fi

for (( i=$countervar; c<=2000000; i++ ))
do
   echo $i > "counter"
   if [ ! -f wallpaper-$i.jpg ]
   then
    wget "http://wallpapers.wallbase.cc/rozne/wallpaper-$i.jpg"

    if [ -f wallpaper-$i.jpg ]
    then
        gsettings set org.gnome.desktop.background picture-uri "file:///home/guinness/.rwallpaper/wallpaper-$i.jpg"
        exit
    fi
   fi
done
