Asset
=====

#### Represents a single asset, eg an audio or image file

    class Asset
      C: 'Asset'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------


#### `state <string>`
One of 'init|loading|processing|complete'. @todo use 'processing', eg decode mp3

        @state = 'init'


#### `progress <float>`
How complete this Asset’s loading process is, from 0 to 1. 

        @progress = 0


#### `manager <AssetManager|null>`
The AssetManager currently in control of this Asset, set using `setManager()`. 

        @manager = null


#### `url <string>`
Can be local or remote, eg 'asset/audio/a.mp3' or 'http://example.com/b.jpg'. 

        @url = config.url


#### `request <XMLHttpRequest|null>`
Xx. 

        @request = null


#### `buffer <AudioBuffer|null>`
Xx. 

        @buffer = null




Methods
-------

#### `load()`
Begins loading the Asset, if it hasn’t already begun.  
Returns `0` if `load()` has already been called on the Asset. Otherwise returns 
`1` which helps `AssetManager.load()` count the number of newly loading Assets. 

      load: ->
        if 'init' != @state then return 0
        @state = 'loading'

Instantiate an [XMLHttpRequest object](https://goo.gl/P8k0Np). 

        @request = new XMLHttpRequest

Listen for XMLHttpRequest events. 

        @request.addEventListener 'progress', @progressHandler , false
        @request.addEventListener 'error'   , @errorHandler    , false
        @request.addEventListener 'abort'   , @abortHandler    , false
        @request.addEventListener 'load'    , @loadHandler     , false

Begin loading the file. @todo only use 'arraybuffer' for appropriate file types

        @request.open 'GET', @url, true # method, url, async
        @request.responseType = 'arraybuffer'
        @request.send()


        #setTimeout(
        #  (=> @progress = Math.random() * 0.5; @manager.progressHandler(); ),
        #  Math.random() * 1000
        #)
        #setTimeout(
        #  (=> @progress = Math.random() * 0.5 + 0.5; @manager.progressHandler(); ),
        #  1000 + (Math.random() * 1000)
        #)
        #setTimeout(
        #  (=> @state = 'complete'; @progress = 1; @manager.progressHandler(); @manager.completeHandler()),
        #  2000 + (Math.random() * 1000)
        #)
        1




#### `progressHandler()`
- `event <ProgressEvent>`  Provides `lengthComputable`, `loaded` and `total`

Deal with an [XMLHttpRequest 'progress' event](https://goo.gl/iXCpGH). 

      progressHandler: (event) =>
        if event.lengthComputable
          @progress = event.loaded / event.total
          @manager.progressHandler()
        #@todo deal with (! event.lengthComputable), eg `total` is unknown




#### `errorHandler()`
- `event <Xx>`  @todo

Deal with an [XMLHttpRequest 'error' event](https://goo.gl/iXCpGH). 

      errorHandler: (event) =>
        ª event
        @manager.completeHandler 'oh no, error!'




#### `abortHandler()`
- `event <Xx>`  @todo

Deal with an [XMLHttpRequest 'abort' event](https://goo.gl/iXCpGH). 

      abortHandler: (event) =>
        ª event
        @manager.completeHandler 'oh no, abort!'




#### `loadHandler()`
Deal with an [XMLHttpRequest 'load' event](https://goo.gl/iXCpGH). 

      loadHandler: =>
        if 200 != @request.status
          @manager.completeHandler "Load error, status #{@request.status}"
        else
          @state = 'processing'
          @progress = 1
          @manager.audioCtx.decodeAudioData @request.response, @completeHandler, @errorHandler




#### `completeHandler()`
- `buffer <AudioBuffer>`  The decoded audio data returned by `decodeAudioData()`

Xx. 

      completeHandler: (buffer) =>
        @buffer = buffer
        @state = 'complete'
        @manager.completeHandler()






#### `setManager()`
- `manager <AssetManager>`  The manager which will take control of this Asset

Xx. 

      setManager: (manager) =>

Validate the AssetManager. 

        if ! (manager instanceof AssetManager)
          throw new Error "`manager` must be an instance of `AssetManager`"

Update the AssetManager. @todo prevent takeover?

        @manager = manager




