Maestro Class
=============

#### Xx @todo describe




Begin defining the `Maestro` class
----------------------------------

    class Maestro
      C: 'Maestro'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `renderers <array>`
Xx. @todo describe

        @renderers = config.renderers || []


#### `raf <function>`
Allow a custom function, or default to the browser’s `requestAnimationFrame()`. 

        if config.raf
          @raf = config.raf.bind @
        else
          @raf = window.requestAnimationFrame.bind window


#### `prevFlip2000 <float>`
Used by `step()` to detect a `flip2000` frame. Initializing it to `-1` ensures 
that `currFlip2000 = true` and `currFlip8000 = true` on the first frame. 

        @prevFlip2000 = -1




Define public methods
---------------------

#### `start()`

Begin the sequence of animation frames. 

      start: ->
        @raf @step




#### `step()`
- `stamp <DOMHighResTimeStamp>`  Current time, to at least microsecond accuracy

Xx. @todo describe

      step: (stamp) => # note `=>`, because `step()` is passed to `raf()`

Decide whether this is a `flip2000` frame, which occurs every two seconds. 

        currFlip2000 = stamp % 2000
        if currFlip2000 >= @prevFlip2000
          flip2000 = false
        else
          flip2000 = true

Decide whether this is a `flip8000` frame, which occurs every eight seconds. 

          if currFlip2000 == stamp % 8000
            flip8000 = true
          else
            flip8000 = false
        @prevFlip2000 = currFlip2000

Generate `cue`, which gives renderers useful info about the current frame. 

        cue =
          stamp:    stamp
          flip2000: flip2000
          flip8000: flip8000
          frac2000: (stamp % 2000) / 2000 # float, 0 to 1, lasting two seconds
          frac8000: (stamp % 8000) / 8000 # float, 0 to 1, lasting eight seconds

Call each renderer’s `render()` method. 

        for renderer in @renderers
          do (renderer) -> renderer.render cue

Recursively call `step()`, the next time the display refreshes. 

        @raf @step



