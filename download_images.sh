#/bin/bash

mkdir -p images/alpine
mkdir -p images/busybox
mkdir -p images/golang

docker export $(docker create alpine) -o images/alpine/alpine.tar
docker export $(docker create busybox) -o images/busybox/busybox.tar
docker export $(docker create golang:1.9.1-alpine) -o images/golang/1.9.1-alpine.tar

cd images/alpine
tar -xf alpine.tar
rm alpine.tar
cd ../../

cd images/busybox
tar -xf busybox.tar
rm busybox.tar
cd ../../

cd images/golang
tar -xf 1.9.1-alpine.tar
rm 1.9.1-alpine.tar
cd ../../

