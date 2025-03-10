FROM nginx:alpine

ARG SERVICE_VERSION
ENV SERVICE_VERSION=${SERVICE_VERSION}

COPY ./website /usr/share/nginx/html

RUN find ./usr/share/nginx/html -type f -exec sh -c 'sed -i "s/#SERVICE_VERSION#/${SERVICE_VERSION}/g" "$0"' {} \;

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
