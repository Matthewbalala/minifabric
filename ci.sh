#!/usr/bin/env bash
set -ex

docker build -t hfrd/minifab:latest .
git clone https://github.com/SamYuan1990/stupid.git && cd stupid && git checkout docker
docker build -t stupid:latest . && cd ..
./minifab up
docker run  --network minifab -v $PWD:/tmp  stupid stupid /tmp/config.yaml 100
./minifab cleanup

sleep 10

rm spec.yaml
mv spec2.yaml spec.yaml
./minifab up
docker run  --network minifab -v $PWD:/tmp  stupid stupid /tmp/config.yaml 100
./minifab cleanup
