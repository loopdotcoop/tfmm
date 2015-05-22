Voice Class
===========

#### Xx @todo describe




Begin defining the `Voice` class
--------------------------------

    class Voice
      C: 'Voice'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `timeline <Timeline>`
Every voice has a single Timeline, which holds the current Flourishes. 

        @timeline = new Timeline


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


#### `sample <string>`
The filename for the audio file for this Voice, relative to /asset/audio. 

        @sample = config.sample
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
Xx. 

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



