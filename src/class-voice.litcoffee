Voice Class
===========

#### Xx @todo describe




Begin defining the `Voice` class
--------------------------------

    class Voice
      C: 'Voice'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `flourishes <Array>`
Records the various Flourish instances which belong to this Voice. 

        @flourishes = []


#### `now <float>`
The most recent frame, as a fraction of the `frac2000` loop-length. 

        @now = {}


#### `maestro <Maestro>`
@todo describe

        @maestro = config.maestro


#### `hasFocus <boolean>`
Whether this Voice is currently receptive to keyboard or microphone input. 

        @hasFocus = false


#### `size <integer>`
The current width and height for the icon `@$canvas` (which is always square). 

        @size = 16


#### `$canvas <HTMLCanvasElement>`
A `<CANVAS>` element to draw an icon on, and receive click/touch events. 

        @$canvas = document.createElement 'canvas'
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @$canvas.setAttribute 'class', 'icon'
        config.$voiceSet.appendChild @$canvas


#### `icon <CanvasRenderingContext2D>`
A reference to the drawing-context of the icon `<CANVAS>`. 

        @icon = @$canvas.getContext '2d'


#### `visualizer <CanvasRenderingContext2D>`
A reference to the drawing-context of the VoiceSet’s visualizer `<CANVAS>`. 

        @visualizer = config.visualizer


#### `color <string>`
The icon fill-color for this Voice. Note that we set the icon color here. 

        @color = @icon.fillStyle = config.color


#### `sample <Asset>`
An Asset representing the audio file for this Voice. 

        @sample = new Asset 
          url: "asset/audio/#{config.sample}.mp3"


#### `blotRenderer <function>`
Each Voice is given a Blot rendering function, eg `Blot.dots()`. 

        @blotRenderer = config.blotRenderer


#### `duration <number>`
Each Voice has a duration, from 0 to 1, as a proportion of `frac8000`. 

        @duration = + config.duration




Define public methods
---------------------

#### `activate()` and `deactivate()`
Xx. 

      activate: ->
        @size = 64
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @icon.fillStyle = @color #@todo investigate why color is black without this line

      deactivate: ->
        @size = 16
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @icon.fillStyle = @color #@todo investigate why color is black without this line




#### `render()`
- `frame <object>`     The current moment’s frame object
- `visSize <integer>`  visualizer size

      render: (frame, visSize) ->

        @now = frame

Render the current icon frame. 

        @icon.clearRect 0, 0, @size, @size
        time = if 0.5 > frame.frac2000 then 1 - frame.frac2000 else frame.frac2000
        time = (time - 0.5) / 4
        time += if ! @hasFocus then 0.6 else 0.3
        @blotRenderer time, 1, @icon, @size

Add to the current frame of the visualizer animation. 

        @visualizer.fillStyle = @color

Xx. 

        flourish.render frame, @visualizer, visSize for flourish in @flourishes




#### `trigger()`
- `velocity <float>`  The power of the trigger, from 0 to 1

Add a Flourish to the `flourishes` list, and play the sample. 

      trigger: (velocity) ->
        ª @duration
        @flourishes.push new Flourish
          start:        @now.frac2000
          duration:     @duration
          velocity:     velocity
          voice:        @
          blotRenderer: @blotRenderer
        @play velocity, 0




#### `play()`
- `velocity <float>`  The loudness to play the sample, from 0 to 1
- `stamp <float>`     A timestamp, passed to the `when` argument of `start()`

Play the sample. 

      play: (velocity, stamp) ->

        source = @maestro.audioCtx.createBufferSource()
        source.buffer = @sample.buffer
        gainNode = @maestro.audioCtx.createGain()
        source.connect gainNode
        gainNode.connect @maestro.audioCtx.destination
        gainNode.gain.value = velocity
        source.start stamp / 1000




#### `quieten()`
- `multiplier <float>`  0 to 1, applied to every Flourish
- `threshold <float>`   Below this velocity, a Flourish is removed

Attenuate all Flourishes. Typically called at the end of every loop. 

      quieten: (multiplier, threshold) ->
        i = @flourishes.length
        while i--
          flourish = @flourishes[i]
          flourish.velocity *= multiplier
          if threshold >= flourish.velocity
            @flourishes.splice i, 1



