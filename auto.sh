#!/bin/bash

docker build -t mymicroservice -f Dockerfile .

docker run -d -it --rm -p 3000:8080 --name mymicroservicecontainer mymicroservice

docker build -t my-react-app -f Dockerfile2 .

docker run -d -p 3001:80 --name my-react-app-container my-react-app

