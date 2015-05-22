Timeline Class
==============

#### Xx @todo describe




Begin defining the `Timeline` class
-----------------------------------

    class Timeline
      C: 'Timeline'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `flourishes <Array>`
Records the various Flourish instances which the Timeline currently contains. 

        @flourishes = []


#### `now <float>`
The most recent frame, as a fraction of the `frac2000` loop-length. 

        @now = 0




Define public methods
---------------------

#### `add()`
- `velocity <float>`  The power of the new Flourish, from 0 to 1

Record a new Flourish. 

      add: (velocity) ->
        @flourishes.push new Flourish
          start:    @now
          duration: 0.2
          velocity: velocity




#### `render()`
- `frame <integer>`                     The frame to render
- `context <CanvasRenderingContext2D>`  A `<CANVAS>` context to draw on
- `size <integer>`                      Width and height of `context`

Draw each Flourish on the given `<CANVAS>` context, for the given `frame`. 

      render: (frame, context, size) ->
        @now = frame.frac2000
        flourish.render @now, context, size for flourish in @flourishes




#### `quieten()`
- `multiplier <float>`  0 to 1, applied to every Flourish
- `threshold <float>`   Below this velocity, a Flourish is removed

Attenuate all Flourishes. Typically called at the end of every loop. 

      quieten: (multiplier, threshold) ->
        #ª 'm', multiplier, 't', threshold
        i = @flourishes.length
        while i--
          flourish = @flourishes[i]
          flourish.velocity *= multiplier
          if threshold >= flourish.velocity
            @flourishes.splice i, 1
            #ª 'v', flourish.velocity, 'Removed, now ', @flourishes.length




