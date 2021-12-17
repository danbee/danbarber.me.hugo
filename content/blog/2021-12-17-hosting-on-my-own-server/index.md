---
title: "New hosting"
date: 2021-12-17T17:26:07-06:00
---

After years of hosting this blog on [Netlify](https://www.netlify.com/), I've
decided to finally move it to my [Dokku](https://dokku.com/) server hosted with
[Linode](https://www.linode.com/). Don't get me wrong Netlify is great, but
I realised I wanted a bit more control over my own hosting and Dokku gives me
that. I'd like to spin up a Gemini site at some point in the future and hosting
on my own server should make that much easier.

After playing around with various buildpacks to build the site on Dokku I ended
up settling on a custom `Dockerfile` config that works great and means I can
deploy in less than two minutes.

<!--more-->

```dockerfile
# Dockerfile
FROM alpine:latest
RUN apk add --no-cache bash hugo
WORKDIR /app
COPY . ./
```

```sh
# Procfile
release: hugo -v
web: hugo server --disableLiveReload --bind '0.0.0.0' -p ${PORT}
```

This was all that was required to get things up and running. The site generates
a lot of resized images on build so I needed to mount a volume to make sure that
was persistent between deploys.
