FROM alpine:3.18.2
RUN apk add --no-cache bash hugo=0.115.2-r0
WORKDIR /app
COPY . ./
