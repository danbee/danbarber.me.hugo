---
title: Setting up a local resolver on macOS
date: '2020-01-04T02:30:25+00:00'
layout: micropost
categories:
- web
- web development
- dns
- internet
---

For a good number of years I was using Basecamp's Pow for local web
development and one of my favourite features was the in built local DNS
resolver that meant that `*.dev` would resolve to `127.0.0.1`. This mean
that I had a unique hostname for every site I was building and running
locally which I have found incredibly useful.

Unfortunately Pow no longer sees active development (the GitHub repo has
been archived) so I wanted to see if I could set up the same kind of
local resolver on my Mac without using it.

It turned out to be pretty straightforward!

Note: We're using `.localhost` instead of `.dev` because Google own the
`.dev` TLD and in 2017 they added an HSTS rule to Chromium that forces
any `.dev` domain to use HTTPS. As you can imagine, this is not ideal
for local development so web developers everywhere had to adjust their
setups.

First of all we need to install Dnsmasq. This will handle the local name
resolution. If you're using Homebrew this is dead simple:

    $ brew install dnsmasq

Then we need to configure it to resolve any domain name that ends in
`.localhost` to resolve to `127.0.0.1`.

Uncomment the following line:

    # /usr/local/etc/dnsmasq.conf
    conf-dir=/usr/local/etc/dnsmasq.d

Add the following file to the Dnsmasq configuration directory:

    # /usr/local/etc/dnsmasq.d/localhost
    address=/.localhost/127.0.0.1

Start `dnsmasq` as root (It needs to be running as root to be able to
bind to port 53):

    $ sudo brew services start dnsmasq

Next we need to tell macOS about the local resolver.

Add the following file (You will need to do this as `root`):

    # /etc/resolver/localhost
    nameserver 127.0.0.1
    domain localhost
    search_order 1

And voila! Any domain ending in `.localhost` should now resolve to
`127.0.0.1`. We can test this with a ping:

    $ ping foobar.localhost
    PING foobar.localhost (127.0.0.1): 56 data bytes
    64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.122 ms
    64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.262 ms
    64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.281 ms

## So why is this useful?

That's a very good question! Here's some of the reasons I've found:

1.  If you're developing an app that relies on a number of small
    services it can be useful to differentiate them by domain.
2.  It makes OAuth callback URL's more readable.
3.  It's useful for external services that require a domain name to
    authenticate. A good example of this is font services such as
    Typekit or Hoefler &amp; Co.
4.  It just looks pretty up there in the URL bar!
