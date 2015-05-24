    tudor.add [
      "02 Asset and AssetManager Usage"




      "The classes and instances are expected types"

      tudor.is

      "The Asset class is a function"
      ªF
      -> Asset

      "The AssetManager class is a function"
      ªF
      -> AssetManager

      "An Asset instance is an object"
      ªO
      -> new Asset

      "An AssetManager instance is an object"
      ªO
      -> new AssetManager

      tudor.equal

      "The Asset class is an `instanceof` a `Function`"
      true
      -> Asset instanceof Function

      "The AssetManager class is an `instanceof` a `Function`"
      true
      -> AssetManager instanceof Function

      "An Asset instance is an `instanceof` an `Object`"
      true
      -> new Asset instanceof Object

      "An AssetManager instance is an `instanceof` an `Object`"
      true
      -> new AssetManager instanceof Object

      "An Asset instance is an `instanceof` the Asset class"
      true
      -> new Asset instanceof Asset

      "An AssetManager instance is an `instanceof` the AssetManager class"
      true
      -> new AssetManager instanceof AssetManager




      "Asset public members exist, and are accessible as expected"

      "Asset class has no enumerable properties"
      0
      -> (prop for prop of Asset).length

      -> new Asset

      "Asset instance has expected enumerable properties"
      'setManager,completeHandler,loadHandler,abortHandler,errorHandler,progressHandler,state,progress,manager,url,request,buffer,C,toString,load'
      (mock) -> (prop for prop of mock).join()

      "`C` is 'Asset'" #@todo and immutable
      'Asset'
      (mock) -> mock.C

      "`toString()` is auto-assigned" #@todo and immutable
      '[object Asset]'
      (mock) -> mock.toString()

      "`valueOf()` is the instance itself" #@todo and immutable
      true
      (mock) -> mock == mock.valueOf()

      "`state` is initially 'init'" #@todo and immutable
      'init'
      (mock) -> mock.state

      "`progress` is initially `0`" #@todo and immutable
      0
      (mock) -> mock.progress




      "AssetManager public members exist, and are accessible as expected"

      "AssetManager class has no enumerable properties"
      0
      -> (prop for prop of Asset).length

      -> new AssetManager

      "AssetManager instance has expected enumerable properties"
      'audioCtx,progress,assets,onProgress,onComplete,C,toString,add,load,progressHandler,completeHandler'
      (mock) -> (prop for prop of mock).join()

      "`C` is 'AssetManager'" #@todo and immutable
      'AssetManager'
      (mock) -> mock.C

      "`toString()` is auto-assigned" #@todo and immutable
      '[object AssetManager]'
      (mock) -> mock.toString()

      "`valueOf()` is the instance itself" #@todo and immutable
      true
      (mock) -> mock == mock.valueOf()

      "`progress` is initially `0`" #@todo and immutable
      0
      (mock) -> mock.progress

      "`assets` is initially empty" #@todo and immutable
      0
      (mock) -> mock.assets.length




      "AssetManager can have Assets added to it"

      tudor.throw

      -> new AssetManager

      "Added assets must be instances of Asset"
      '`asset` must be an instance of `Asset`'
      (mock) -> mock.add 123

      tudor.equal

      "The first valid Asset is recorded when `add()`ed"
      1
      (mock) -> mock.add new Asset; mock.assets.length

      "The second valid Asset is recorded when `add()`ed"
      2
      (mock) -> mock.add new Asset; mock.assets.length




      "`AssetManager.load()` returns the number of newly loading Assets"

      "Before loading, both Assets’ states are 'init'"
      'init,init'
      (mock) -> (asset.state for asset in mock.assets).join()

      #@todo simulate an XMLHttpRequest object
      #
      #"First call to `load()` reports that two Assets started loading"
      #2
      #(mock) -> mock.load()
      #
      #"After `load()`, both Assets’ states are 'loading'"
      #'loading,loading'
      #(mock) -> (asset.state for asset in mock.assets).join()
      #
      #"Second call to `load()` reports that no Assets have started loading"
      #0
      #(mock) -> mock.load()








    ]
