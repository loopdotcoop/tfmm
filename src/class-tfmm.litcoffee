Tfmm Class
==========

#### Xx @todo describe




Begin defining the `Tfmm` class
-------------------------------

    class Tfmm

#### `I` and `toString()`

      I:  ªI
      toString: -> "[object #{@I}]"


#### `receptive` and `size`

      receptive: 0
      size: 32




      constructor: (config={}) ->

Record the instance ID. 

        @ID = config.$player.id


Validate and record constants relating to shape and color. 

        @POINTS = config.front.points.split /\s+/
        @COLORS = config.front.colors.split /\s+/
        if 5 < @COLORS.length then throw new Error "
          '#{@ID}' frontmatter contains #{@COLORS.length} colors"

Run special HTML-only initialization if `$player` is provided. @todo validate `$player`

        if config.$player

Create a canvas, if `$player` is provided, and get its 2D context. 

          @$canvas = document.createElement 'canvas'
          @$canvas.setAttribute 'width' , @size + 'px'
          @$canvas.setAttribute 'height', @size + 'px'
          @$canvas.setAttribute 'class', 'main'
          @main = @$canvas.getContext '2d'
          config.$player.appendChild @$canvas

Create the voices. 

          @voices = []
          for color in @COLORS
            @voices.push new Voice
              $player: config.$player
              color:   color
              main:    @main

Make the first voice receptive to user inputs. 

          @voices[0].receptive = true




Define public methods
---------------------

#### `activate()` and `deactivate()`
Xx. 

      activate: ->
        @size = 256
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        voice.activate() for voice in @voices

      deactivate: ->
        @size = 32
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        voice.deactivate() for voice in @voices


#### `render()`
Xx. 

      render: (frame) ->

Clear all previously rendered pixels in the main canvas. 

        @main.clearRect 0, 0, @size, @size

Every two seconds, flip which voice is receptive. 

        if frame.flip2000
          voice.receptive = false for voice in @voices
          if @voices.length <= ++@receptive then @receptive = 0
          if ! @voices[@receptive] then console.log @ID, @receptive
          @voices[@receptive].receptive = true

Let each voice draw on the main canvas, and also update its icon.

        voice.render frame, @size for voice in @voices

Clear the outer-parts of the main canvas, to reveal the image. @todo

        @main.fillStyle = "rgba(0,100,0,.5)"
        @main.fillRect 0, 0, frame.secFrac * @size, frame.secFrac * @size




