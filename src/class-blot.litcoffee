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
      topleft = (size - scale) / 2
      ctx2d.fillRect topleft, topleft, scale, scale

    Blot.circle = (time, velocity, ctx2d, size) ->
      radius = size * velocity * (1-time)
      center = size / 2
      ctx2d.beginPath()
      ctx2d.arc center, center, radius / 2, 0, 2*Math.PI
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




