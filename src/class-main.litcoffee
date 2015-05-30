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

        @audioCtx = new (window.AudioContext || window.webkitAudioContext)


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


#### `initVoiceSets()`

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
              maestro:   @maestro




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

Press `[q]` to trigger the voice which currently has focus. @todo other keys

        window.addEventListener 'keydown', (event) =>
          if null == @active then return
          if 81 == event.keyCode
            @active.trigger 1 # velocity

Click on the page background to return to the splash page. 

        window.addEventListener 'click', -> window.location.hash = '/'

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




