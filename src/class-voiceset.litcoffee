VoiceSet Class
==============

#### A set of one or more Voice instances




Begin defining the `VoiceSet` class
-----------------------------------

    class VoiceSet
      C: 'VoiceSet'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `maestro <Maestro>`
@todo describe

        @maestro = config.maestro


#### `ID <string>`
Matches the id attribute of this instance’s corresponding `<ARTICLE>` element. 

        @ID = config.$voiceSet.id


#### `allVoices <Main>`
Xx. 

        @allVoices = config.allVoices


#### `focus <integer>`
Index of the Voice in `@voices` which currently has focus. 

        @focus = 0


#### `size <integer>`
Current width and height for the visualizer `@$canvas` (always square). 

        @size = 128


#### `points <array>`
Xx. @todo

        @points = config.front.points.split /\s+/


#### `colors <array>`
Each Voice is given one canvas-friendly color, eg 'red  rgba(0,255,0,0.5)'. 

        @colors = config.front.colors.split /\s+/


#### `samples <array>`
Each Voice is given a reference to an audio file in /asset/audio, eg 'foo.mp3'. 

        @samples = config.front.samples.split /\s+/


#### `blots <array>`
Each Voice is given a Blot rendering style, eg 'square' or 'dots'. 

        @blots = config.front.blots.split /\s+/


Validate values taken from /voice-set/*.md frontmatter. 

        if 5 < @colors.length then throw new Error "
          '#{@ID}' frontmatter contains #{@colors.length} colors"
        if @samples.length != @colors.length then throw new Error "
          '#{@ID}' frontmatter contains unequal colors and samples"
        if @blots.length != @colors.length then throw new Error "
          '#{@ID}' frontmatter contains unequal colors and blots"


#### `canvas <HTMLCanvasElement>`
A `<CANVAS>` element to draw the VoiceSet’s visualizer on. 

        @$canvas = document.createElement 'canvas'
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        @$canvas.setAttribute 'class', 'visualizer'
        config.$voiceSet.appendChild @$canvas


#### `visualizer <CanvasRenderingContext2D>`
A reference to the drawing-context of the visualizer `<CANVAS>`. 

        @visualizer = @$canvas.getContext '2d'
        @visualizer.globalCompositeOperation = 'screen' #@todo why is this not enough?


#### `voices <array>`
The /voice-set/*.md frontmatter defines the VoiceSet’s voices. 

        @voices = []
        i = @colors.length
        while i--
          voice = new Voice
            $voiceSet:    config.$voiceSet
            color:        @colors[i]
            sample:       @samples[i]
            blotRenderer: Blot[ @blots[i] ]
            visualizer:   @visualizer
            maestro:      @maestro
          @voices.push voice
          @allVoices.push voice

Give the first voice focus. When a VoiceSet is 'active', microphone and 
keyboard events are passed to its focused voice. 

        @voices[0].focus = true




Define public methods
---------------------

#### `activate()` and `deactivate()`
Xx. 

      activate: ->
        @size = 512
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        voice.activate() for voice in @voices

      deactivate: ->
        @size = 128
        @$canvas.setAttribute 'width' , @size + 'px'
        @$canvas.setAttribute 'height', @size + 'px'
        voice.deactivate() for voice in @voices


#### `render()`
Xx. 

      render: (frame) ->

Clear all previously rendered pixels in the visualizer canvas. 

        @visualizer.clearRect 0, 0, @size, @size
        @visualizer.globalCompositeOperation = 'screen' #@todo why set this every frame?

Every two seconds, flip which Voice has focus. 

        if frame.flip2000
          voice.hasFocus = false for voice in @voices
          if @voices.length <= ++@focus then @focus = 0
          @voices[@focus].hasFocus = true

Every two seconds, quieten each Voice. 

          voice.quieten 0.8, 0.05 for voice in @voices

Allow each voice to update its own icon, and draw on the visualizer canvas. 

        voice.render frame, @size for voice in @voices

Clear the outer-parts of the visualizer canvas, to reveal the image. @todo





#### `trigger()`
- `velocity <float>`  The power of the trigger, from 0 to 1

Trigger the Voice which currently has focus. 

      trigger: (velocity) ->
        @voices[@focus].trigger velocity



