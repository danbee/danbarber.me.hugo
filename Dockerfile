FROM alpine:edge
RUN apk add --no-cache bash hugo=0.115.2-r0
WORKDIR /app
COPY . ./
