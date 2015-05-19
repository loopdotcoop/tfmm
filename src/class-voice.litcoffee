Voice Class
===========

#### Xx @todo describe




Begin defining the `Voice` class
--------------------------------

    class Voice #@todo extend Abasis




Define public constants
-----------------------

By convention, identifiers for constants are all capital letters. 

#### `I` and `ID`

      I:  'Voice'
      ID: -> ªuid @I.toLowerCase()




      toString: -> "[object #{@I}]"




      constructor: (config={}) ->

Record a handy reference to the color, and the main canvas context. 

        @color = config.color
        @_mCtx = config.ctx

Xx. 

        $_button = document.createElement 'canvas'
        $_button.setAttribute 'width' , '64px'
        $_button.setAttribute 'height', '64px'
        $_button.setAttribute 'class', 'button'
        @_bCtx = $_button.getContext '2d'
        config.$player.appendChild $_button

Set the button color. 

        @_bCtx.fillStyle = config.color




Define public methods
---------------------

#### `render()`
Xx. 

      render: (secfrac) ->

Render the button. 

        @_bCtx.clearRect 0, 0, 64, 64
        @_bCtx.fillRect 0, 0, secfrac, secfrac

Render the main animation. 

        @_mCtx.fillStyle = @color
        @_mCtx.fillRect 50, 50, secfrac, secfrac






