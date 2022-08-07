FROM alpine:latest
RUN apk add --no-cache bash hugo=0.99.1-r2
WORKDIR /app
COPY . ./
