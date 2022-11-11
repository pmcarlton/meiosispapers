#!/bin/bash

while true;
do
if read TEXT; then
echo $TEXT | oysttyer.pl -keyf=.oysttyerkey_meiosispapers -script ;
sleep 2
echo $TEXT >> meiotweetlog.txt
fi
date >> meiotweetlog.txt
sleep 70
done
exit 0
