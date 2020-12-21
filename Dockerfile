# ----------------------------------
# Pterodactyl Panel Dockerfile
# ----------------------------------

FROM golang:1.14.4-alpine

COPY . /titanbot

WORKDIR /titanbot

RUN apk add --no-cache --update git curl lua-stdlib lua musl-dev g++ libc-dev tesseract-ocr tesseract-ocr-dev \
 && go mod tidy \
 && go build -o titanbot

FROM alpine:latest
WORKDIR /root/
RUN apk add --no-cache --update git curl lua-stdlib lua musl-dev g++ libc-dev tesseract-ocr tesseract-ocr-dev
COPY --from=0 /titanbot/titanbot .
CMD ["./titanbot"]