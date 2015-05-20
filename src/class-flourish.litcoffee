Flourish Class
==============

#### Xx @todo describe




Begin defining the `Flourish` class
-----------------------------------

    class Flourish
      C: 'Flourish'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `start <float>`
The position in the Timeline loop at which this Flourish is triggered, 0 to 1. 

        @start = config.start


#### `duration <float>`
The proportion of the Timeline loop this Flourish takes to complete, 0 to 1. 

        @duration = config.duration


#### `velocity <float>`
The current audio and visual ‘loudness’ of the Flourish, from 0 to 1. 

        @velocity = config.velocity




Define public methods
---------------------

#### `render()`
- `now <float>`                         The current loop position, 0 to 1
- `context <CanvasRenderingContext2D>`  A `<CANVAS>` context to draw on
- `size <integer>`                      Width and height of `context`

Draw the Flourish on a given `<CANVAS>` context. 

      render: (now, context, size) ->
        if @start + @duration < now then return
        if @start > now then return
        #@todo allow wraparound

        thing = 1 - 1 / ( @duration / (now - @start) )

        scale = size * @velocity * thing
        pos = (size - scale) / 2
        context.fillRect pos, pos, scale, scale




