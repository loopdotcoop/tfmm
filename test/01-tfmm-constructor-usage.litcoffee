Typical instantiation of the `Tfmm` class

    tudor.add [
      "01 Tfmm Constructor Usage"




      "The class and instance are expected types"


      tudor.is

      "The class is a function"
      ªF
      -> Tfmm

      -> new Tfmm

      "An instance is an object"
      ªO
      (mock) -> mock


      tudor.equal

      "The class is an `instanceof` a `Function`"
      true
      -> Tfmm instanceof Function

      "An instance is an `instanceof` an `Object`"
      true
      (mock) -> mock instanceof Object

      "An instance is an `instanceof` the class"
      true
      (mock) -> mock instanceof Tfmm




      "Public members exist, and are accessible as expected"


      "Enumerable properties as expected"
      'I,ID,toString,valueOf'
      (mock) -> (prop for prop of mock).join()


      "`I` is 'Tfmm' and immutable"
      'Tfmm'
      (mock) -> mock.I = 'x'; mock.I

      "`toString()` is auto-assigned and immutable"
      '[object Tfmm]'
      (mock) -> (mock.toString = -> 'x'); mock.toString()

      "`valueOf()` is the instance itself and immutable"
      true
      (mock) -> (mock.valueOf = -> 'x'); mock == mock.valueOf()

      tudor.match
      "`ID` is auto-assigned and immutable"
      /^tfmm_[0-9]{16}$/
      (mock) -> mock.ID = 'tfmm_1234567890123456'; mock.ID




      "An extending class can override `I`"




      "An extending class can override `ID`"




      "Private members are only accessible via getters and setters"




      "auto-assigned ids are unique" #@todo more rigorous testing




      "Basic `config`"


    ]
