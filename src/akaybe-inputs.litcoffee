Akaybe Inputs
==================

#### Functions and objects which help deal with input events. 




#### `ªkeymaps`
Xx. 

    ªkeymaps = 

First, define the ‘QWERTY’ layout, used in many English and Spanish speaking 
countries. [Details here.](http://en.wikipedia.org/wiki/QWERTY) 

      qwerty:

Define a lookup-table which maps `event.keyCode` to an array representing the 
key’s physical location on a QWERTY keyboard, and also its index (0 to 25). 

        k2l:

Top row of keys, `Q` to `P`. 

          81: [0,0,0]
          87: [1,0,1]
          69: [2,0,2]
          82: [3,0,3]
          84: [4,0,4]
          89: [5,0,5]
          85: [6,0,6]
          73: [7,0,7]
          79: [8,0,8]
          80: [9,0,9]

Middle row of keys, `A` to `L`. 

          65: [0,1,10]
          83: [1,1,11]
          68: [2,1,12]
          70: [3,1,13]
          71: [4,1,14]
          72: [5,1,15]
          74: [6,1,16]
          75: [7,1,17]
          76: [8,1,18]

Bottom row of keys, `Z` to `M`. 

          90: [0,2,19]
          88: [1,2,20]
          67: [2,2,21]
          86: [3,2,22]
          66: [4,2,23]
          78: [5,2,24]
          77: [6,2,25]

Generate a reverse-lookup, of index to key character. 

    ªkeymaps.qwerty.i2c = []
    for keyCode,[col,row,i] of ªkeymaps.qwerty.k2l
      ªkeymaps.qwerty.i2c[i] = String.fromCharCode keyCode

    ª ªkeymaps.qwerty.i2c


@todo duplicate `qwerty` and modify it for other layouts. 
See http://en.wikipedia.org/wiki/Keyboard_layout

