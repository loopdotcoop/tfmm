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
Whether the Voice is currently receptive to keyboard or microphone input. 

        @timeline = new Timeline


#### `receptive <boolean>`
Whether this Voice is currently receptive to keyboard or microphone input. @todo rename `hasFocus`

        @receptive = false


#### `size <integer>`
The current width and height for the `@$canvas` (which is always square). 

        @size = 8


#### `$canvas <HTMLCanvasElement>`
A `<CANVAS>` element to draw an icon on, and receive click/touch events. 

        @$canvas = document.createElement 'canvas'
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @$canvas.setAttribute 'class', 'icon'
        config.$player.appendChild @$canvas


#### `icon <HTMLCanvasElement>`
A reference to this Voice’s `<CANVAS>` context. 

        @icon = @$canvas.getContext '2d'


#### `main <HTMLCanvasElement>`
A reference to the VoiceSet’s `<CANVAS>` context. 

        @main = config.main


#### `color <string>`
The icon fill-color for this Voice. Note that we set the icon color here. 

        @color = @icon.fillStyle = config.color




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

      render: (frame, mainSize) ->

Alter the icon when receptive. 

        scaleMultiplier = if @receptive then 1 else 0.5

Render the icon. 

        @icon.clearRect 0, 0, @size, @size
        @drawSquare @icon, frame.frac8000 * scaleMultiplier, @size

Render the main animation. 

        @main.fillStyle = @color
        @timeline.render frame, @main, mainSize


#### `drawSquare()`
Draws a square at the center of the given `ctx`, where `scale` is the fraction 
from 0 to 1 of the given canvas `size`. 

      drawSquare: (ctx, scale, size) ->
        scale = size * scale # convert `scale` from fraction to actual pixels
        pos = (size - scale) / 2
        ctx.fillRect pos, pos, scale, scale


