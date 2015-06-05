RoarrrªMicIn Class
===========

#### Xx @todo describe




Begin defining the `MicIn` class
--------------------------------

    class MicIn
      C: 'MicIn'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->


#### `callbacks <Array>`
Functions to be called when mic input passes a given threshold. 

        @callbacks = []
        if config.callback then @callbacks.push config.callback


#### `ctxAudio <AudioContext>`
Xx. 

        @ctxAudio = config.ctxAudio
        if ! @ctxAudio then throw new Error '`config.ctxAudio` not provided!'


#### `maestro <Maestro>`
Xx. 

        @maestro = config.maestro
        if ! @maestro then throw new Error '`config.maestro` not provided!'


#### `xx <xx>`
Xx. 

        @initUserMedia()



Define public methods
---------------------

#### `initUserMedia()`
Xx. 

      initUserMedia: ->

Polyfill for legacy browsers’ `getUserMedia()` implementations. 

        navigator.getUserMedia = (navigator.getUserMedia ||
                                  navigator.webkitGetUserMedia ||
                                  navigator.mozGetUserMedia ||
                                  navigator.msGetUserMedia)
        if ! navigator.getUserMedia
          throw new Error 'getUserMedia not supported!'

Xx. 

        navigator.getUserMedia(
          { audio: true, video: false }, # constraints
          @initStream,
          (error) ->

In some browsers, `getUserMedia()` calls the error-callback when the user 
dismisses the popup. We should not treat that as a breaking-error. 

@todo Chrome and Firefox [test others] send a PermissionDeniedError if the user 
has ever clicked ‘Block’ (Chrome) or selected ‘Never Share’ (Firefox)... 
how do we tell a user what has happened, and let them unblock if they want to? 

            if /^Permission(Dismissed|Denied)Error$/.test error.name
              ª "`getUserMedia()` got a '#{error.name}'"
            else
              throw new Error '`getUserMedia()` error: ' + error.name
        )




#### `initStream()`
- `stream <MediaStream>`  [A stream of media content](https://goo.gl/vGCXTr)

Xx. 

      initStream: (stream) =>
        
Feed the HTMLMediaElement into a `MediaStreamAudioSourceNode`. 

        @streamSource = @ctxAudio.createMediaStreamSource stream, 2

Set up the audio analyser. 

        @analyser = @ctxAudio.createAnalyser()
        @analyser.fftSize = 2048
        @bufferLength = @analyser.frequencyBinCount
        @dataArray = new Uint8Array @bufferLength

Connect the streaming audio input to the analyser

        @streamSource.connect @analyser

Tell Maestro about this MicIn instance. 

        @maestro.renderers.push @




#### `render()`
- `cue <Object>`  Xx

Xx. 

      render: (cue) =>
        @analyser.getByteTimeDomainData @dataArray

        highestPeak = 0
        i = @bufferLength
        while i--
          highestPeak = Math.max highestPeak, @dataArray[i]

Convert `highestPeak`, an integer from 128 to 255, to a float from 0 to 1. 

        highestPeak = highestPeak / 128.0 - 1

More sensitive above 0.5, less sensitive below 0.5

        if 0.3 < highestPeak then @callbacks[0].fn highestPeak * highestPeak





