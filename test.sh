# -f: filter. -q: display container ids only
EXIST_BLUE=$(docker ps -f "name=prt-nginx-zero-downtime-nodejs-blue" -f "status=running" -q);

NGINX_CONTAINER_NAME="prt-nginx-zero-downtime-nginx"

IMAGE="prt-nginx-zero-downtime-nodejs"
NETWORK="prt-nginx-zero-downtime"

# "-z" means empty. So, if $exist_blue does not exist, then
if [ -z "$EXIST_BLUE" ]; then
    echo "blue container deploy: $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)"
    # sudo docker run -d -p 3000:3000 --rm --name=$IMAGE-blue --network $NETWORK {hub-name}/{repository-name}:$IMAGE
    sudo docker run -d -p 3000:3000 --rm --name=$IMAGE-blue --network $NETWORK $IMAGE
    STOP_CONTAINER="green"
    START_CONTAINER="blue"
else
    echo "green container deploy: $(date +%Y)-$(date +%m)-$(date +%d) $(date +%H):$(date +%M):$(date +%S)"
    # sudo docker run -d -p 3001:3000 --rm --name=$IMAGE-green --network $NETWORK {hub-name}/{repository-name}:$IMAGE
    sudo docker run -d -p 3001:3000 --rm --name=$IMAGE-green --network $NETWORK $IMAGE
    STOP_CONTAINER="blue"
    START_CONTAINER="green"
fi

sleep 10

EXIST_AFTER=$(docker ps -f "name=$IMAGE-$START_CONTAINER" -f "status=running" -q)

if [ -n "$EXIST_AFTER" ]; then
    # sudo cp /etc/nginx/nginx.${START_CONTAINER}.conf /etc/nginx/nginx.conf
    # sudo nginx -s reload

    sudo docker exec $NGINX_CONTAINER_NAME sh -c "cp /etc/server-blocks/$IMAGE/$START_CONTAINER.conf /etc/nginx/conf.d/$IMAGE.conf"

    sudo docker exec $NGINX_CONTAINER_NAME nginx -s reload

    sudo docker container stop "$IMAGE-$STOP_CONTAINER"
    sudo docker container remove "$IMAGE-$STOP_CONTAINER"

    echo "Replacing containers completed"
else
    echo "Replacing containers failed"
fi