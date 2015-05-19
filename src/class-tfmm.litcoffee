Tfmm Class
==========

#### Xx @todo describe




Begin defining the `Tfmm` class
-------------------------------

    class Tfmm #@todo extend Abasis




Define public constants
-----------------------

By convention, identifiers for constants are all capital letters. 

#### `I` and `ID`

      I:  ªI
      ID: -> ªuid @I.toLowerCase()




      toString: -> "[object #{@I}]"




      constructor: (config={}) ->

Validate and record constants relating to shape and color. 

        @POINTS = config.front.points.split /\s+/
        @COLORS = config.front.colors.split /\s+/
        if 5 < @COLORS.length then throw new Error "
          '#{config.$player.id}' frontmatter contains #{@COLORS.length} colors"

Run special HTML-only initialization if `$player` is provided. @todo validate `$player`

        if config.$player

Create a canvas, if `$player` is provided, and get its 2D context. 

          @_canvas = document.createElement 'canvas'
          @_canvas.setAttribute 'width' , '256px'
          @_canvas.setAttribute 'height', '256px'
          @_canvas.setAttribute 'class', 'main'
          @_ctx = @_canvas.getContext '2d'
          config.$player.appendChild @_canvas

Create the voices. 

          @_voices = []
          for color in @COLORS
            @_voices.push new Voice
              $player: config.$player
              color:   color
              ctx:     @_ctx




Define public methods
---------------------

#### `render()`
Xx. 

      render: (secfrac) ->
        @_ctx.clearRect 0, 0, 256, 256
        @_ctx.fillStyle = "rgb(0,100,0)"
        @_ctx.fillRect 0, 0, secfrac, secfrac
        voice.render secfrac for voice in @_voices




