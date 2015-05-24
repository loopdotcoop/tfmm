()=====

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


#### `onProgress <function>`
Called each time progress is made. 

        #@onProgress = config.onProgress || ->


#### `onComplete <function>`
Called when the Assets has completed. 

        #@onComplete = config.onComplete || ->




Methods
-------

#### `load()`
Begins loading the Asset, if it hasn’t already begun.  
Returns `0` if `load()` has already been called on the Asset. Otherwise returns 
`1` which helps `AssetManager.load()` count the number of newly loading Assets. 

      load: ->
        if 'init' != @state then return 0
        @state = 'loading'
        setTimeout(
          (=> @progress = Math.random() * 0.5; @manager.progressHandler(); ),
          Math.random() * 1000
        )
        setTimeout(
          (=> @progress = Math.random() * 0.5 + 0.5; @manager.progressHandler(); ),
          1000 + (Math.random() * 1000)
        )
        setTimeout(
          (=> @state = 'complete'; @progress = 1; @manager.progressHandler(); @manager.completeHandler()),
          2000 + (Math.random() * 1000)
        )
        1




#### `setManager()`
- `manager <AssetManager>`  The manager which will take control of this Asset

Xx. 

      setManager: (manager) =>

Validate the AssetManager. 

        if ! (manager instanceof AssetManager)
          throw new Error "`manager` must be an instance of `AssetManager`"

Update the AssetManager. @todo prevent takeover?

        @manager = manager




