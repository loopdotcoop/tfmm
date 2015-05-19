Voice Class
===========

#### Xx @todo describe




Begin defining the `Voice` class
--------------------------------

    class Voice

#### `I`, `ID` and `toString()`

      I: 'Voice'
      toString: -> "[object #{@I}]"


#### `receptive` and `size`

      receptive: false
      size: 8




#### `constructor()`
Xx. 

      constructor: (config={}) ->

Create a `<CANVAS>` element to display the voice’s icon. 

        @$canvas = document.createElement 'canvas'
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @$canvas.setAttribute 'class', 'icon'
        config.$player.appendChild @$canvas

Record a reference to the main canvas context and the icon canvas context. 

        @main = config.main
        @icon = @$canvas.getContext '2d'

Set the icon color, and record a handy reference to it. 

        @icon.fillStyle = @color = config.color




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
        @drawSquare @icon, frame.secFrac * scaleMultiplier, @size

Render the main animation. 

        @main.fillStyle = @color
        @drawSquare @main, frame.secFrac * scaleMultiplier, mainSize


#### `drawSquare()`
Draws a square at the center of the given `ctx`, where `scale` is the fraction 
from 0 to 1 of the fiven canvas `size`. 

      drawSquare: (ctx, scale, size) ->
        scale = size * scale # convert `scale` from fraction to actual pixels
        pos = (size - scale) / 2
        ctx.fillRect pos, pos, scale, scale





