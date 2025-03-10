#!/bin/bash

# build the flask container
docker build -t vjeenesh/foodtrucks .

# create the network
docker network create foodtruck-nw

# start the ES container
docker run -d --name es --net foodtruck-nw -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2

# start the flask app container
docker run -d --net foodtruck-nw -p 5000:5000 --name foodtrucks vjeenesh/foodtrucks