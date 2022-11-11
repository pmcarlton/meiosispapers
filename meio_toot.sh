#!/bin/bash
#replace ACCOUNT@INSTANCE with your full mastodon account


while true; 
do
if read TEXT;
then
toot activate ACCOUNT@INSTANCE
echo $TEXT | toot post -v unlisted  #default is to post unlisted
sleep 2
echo $TEXT >> meioTootlog.txt
fi
date >> meioTootlog.txt
sleep 2700  #waits 45 minutes
done
exit 0

