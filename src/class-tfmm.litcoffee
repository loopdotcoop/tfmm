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

Make constants constant. 
`ªredefine()` uses [`Object.defineProperty()`](https://goo.gl/OIFpuH). 

        for key, value of @
          do (key, value) =>
            if '_' == key.substr 0, 1
              ª key
              ªredefine @, key, value, 'private' #@todo move to `_bars`
            else if /^[_A-Z]+$/.test key
              if ªF == typeof value then value = @[key]()
              ªredefine @, key, value, 'constant'

Make `toString()` and `valueOf()` enumerable and immutable. 

        ªredefine @, 'toString', @toString, 'constant'
        ªredefine @, 'valueOf',  @valueOf,  'constant'

Prevent arbitrary members being added to this instance, or any changes being 
made. See [MDN’s `freeze()` article](https://goo.gl/AJvLYh) for details. 

        Object.freeze @




Define private properties
-------------------------

By convention, private properties are prefixed with an underscore. Developers 
should avoid getting or setting these directly. 




Define public methods
---------------------

#### `clone()`
Returns a copy of the instance. This can be useful in situations where a direct 
reference to the instance should not be passed to another part of the program. 

      #clone: ->
      #  ªclone @, ['id']




#### `destructor()`
Cleans up all resources related to this instance, ready for garbage-collection. 

      #destructor: -> #@todo




