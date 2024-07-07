# -f: filter. -q: display container ids only
EXIST_BLUE=$(docker ps -f "name=prt-nginx-zero-downtime-nodejs-blue" -f "status=running" -q);

# Feel free to change these variables
NGINX_CONTAINER_NAME="prt-nginx-zero-downtime-nginx"
APPLICATION_IMAGE_NAME="prt-nginx-zero-downtime-nodejs"
DOCKER_NETWORK_NAME="prt-nginx-zero-downtime"

# "-z" means empty. So, if $exist_blue does not exist, then
if [ -z "$EXIST_BLUE" ]; then
    echo "blue container deploy: $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)"

    # sudo docker run -d -p 3000:3000 --rm --name=$APPLICATION_IMAGE_NAME-blue --network $DOCKER_NETWORK_NAME {hub-name}/{repository-name}:$APPLICATION_IMAGE_NAME
    sudo docker run -d -p 3000:3000 --rm --name=$APPLICATION_IMAGE_NAME-blue --network $DOCKER_NETWORK_NAME $APPLICATION_IMAGE_NAME
    STOP_CONTAINER="green"
    START_CONTAINER="blue"
else
    echo "green container deploy: $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)"

    # sudo docker run -d -p 3001:3000 --rm --name=$APPLICATION_IMAGE_NAME-green --network $DOCKER_NETWORK_NAME {hub-name}/{repository-name}:$APPLICATION_IMAGE_NAME
    sudo docker run -d -p 3001:3000 --rm --name=$APPLICATION_IMAGE_NAME-green --network $DOCKER_NETWORK_NAME $APPLICATION_IMAGE_NAME
    STOP_CONTAINER="blue"
    START_CONTAINER="green"
fi

# Wait for 10 seconds
sleep 10

EXIST_AFTER=$(docker ps -f "name=$APPLICATION_IMAGE_NAME-$START_CONTAINER" -f "status=running" -q)

# "-n" means not empty. So, if $exist_after exists, then
if [ -n "$EXIST_AFTER" ]; then

    # Exchange the conf file for the Nginx container
    sudo docker exec $NGINX_CONTAINER_NAME sh -c "cp /etc/server-blocks/$APPLICATION_IMAGE_NAME/$START_CONTAINER.conf /etc/nginx/conf.d/$APPLICATION_IMAGE_NAME.conf"

    # Reload Nginx with the changed conf file
    sudo docker exec $NGINX_CONTAINER_NAME nginx -s reload

    # Stop and remove the old container
    # You may think that the remove command is not necessary, then you can remove it. It's up to you :)
    sudo docker container stop "$APPLICATION_IMAGE_NAME-$STOP_CONTAINER"
    sudo docker container remove "$APPLICATION_IMAGE_NAME-$STOP_CONTAINER"

    # You can replace this with a log or email alert!
    echo "Replacing containers completed"
else
    # You can replace this with a log or email alert!
    echo "Replacing containers failed"
fi