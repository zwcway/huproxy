FROM golang:latest
WORKDIR /go/src/github.com/zwcway/huproxy
COPY . .
RUN mkdir /app && go get -d -v . && CGO_ENABLED=0 GOOS=linux go build -a -o /app . && CGO_ENABLED=0 GOOS=linux go build -a -o /app ./huproxyclient

FROM alpine:latest
WORKDIR /
COPY --from=0 /app/ .
CMD ["/huproxy"]
