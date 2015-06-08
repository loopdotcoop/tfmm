Blot
====

#### A short animation, which calculates itself based on time and velocity

    class Blot
      C: 'Blot'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------


#### `xx <xx>`
Xx. 

        @xx = null




Static Methods
--------------

#### `square()`
- `time <float>`                      From 0 to 1
- `velocity <float>`                  From 0 to 1
- `ctx2d <CanvasRenderingContext2D>`  The canvas context to draw on
- `size <integer>`                    Pixel width and height of the canvas

Xx. 

    Blot.square = (time, velocity, ctx2d, size) ->
      scale = size * velocity * (1-time)
      topleft = (size - scale) / 4
      ctx2d.fillRect topleft, topleft, scale, scale


    Blot.circle = (time, velocity, ctx2d, size) ->
      radius = Math.max size * velocity * (1-time), 0
      center = size / 2
      ctx2d.beginPath()
      ctx2d.arc center, center, radius / 2, 0, 2*Math.PI
      ctx2d.fill()


    Blot.squtrisqu = (time, velocity, ctx2d, size) ->
      velocity *= 0.6 # looks better smaller
      if 0.5 < time then time = 1 - time # at the end, simulate the start
      scale = size * velocity * (1-time) # in pixels, fills the canvas at t=0
      halfScale = scale / 2              # 
      center    = size  / 2              # 
      ctx2d.beginPath()
      ctx2d.moveTo center - (halfScale*(1-time)), center - halfScale # top left
      ctx2d.lineTo center + (halfScale*(1-time)), center - halfScale # top right
      ctx2d.lineTo center + (scale*time), center + scale     # bottom right
      ctx2d.lineTo center - (scale*time), center + scale     # bottom left
      ctx2d.fill()


    Blot.triangle = (time, velocity, ctx2d, size) ->
      scale = size * velocity * (1-time)
      halfScale = scale / 2
      center = size / 2
      ctx2d.beginPath()
      ctx2d.moveTo center, center - halfScale # top center point
      ctx2d.lineTo center + halfScale, center + scale # bottom right
      ctx2d.lineTo center - halfScale, center + scale # bottom left
      ctx2d.fill()


    Blot.dots = (time, velocity, ctx2d, size) ->
      i = 5
      while --i
        ctx2d.setTransform(
          1 / i * velocity,               # scaling in the X-direction
          0,                               # skewing
          0,                               # skewing
          .5 / i,                          # scaling in the Y-direction
          ( (size * i) / 4 - (size / 4) ) / 2,     # moving  in the X-direction
          size / 2 - (size / 4 * velocity) # moving  in the Y-direction
        )
        Blot.circle(time, velocity, ctx2d, size)
      ctx2d.setTransform 1, 0, 0, 1, 0, 0




    Blot.galaxy = (time, velocity, ctx2d, size) ->
      time = 1 - time # reverse direction
      i = 5
      while i--
        ctx2d.setTransform(
          .5 / time,     # scaling in the X-direction
          0,             # skewing
          0,             # skewing
          .5 / time / i, # scaling in the Y-direction
          size / i / 4,  # moving  in the X-direction
          size / 4       # moving  in the Y-direction
        )
        Blot.circle(time, velocity, ctx2d, size)
      ctx2d.setTransform 1, 0, 0, 1, 0, 0




    Blot.oddtriangle = (time, velocity, ctx2d, size) ->
      scale = size * velocity * (1-time)
      halfScale = scale / 2
      center = size / 2
      ctx2d.beginPath()
      ctx2d.moveTo center, center - halfScale # top center point
      ctx2d.lineTo center + halfScale, scale # bottom right
      ctx2d.lineTo center - halfScale, scale # bottom left
      ctx2d.fill()




    Blot.barupdown = (time, velocity, ctx2d, size) ->
      if 0.5 > time then time = 1 - time # at the start, simulate the end
      scale = size * velocity * (1-time) # in pixels, fills the canvas at t=0
      topleft = (size - scale) / 2 # in pixels, from 0 at t=0
      width = Math.max scale, size / 3 # horizontal bar
      ctx2d.fillRect topleft / 2, topleft, width, scale
      if 0.9 > time
        ctx2d.fillRect topleft / 2, topleft * 0.8, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.2, width, size / 100
      if 0.7 > time
        ctx2d.fillRect topleft / 2, topleft * 0.6, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.4, width, size / 100



    Blot.circleupdown = (time, velocity, ctx2d, size) ->
      if 0.5 > time then time = 1 - time # at the start, simulate the end
      radius = Math.max size * velocity * (1-time), 0
      center = size / 2
      ctx2d.beginPath()
      ctx2d.arc center, center, radius * 0.8, 0, 2*Math.PI * time * velocity
      ctx2d.fill()
      if 0.9 > time
        ctx2d.arc center, center * 0.4 * (time + 1), radius * 0.6, 0, Math.PI * time * velocity
        ctx2d.arc center, center * 0.8 * (time + 1), radius * 0.6, 0, Math.PI * time * velocity
        ctx2d.fill()
      if 0.7 > time
        ctx2d.arc center * 0.2 * (time + 1), center, radius * 0.4, 0, Math.PI * time * velocity
        ctx2d.arc center * 1.0 * (time + 1), center, radius * 0.4, 0, Math.PI * time * velocity
        ctx2d.fill()




    Blot.linecrowd = (time, velocity, ctx2d, size) ->
      if 0.5 > time then time = 1 - time # at the start, simulate the end
      scale = size * velocity * (1-time) # in pixels, fills the canvas at t=0
      topleft = (size - scale) / 2 # in pixels, from 0 at t=0
      topleft = topleft * ( (Math.random() + 7) / 8 )
      width = Math.max scale, size / 2 # horizontal bar
      ctx2d.rotate 0.03
      if 0.6 > time
        ctx2d.fillRect topleft / 2, topleft * 0.8, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.2, width, size / 100
      if 0.7 > time
        ctx2d.fillRect topleft / 2, topleft * 0.6, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.4, width, size / 100
      if 0.8 > time
        ctx2d.fillRect topleft / 2, topleft * 0.4, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.6, width, size / 100
      if 0.9 > time
        ctx2d.fillRect topleft / 2, topleft * 0.2, width, size / 100
        ctx2d.fillRect topleft / 2, topleft * 1.8, width, size / 100
      ctx2d.setTransform 1, 0, 0, 1, 0, 0




    Blot.radiation = (time, velocity, ctx2d, size) ->

      rTime = 1-time # reciprocal time

