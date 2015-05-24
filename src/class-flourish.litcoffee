Flourish Class
==============

#### Xx @todo describe




Begin defining the `Flourish` class
-----------------------------------

    class Flourish
      C: 'Flourish'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `voice <Voice>`
@todo describe

        @voice = config.voice


#### `hasScheduled <boolean>`
True if the Flourish has scheduled its audio to be triggered. 

        @hasScheduled = false


#### `start <float>`
The position in the loop at which this Flourish is triggered, 0 to 1. 

        @start = config.start


#### `duration <float>`
The proportion of the loop this Flourish takes to complete, 0 to 1. 

        @duration = config.duration


#### `velocity <float>`
The current audio and visual ‘loudness’ of the Flourish, from 0 to 1. 

        @velocity = config.velocity




Define public methods
---------------------

#### `render()`
- `frame <object>`                      The current moment’s frame object
- `context <CanvasRenderingContext2D>`  A `<CANVAS>` context to draw on
- `size <integer>`                      Width and height of `context`

Draw the Flourish on a given `<CANVAS>` context. 

      render: (frame, context, size) ->
        now = frame.frac2000
        if @start + @duration < now then return
        if @start > now then return @lookahead now, frame
        #@todo allow wraparound

        @hasScheduled = false #@todo better system?

        thing = 1 - 1 / ( @duration / (now - @start) )

        scale = size * @velocity * thing
        pos = (size - scale) / 2
        context.fillRect pos, pos, scale, scale




#### `lookahead()`
- `now <float>`     The current loop position, 0 to 1
- `frame <object>`  The current moment’s frame object

Xx. 

      lookahead: (now, frame) ->
        if @hasScheduled || @start > now + 0.1 then return
        @hasScheduled = true
        @voice.play @velocity, (frame.stamp + (@start - now) * 2000)




