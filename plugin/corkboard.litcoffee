Corkboard
=========

#### @todo brief explanation

@todo longer discussion




Inject CSS
----------

    $ 'style'
     .innerHTML += """

    /* injected by Apage’s Corkboard plugin */
    body {
      overflow: hidden;
      text-align: center;
    }
    article {
      display: none;
    }
    article.active,
    #apage_readme {
      display: block;
    }

    #apage_readme h1 {
      display: none;
    }
    #apage_readme li {
      list-style-type: none;
    }
    #apage_readme h4 a,
    #apage_readme li a {
      position: absolute;
      z-index: 99;
      border: 4px solid blue; 
    }
    #apage_readme h4 a {
      top:    0;
      right:  0;
    }
    #apage_readme li a[href="http://loop.coop"] {
      top:    0;
      left:   0;
    }
    #apage_readme li a[href*="www.facebook.com"] {
      bottom: 0;
      left:   0;
    }
    #apage_readme li a[href*="twitter.com"] {
      bottom: 0;
      left:   100px;
    }
    #apage_readme li a[href$="documentation"] {
      bottom: 0;
      right:  0;
    }

    article[data-apage-dname="_doc_"] {
      position: absolute;
      z-index: 99;
      top:    15%;
      right:  20%;
      bottom: 20%;
      left:   20%;
      overflow-y: scroll;
      text-align: left;
      border: 4px solid cyan; 
    }

    article[data-apage-dname="_play_"] {
      position: relative;
      z-index: 55;
      display: inline-block;
      vertical-align: top;
      width: 4em;
      height: 4em;
      cursor: pointer;
      border: 4px solid magenta;
      transition: all .5s;
    }
    article[data-apage-dname="_play_"].active {
      border: 4px solid orange;
      width: 40em;
      height: 40em;
    }
    article[data-apage-dname="_play_"] canvas {
      background-color: #ccc;
      width: 100%;
      height: 100%;
    }
    """



‘Article Not Found’
-------------------

Create a ‘Not Found’ article, which works like a ‘404 Not Found’ page. 

    $ref = document.createElement 'article'
    $ref.setAttribute 'class', 'apage'
    $ref.setAttribute 'id'   , 'apage_undefined'
    $ref.innerHTML = """
    <!-- injected by Apage’s Pagination plugin -->
    <h1>Article Not Found</h1>
    """
    d.body.appendChild $ref

Record the ‘Not Found’ article in `arts`, like any other article. 

    arts.push
      id:    'undefined'
      opath: '' #@todo needed?
      dname: ''
      order: 0
      front: []
      title: 'Article Not Found'
      $ref:  $ref




Allow Article Lookup by ID
--------------------------

Allow articles to be queried '#/with/a/path'. 

    for art in arts
      arts[ art.id ] = art

Add a route to the 0th article which catches '/', eg 'http://example.com/#/'. 

    arts['_'] = arts[0] || arts.undefined;




Replace static ‘Play’ articles with dynamic `<CANVAS>` elements
---------------------------------------------------------------

Xx. 

    for $player in $$('article[data-apage-dname="_play_"]')
      do ($player) ->
        $player.innerHTML = '<canvas></canvas>'




Add Click Handlers
------------------

Xx. 

    window.addEventListener 'click', -> window.location.hash = '/'

Xx. 

    for $player in $$('article[data-apage-dname="_play_"]')
      do ($player) ->
        $player.addEventListener 'click', (event) ->
          if -1 == @.className.indexOf 'active'
            window.location.hash = @.id.substr(5).replace /_/g, '/'
          else
            console.log arts[@.id].front#'click active ', @
          event.stopPropagation()




Resolver
--------

Add the `Pagination` plugin’s resolver function to Apage’s list of resolvers. 

    resolvers.push (query) ->

        if ! query     then return { art: arts[0] }     # eg '#' or no hash
        if arts[query] then return { art: arts[query] } # eg '#57'
        query = 'apage' + query
        if arts[query] then return { art: arts[query] } # eg '#/apage_foo'
        { backstop: arts.undefined } # like a 404 error




Updater
-------

Add the `Pagination` plugin’s updater function to Apage’s list of updaters. 

    updaters.push (current) ->

When called, this updater appends the `active` class to the current article, 
and removes the `active` class from all others. The CSS injected by this plugin 
will then hide all articles except the current one. 

      for art in arts
        art.$ref.className = art.$ref.className.replace /\s*active|\s*$/g, '' #@todo better regexp
      current.$ref.className += ' active'

Update the document title, which is usually visible at the very top of the 
browser window, and is also used in the browser’s ‘History’ menu. 

      d.title = current.title








    

