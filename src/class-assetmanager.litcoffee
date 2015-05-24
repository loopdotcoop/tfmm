AssetManager
============

#### Provides a single point of contact for managing an app’s Assets

    class AssetManager
      C: 'AssetManager'
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------


#### `progress <float>`
A summary of how complete all the Assets’ loading processes are, from 0 to 1. 

        @progress = 0


#### `assets <array>`
Contains the app’s current Assets. 

        @assets = []


#### `onProgress <function>`
Called each time progress is made. 

        @onProgress = config.onProgress || ->


#### `onComplete <function>`
Called when all Assets have completed. 

        @onComplete = config.onComplete || ->




Methods
-------


#### `add()`
- `asset <Asset>`  An Asset instance to start managing

Adds an Asset to the list of Assets currently being managed. 

      add: (asset) ->

Validate the Asset. 

        if ! (asset instanceof Asset)
          throw new Error "`asset` must be an instance of `Asset`"

The Asset needs call methods on its Manager, eg `manager.progressHandler()`. 

        asset.setManager @

Add the Asset to the list. 

        @assets.push asset
        @ # allow chaining




#### `load()`
Begins loading all Assets which have not already started loading.  
Returns the number of Assets which started loading because of this call (so, 
does not include Assets that were already leading in this number).  

      load: ->
        (asset.load() for asset in @assets).reduce (a, b) -> a + b




#### `progressHandler()`
Xx. 

      progressHandler: ->
        progress = 0
        i = @assets.length
        while i--
          progress += @assets[i].progress
        @onProgress progress / @assets.length




#### `completeHandler()`
- `error <string>`  Explains why the load failed, or `undefined` if successful

This method is passed to the second argument of `Asset.load()`. 

      completeHandler: (error) ->
        if error then return @onComplete error
        i = @assets.length
        while i--
          if 'complete' != @assets[i].state then return
        @onComplete()




