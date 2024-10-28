# todo-api
#docker commands
#Basic
#Images
#Container
#Network
#Volume
#Compose

##--Basic

docker info
docker version
docker login
docker logout
docker help
docker stats - see cpu/memory usage of container
docker events - check the events docker would fire on console
docker top <container_id> top process runninig inside ocntianer
docker system df - all things daemon manages like images.volumes,containers, build cache etc..
docker system prune

docker run -p 5001:5001 -m 512m --cpu-quota 5000 -d in28mins/todo-rest:1.0.x -- max memory and cpu quota
cpu quota - 100, 000 = 100% so 5000 = > 5% cpu quota


## Images
docker images
docker image ls
docker rmi <image_name>
docker pull <image_name>
docker image pull <image_name>
docker run -d -p host:port <image-name>
docker tag <image-name><image-tag-name>
docker search mysql --search for images in official repository
docker push <image-tag-name>
docker history <image-name>
docker inspect <image-name>
docker image prune
docker image build -t myImage .
docker image -t (tag) myImage Somendra23/myImage:1.0.x --tag image
docker image push Somendra23/myImage:1.0.x
docker image rm -f 8fc4
<registory>:<repository>
hub.docker.com - registry
repository - Somendra23/imageName


docker image ls --format {{.Repository}}:{{.Tag}}:{{.Created}}:{{.Size}}

##container
docker ps 
docker ps -a
docker stop <container-id>
docker start <container-id>
docker restart <container-id>
docker rm <container-id>
docker kill <container-id>
docker exec -it <container-id> /bin/bash
docker inspect <container-id>
docker export <container-id>--save docker data to tar file
docker logs -f <container-id>
docker container pause <container-id>
docker container unpause <container-id>
docker run -it --name mycontainer --restart=always Somendra23/todo:1.0.0
restart policy=always(default)| on-failed | unless-stopped

docker container run -it ubuntu:latest /bin/bash
ps -elf
ctrl+pq - exit the console without terminating the service
docker container ls
docker cp <container-id>:/path/inside/container/logs /path/to/local/machine

dynamic port mapping: host port<->container port 
--copy jar file inside container
docker container cp target/todoapi.jar <container-id>:/tmp

--create image from running container so all the changes inside the container are part of the image
docker container commit <container-id> in28mins/helloworld:1.0.0

-d - detached mode
-p - publish

docker inspect <container-id> | grep IPAddress (get ipaddress of container)

## run container with alpine image 
docker run -d --network none alpine sleep 500

##stop all the container
docker stop $(docker ps -a)
docker rm $(docker ps -a)

docker rm -vf (docker ps -aq) -- remove all containers including ts volumes
docker system prune -a --volumes -- removes all unused containers, volumes, networks and images




#volumes
anonymous volumes Vs named volumes Vs bind mounts

docker volume ls
docker volume create <vol-name>
docker volume inspect <vol-name>
docker volume rm <vol-name>
docker system prune --volumes
bind volumes: /users/somen/documents/data:/data/db-mongo -- local host volume to docker container
docker volume ls -f name=mongo --filter volume by name mongo
anonymous voume Vs named volumes => anonymous volume are without name docker cli will use random name for anonymmous volumes

--locaiton of data in container varies for individual databases ---
mongo: -v mongo-data:/data/db
postgres: -v mongo-data:/var/lob/postgressql/data
mysql: -v mongo-data:/var/lib/mysql

#Network
docker --net ls
docker network create <network-name>
docker network rm <network-name>
docker network inspect <network-name>
network type: bridge (default)| none | host

##create a custom bridge netowrk so container ##can refer to each other by name
docker network create mongo-network --driver bridge

cannot create custom host or none network!!

#compose
docker-compose up
docker-compose --version
docker-compose down
docker-compose ps
docker-compose images
docker-compose restart
docker-compose stop


docker run -d --network hola-sam --name mongo-hola \
	-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=root \
	-v mongo-data:/data/db
	mongo


---- Dockerfile --

ARG JAVA_VERSION = "openJdk:17"

FROM ${JAV_VERSION}

LABEL versionin="1.0.0"

ENV PROJECT_NAME = "todo-api"

ARG APP_HOME="/opt/demployment"

RUN mkdir ${APP_HOME}

COPY target/todo:1.0.0.jar ${APP_HOME}/todo-api.jar  Vs ADD (ability to download a file from URL and execute)

EXPOSE 8080 --- port on which other container cn use to communicate -->

ENTRYPOINT["java","jar","todo-api.jar"] vs CMD["catilina.sh", "run"]


---------------------------

pass database name dynamically to the docker continer

docker run -p 8080:8080 -d -e spring.data.mongodb.host=mongo-sam -e spring.data.mongodb.password=root   --net=hola-sam todo-api:1.0.0

##reading from a different docker file
docker build -f Dockerfile.dev -t myImg:1.0.0 .