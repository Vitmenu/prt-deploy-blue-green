FROM nginx:alpine

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./config/proxy_params /etc/nginx/proxy_params

COPY ./config/server-blocks /etc/server-blocks
COPY ./config/server-blocks/prt-nginx-zero-downtime-nodejs/blue.conf /etc/nginx/conf.d/prt-nginx-zero-downtime-nodejs.conf

RUN mkdir -p /home/vm-entry

EXPOSE 5173

CMD ["nginx", "-g", "daemon off;"]