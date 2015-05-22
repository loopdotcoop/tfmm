Main Class
==========

#### Adds VoiceSets to an Apage Corkboard page

    class Main
      C: ªI
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------

#### `active <integer>`
The active VoiceSet in `@voiceSets`, or `null` if no VoiceSet is active. 

        @active = null


#### `arts <array>`
The array built by [Apage’s src/static-main.litcoffee](https://goo.gl/I8Kf6w). 

        @arts = config.arts


#### `$$voiceSets <live HTMLCollection>`
The instantiator should pass a collection of references to HTML elements which 
will hold the app’s VoiceSets, eg `document.getElementsByClassName('.foo')`. 

        @$$voiceSets = config.$$voiceSets


#### `voiceSets <array>`
Each .md file in /voice-set adds a VoiceSet instance to the `voiceSets` array, 
and `initVoiceSets()` also records a reference to these instances in `arts`. 

        @voiceSets = @initVoiceSets()


#### `maestro <Maestro>`
Create an animation controller, and start the animation. 

        @maestro = new Maestro
          renderers: @voiceSets
        @maestro.start()




Event Listeners
---------------

#### `window:keydown`
Press `[q]` to trigger the voice which currently has focus. @todo other keys

        window.addEventListener 'keydown', (event) =>
          if null == @active then return
          if 81 == event.keyCode
            @active.trigger 1 # velocity


#### `window:click`
Click on the page background to return to the splash page. 

        window.addEventListener 'click', -> window.location.hash = '/'


#### `VoiceSet:click`
Click on a VoiceSet article to make it the current location (if not already), 
or send the click message to its VoiceSet instance. 

        for $voiceSet in @$$voiceSets
          do ($voiceSet) ->
            $voiceSet.addEventListener 'click', (event) ->
              if -1 == @className.indexOf 'active'
                window.location.hash = @id.substr(5).replace /_/g, '/' #@todo neater solution
              else
                console.log arts[@.id].voiceSet #@todo react to click
              event.stopPropagation()




Methods
-------

#### `initVoiceSets()`
- `current <object>`  The newly-navigated-to `art` object

Xx. @todo describe

      initVoiceSets: ->

Step through each ‘voice-set’ article on the page. CoffeeScript will return 
the VoiceSets in an array, after the `for` loop has completed. 

        for $voiceSet in @$$voiceSets
          do ($voiceSet) =>

Get the fields from each ‘voice-set’ article’s frontmatter. 

            front = {}
            ((k,v) -> front[k] = v)(k,v) for [k,v] in @arts[$voiceSet.id].front

Instantiate a VoiceSet instance for each /voice-set/*.md file. 

            @arts[$voiceSet.id].voiceSet = new VoiceSet
              $voiceSet: $voiceSet
              front:     front




#### `updater()`
- `current <object>`  The newly-navigated-to `art` object

Xx. @todo describe

      updater: (current) => # note `=>`, because `updater()` is passed to Apage

Deactivate the previously active VoiceSet (in fact, deactivate all VoiceSets). 

        @active = null
        for voiceSet in @voiceSets
          voiceSet.deactivate()

Activate the newly active VoiceSet. 

        if current.voiceSet
          @active = current.voiceSet
          @active.activate()
