Export Module
=============

#### The module’s only entry-point is the `Tfmm` class

First, try defining an AMD module, eg for [RequireJS](http://requirejs.org/). 

    if ªF == typeof define and define.amd
      define -> Tfmm

Next, try exporting for CommonJS, eg for [Node](http://goo.gl/Lf84YI):  
`var foo = require('foo');`

    else if ªO == typeof module and module and module.exports
      module.exports = Tfmm

Otherwise, add the `Tfmm` class to global scope. Browser usage would be:  
`var foo = new window.Foo();`

    else @[ªI] = Tfmm




