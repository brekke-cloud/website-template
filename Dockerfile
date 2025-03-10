FROM golang:1.24 AS builder

ARG SERVICE_VERSION
ENV SERVICE_VERSION=${SERVICE_VERSION}

WORKDIR /website
COPY . .

RUN find . -type f -exec sed -i 's/#SERVICE_VERSION#/$SERVICE_VERSION/g' {} \;

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
COPY --from=builder /website/app /app

EXPOSE 80
CMD ["./app"]
