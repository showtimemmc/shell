#!/bin/bash
#TODO search DB 
#pull data from  orpxxx
#HOME=export $HOME
echo $HOME
cd $HOME
sed -n '1,10p' .vimrc