Draw the central dot. 

      radius = size * velocity * time * 0.1
      center = size / 2
      ctx2d.beginPath()
      ctx2d.arc center, center, radius * 0.5, 0, 2*Math.PI
      ctx2d.fill()

Draw lines and more dots. 

      if 0.1 < time
        ctx2d.fillRect center * 0.95 * velocity, size * 0.4 * rTime, size * 0.05 * velocity, center * 0.8 * rTime

      if 0.2 < time
        ctx2d.rotate 0.1
        ctx2d.fillRect center * 0.96 * velocity, size * 0.4 * rTime, size * 0.04 * velocity, center * 0.8 * rTime
        ctx2d.beginPath()
        ctx2d.arc center, center, radius * 0.35, 0, 2*Math.PI
        ctx2d.fill()

      if 0.5 < time
        ctx2d.rotate 0.2
        ctx2d.fillRect center * 0.97 * velocity, size * 0.4 * rTime, size * 0.03 * velocity, center * 0.8 * rTime
        ctx2d.beginPath()
        ctx2d.arc center, center, radius * 0.2, 0, 2*Math.PI
        ctx2d.fill()

      if 0.7 < time
        ctx2d.rotate 0.4
        ctx2d.fillRect center * 0.98 * velocity, size * 0.4 * rTime, size * 0.02 * velocity, center * 0.8 * rTime
        ctx2d.beginPath()
        ctx2d.arc center, center, radius * 0.1, 0, 2*Math.PI
        ctx2d.fill()
      

      ctx2d.setTransform 1, 0, 0, 1, 0, 0

      #scale = size * velocity * (1-time)
      #topleft = (size - scale) / 4
      #ctx2d.fillRect topleft, topleft, scale, scale




