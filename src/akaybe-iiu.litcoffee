Akaybe ID’d Instance Utilities
==============================

#### Functions for working with object instances which have an `id` property. 

Xx. @todo introduction



#### `ªretrieve()`
Xx. @todo description

    ªretrieve = (instances, identifier) ->

      instance = instances[identifier]
      if ! instance
        switch typeof identifier
          when ªS
            throw new Error "'#{identifier}' does not exist"
          when ªN
            throw new Error "`#{identifier}` does not exist"
          when ªU
            throw new Error "`identifier` is `undefined`"
          else
            throw new Error "`identifier` is type '#{ªtype identifier}'"
      instance

