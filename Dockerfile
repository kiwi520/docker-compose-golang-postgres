# Compile stage
FROM golang:1.13.8 AS build-env

ADD . /dockerdev
WORKDIR /dockerdev

RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN go list std

RUN go build -o /server

# Final stage
FROM debian:buster

EXPOSE 8000

WORKDIR /
COPY --from=build-env /server /

CMD ["/server"]
