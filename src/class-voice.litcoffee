Voice Class
===========

#### Xx @todo describe




Begin defining the `Voice` class
--------------------------------

    class Voice
      C: 'Voice'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `maestro <Maestro>`
@todo describe

        @maestro = config.maestro


#### `timeline <Timeline>`
Every voice has a single Timeline, which holds the current Flourishes. 

        @timeline = new Timeline
          voice: @


#### `hasFocus <boolean>`
Whether this Voice is currently receptive to keyboard or microphone input. 

        @hasFocus = false


#### `size <integer>`
The current width and height for the icon `@$canvas` (which is always square). 

        @size = 8


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

        #@$audio = document.createElement 'audio'
        #@$audio.setAttribute 'src', "./asset/audio/#{@sample}"
        #@$audio.setAttribute 'autoplay', "true"
        #config.$voiceSet.appendChild @$audio




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
        @size = 8
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @icon.fillStyle = @color #@todo investigate why color is black without this line




#### `render()`
- `frame <object>`            The current moment’s frame object
- `visualizerSize <integer>`  Xx

      render: (frame, visualizerSize) ->

Alter the icon when this Voice has focus. 

        scaleMultiplier = if @hasFocus then 1 else 0.5

Render the current icon frame. 

        @icon.clearRect 0, 0, @size, @size
        @drawSquare @icon, frame.frac8000 * scaleMultiplier, @size

Add to the current frame of the visualizer animation. 

        @visualizer.fillStyle = @color
        @timeline.render frame, @visualizer, visualizerSize




#### `drawSquare()`
- `context <CanvasRenderingContext2D>`  The canvas context to draw on
- `scale <float>`                       Fraction of the canvas the square fills
- `size <integer>`                      Pixel width and height of the canvas
Draws a square at the center of the given `context`, where `scale` is the 
fraction from 0 to 1 of the given canvas `size`. 

      drawSquare: (context, scale, size) ->
        scale = size * scale # convert `scale` from fraction to actual pixels
        pos = (size - scale) / 2
        context.fillRect pos, pos, scale, scale




#### `trigger()`
- `velocity <float>`  The power of the trigger, from 0 to 1

Add a Flourish to the timeline, and play the sample. 

      trigger: (velocity) ->
        @timeline.add velocity
        @play 0




#### `play()`
- `velocity <float>`  The loudness to play the sample, from 0 to 1
- `stamp <float>`     A timestamp, passed to the `when` argument of `start()`

Play the sample. 

      play: (velocity, stamp) ->
        source = @maestro.audioCtx.createBufferSource()
        source.buffer = @sample.buffer
        source.connect @maestro.audioCtx.destination
        source.start stamp


