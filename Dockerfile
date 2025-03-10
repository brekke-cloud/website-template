FROM golang:1.24 AS builder

ARG SERVICE_VERSION
ENV SERVICE_VERSION=${SERVICE_VERSION}

WORKDIR /website
COPY . .

RUN sed -i "s/SERVICE_VERSION/${SERVICE_VERSION}/g" /usr/share/nginx/html/index.html

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
COPY --from=builder /website/app /app

CMD ["./app"]
