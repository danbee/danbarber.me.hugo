---
title: Plasmatron Shader
layout: post
categories:
- shaders
- webgl
- demoscene
- effects
date: '2020-06-25'
image: plasmatron.jpg
---

I've been interested in computer graphics for as long as I can remember. The
reason I started programming at all was because I wanted to make things happen
on the screen.

Recently I've been playing around with fragment shaders. Fragment shaders are
tiny programs that run on the GPU and compute the colour of individual pixels
(fragments). They do this incredibly quickly because the GPU has a large number
of simple processing cores, often numbering in the hundreds or thousands, to
enable massive parallelisation.

<!--more-->

Shaders are written in a language called GLSL, or OpenGL Shader Language. It's
pretty similar to C. Here is a simple plasma shader I wrote a few years ago:

```glsl
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

const float PI = 3.14159265;

void main() {
  float width = u_resolution.x;
  float height = u_resolution.y;

  float scale = (width + height) / 2.0;

  float time = u_time * 0.3;

  // calculate the centre of the circular sines
  vec2 center = vec2((width / 2.0) + sin(time) * (width / 1.5),
                     (height / 2.0) + cos(time) * (height / 1.5));

  float distance = length(gl_FragCoord.xy - center);

  // circular plasmas sines
  float circ = (sin(distance / (scale / 7.6) + sin(time * 1.1) * 5.0) + 1.25)
             + (sin(distance / (scale / 11.5) - sin(time * 1.1) * 6.0) + 1.25);

  // x and y plasma sines
  float xval = (sin(gl_FragCoord.x / (scale / 6.5) + sin(time * 1.1) * 4.5) + 1.25)
             + (sin(gl_FragCoord.x / (scale / 9.2) - sin(time * 1.1) * 5.5) + 1.25);

  float yval = (sin(gl_FragCoord.y / (scale / 6.8) + sin(time * 1.1) * 4.75) + 1.25)
             + (sin(gl_FragCoord.y / (scale / 12.5) - sin(time * 1.1) * 5.75) + 1.25);

  // add the values together for the pixel
  float tval = circ + xval + yval / 3.0;

  // work out the colour
  vec3 color = vec3((cos(PI * tval / 4.0 + time * 3.0) + 1.0) / 2.0,
                    (sin(PI * tval / 3.5 + time * 3.0) + 1.0) / 2.5,
                    (sin(PI * tval / 2.0 + time * 3.0) + 2.0) / 8.0);

  // set the fragment colour
  gl_FragColor = vec4(color, 1.0);
}
```

WebGL makes it possible to embed shaders directly into web pages, so I can show
you the result of the code above in realtime!

<figure>
  <canvas class="glslCanvas shader" data-fragment-url="plasmatron.frag" width="800" height="450"></canvas>
</figure>

If you want to see the kind of things that are possible with fragment shaders,
you should check out [Shadertoy](https://www.shadertoy.com/). There are some
incredibly impressive creations on there!

<script type="text/javascript" src="/js/glsl-canvas.js"></script>
