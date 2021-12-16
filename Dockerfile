FROM alpine:latest
RUN apk add --no-cache bash hugo
WORKDIR /app
COPY . ./
