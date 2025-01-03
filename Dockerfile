FROM alpine:3.19.1
RUN apk add --no-cache bash hugo=0.120.4-r3
WORKDIR /app
COPY . ./

CMD ["hugo", "server", "--disableLiveReload", "--bind=0.0.0.0", "--port=3000", "--baseURL=https://danbarber.me", "--appendPort=false"]
