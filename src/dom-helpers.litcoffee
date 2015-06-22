DOM Helpers
===========

#### Helper functions for the HTML Document Object Model


#### `$()`
Xx. 

    $ = document.querySelector.bind document




#### `$$()`
Xx. 

    $$ = document.querySelectorAll.bind document




#### `vpSize()`
Returns an array with two elements, the viewport width and the viewport height. 
Based on [this Stack Overflow answer. ](http://stackoverflow.com/a/11744120)


    vpSize = ->
      d = document
      e = d.documentElement
      b = d.getElementsByTagName('body')[0]
      w = window.innerWidth  || e.clientWidth  || b.clientWidth
      h = window.innerHeight || e.clientHeight || b.clientHeight
      #w = window.screen.width
      #h = window.screen.height
      [w,h]




