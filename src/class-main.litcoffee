Main
====

#### The main app class for the Touchy Feely Music Makey microsite

    class Main
      C: ªI
      toString: -> "[object #{@C}]"

      constructor: (config={}) ->




Properties
----------


#### `audioCtx <AudioContext>`
Xx. @todo describe

        @audioCtx = @initCtxAudio()


#### `active <integer>`
The active VoiceSet in `@voiceSets`, or `null` if no VoiceSet is active. 

        @active = null


#### `arts <array>`
The array built by [Apage’s src/static-main.litcoffee](https://goo.gl/I8Kf6w). 

        @arts = config.arts


#### `maestro <Maestro>`
Create an animation controller. 

        @maestro = new Maestro
          audioCtx:  @audioCtx


#### `allVoices <array>`
Contains a reference all `Voice` instances, in the order they were created. 
Helpful for mapping `keyCode` to voice. 

        @allVoices = []


#### `$$voiceSets <live HTMLCollection>`
The instantiator should pass a collection of references to HTML elements which 
will hold the app’s VoiceSets, eg `document.getElementsByClassName('.foo')`. 

        @$$voiceSets = config.$$voiceSets


#### `voiceSets <array>`
Each .md file in /voice-set adds a VoiceSet instance to the `voiceSets` array, 
and `initVoiceSets()` also records a reference to these instances in `arts`. 

        @voiceSets = @initVoiceSets()

Tell Maestro about the VoiceSets. 

        @maestro.renderers = @voiceSets


#### `$progressWrap <HTMLDivElement>`
A `<div id="#progress-wrap">` element, to contain `$progressBar`. 

        @$progressWrap = document.createElement 'div'
        @$progressWrap.setAttribute 'id', 'progress-wrap'
        document.body.appendChild @$progressWrap


#### `$progressBar <HTMLSpanElement>`
A `<span id="#progress-bar">` element, to show AssetManager progress. 

        @$progressBar = document.createElement 'span'
        @$progressBar.setAttribute 'id', 'progress-bar'
        @$progressWrap.appendChild @$progressBar


#### `assetManager <AssetManager>`
Create an AssetManager, and start loading Assets. 

        @assetManager = @initAssetManager()
        @assetManager.load()




Methods
-------


#### `initCtxAudio()`

Xx. @todo describe

      initCtxAudio: ->
        ctxAudio = window.AudioContext || window.webkitAudioContext
        if ! ctxAudio
          alert 'Your browser does not support Web Audio, please upgrade. ' #@todo more graceful alert
          throw new Error '`AudioContext || webkitAudioContext` is falsey'
        new ctxAudio




#### `initVoiceSets()`

Xx. @todo describe

      initVoiceSets: ->

Step through each ‘voice-set’ article on the page. CoffeeScript will return 
the VoiceSets in an array, after the `for` loop has completed. 

        voiceSets = for $voiceSet in @$$voiceSets
          do ($voiceSet) =>

Get the fields from each ‘voice-set’ article’s frontmatter. 

            front = {}
            ((k,v) -> front[k] = v)(k,v) for [k,v] in @arts[$voiceSet.id].front

Instantiate a VoiceSet instance for each /voice-set/*.md file. 

            @arts[$voiceSet.id].voiceSet = new VoiceSet
              $voiceSet: $voiceSet
              front:     front
              maestro:   @maestro
              allVoices: @allVoices

Create a chain of `previous` and `next` references between VoiceSets, which 
will help us respond to `left` and `right` arrow keys. @todo and an automatic processions mode @todo move into Akaybe function

        if voiceSets.length # just in case no VoiceSets have been defined
          previous = null # to begin with, there’s no `previous` VoiceSet
          for current in voiceSets # step through in DOM order
            if previous # true if this is NOT the first loop iteration
              current.previous = previous # from the current to the previous
              previous.next    = current  # from the previous to the current
            else # true if this IS the first loop iteration
              first = current # useful after the loop has finished
            previous = current # prep for the next VoiceSet
          current.next = first # from the rightmost VoiceSet to the leftmost
          first.previous = current # from the leftmost VoiceSet to the rightmost

Return `voiceSets`, so that it can be recorded as an instance property. 

        return voiceSets




#### `initAssetManager()`

Xx. @todo describe

      initAssetManager: ->

Create an AssetManager instance. 

        assetManager = new AssetManager
          onProgress: @onLoadProgress
          onComplete: @onLoadComplete
          audioCtx:   @audioCtx

Tell the AssetManager about the Voices’ samples. 

        for voiceSet in @voiceSets
          for voice in voiceSet.voices
            assetManager.add voice.sample

Return the AssetManager instance. 

        assetManager




#### `onLoadProgress()`
- `progress <float>`  A summary of the load progress of all Assets, from 0 to 1

This method is passed to the AssetManager as `config.onProgress`. It’s used 
to update the progress bar as the Assets load.  
Note `=>` because `onLoadProgress()` is called from the AssetManager’s context. 

      onLoadProgress: (progress) =>
        @$progressBar.style.width = "#{progress * 100}%"




#### `onLoadComplete()`
- `error <string>`  Explains why the load failed, or `undefined` if successful

This method is passed to the AssetManager as `config.onComplete`. It hides the 
progress bar, and shows and enables the voice-set elements.  
Note `=>` because `onLoadComplete()` is called from the AssetManager’s context. 

      onLoadComplete: (error) =>
        if error
          ª error
        else
          document.body.setAttribute 'class', 'complete'
          @enableUserInput()
          @maestro.start()




#### `enableUserInput()`
Xx. @todo describe

      enableUserInput: ->

Accept mic input to trigger the voice which currently has focus. 

        try
          micIn = new MicIn
            ctxAudio: @audioCtx #@todo rename to `ctxAudio` everywhere
            maestro: @maestro
            callback:
              threshold: 0.5
              fn: (velocity) =>
                if null == @active then return
                @active.trigger velocity

        catch e then alert e

Respond to keyboard input. 

        window.addEventListener 'keydown', (event) =>

The number keys `1` to `9` select VoiceSets at index `0` to `8`. 

          if 49 <= event.keyCode && 57 >= event.keyCode
            @simulateClick @voiceSets[ event.keyCode - 48 - 1 ]?.$canvas

          if 97 <= event.keyCode && 105 >= event.keyCode
            @simulateClick @voiceSets[ event.keyCode - 96 - 1 ]?.$canvas

Letter keys are each assigned a Voice, which they trigger when pressed. 

          allVoicesIndex = ªkeymaps.qwerty.k2l[event.keyCode]?[2] #@todo non-QWERTY keyboard layouts
          if ªN == typeof allVoicesIndex
            @allVoices[allVoicesIndex].trigger 1 # `1` is maximum velocity

Other keypress events depend on a VoiceSet being active. 

          if null == @active then return
          #ª event.keyCode

Either of the two `0` keys triggers the voice which currently has focus. 

          if 48 == event.keyCode || 96 == event.keyCode
            @active.trigger 1 # velocity

The `left` and `right` keys shift between VoiceSets. 

          if 37 == event.keyCode
            @simulateClick @active.previous.$canvas

          if 39 == event.keyCode
            @simulateClick @active.next.$canvas


Click on the page background to return to the splash page. 

        window.addEventListener 'click', -> window.location.hash = '/'

Click on a VoiceSet article to make it the current location (if not already), 
or send the click message to its VoiceSet instance. 

        for $voiceSet in @$$voiceSets
          do ($voiceSet) ->
            $voiceSet.addEventListener 'click', (event) ->
              if ! ªhas @className, 'active' # the `<ARTICLE>`’s class attribute
                window.location.hash = @id.substr(5).replace /_/g, '/' #@todo neater solution
              else
                if ªhas event.target.className, 'visualizer'
                  arts[@.id].voiceSet.trigger 1 #@todo velocity depends on Y coord
                else if ªhas event.target.className, 'icon'
                  ª event.target #@todo trigger a one-off sample
              event.stopPropagation()




#### `updater()`
- `current <object>`  The newly-navigated-to `art` object

Xx. @todo describe

      updater: (current) => # note `=>`, because `updater()` is passed to Apage

Deactivate the previously active VoiceSet (in fact, deactivate all VoiceSets). 

        @active = null
        for voiceSet in @voiceSets
          if voiceSet.deactivate then voiceSet.deactivate() #@todo create `MicIn.deactivate()`

Activate the newly active VoiceSet. 

        if current.voiceSet
          @active = current.voiceSet
          @active.activate()




#### `simulateClick()`
- `$element <HTMLElement>`  The HTML element to click

Simulates a mouse click on the given element. 
http://mdn.beonex.com/en/DOM/element.dispatchEvent.html

      simulateClick: ($element) ->
        if $element
          evt = document.createEvent 'MouseEvents'
          evt.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, 
            false, false, false, 0, null)
          canceled = ! $element.dispatchEvent(evt)
          if (canceled)
            # A handler called preventDefault
          else
            # None of the handlers called preventDefault




