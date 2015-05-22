TfmmApp
=======

#### @todo brief explanation

@todo longer discussion




Inject CSS
----------

    $ 'style'
     .innerHTML += """

    /* injected by the TfmmApp plugin */
    body {
      overflow: hidden;
      text-align: center;
      background: #111;
      color: #ccc;
    }
    a {
      color: #ccc;
      text-decoration: none;
      transition: all .5s;
    }
    a:hover {
      color: #f2f;
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
      padding: .5em;
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

    article[data-apage-dname="_voice-set_"] {
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
    article[data-apage-dname="_voice-set_"].active {
      border: 4px solid orange;
      width: 40em;
      height: 40em;
    }
    article[data-apage-dname="_voice-set_"] canvas.visualizer {
      width: 100%;
      height: 100%;
    }
    article[data-apage-dname="_voice-set_"] h1,
    article[data-apage-dname="_voice-set_"] p {
      position: absolute;
      transition: all .5s;
    }
    article[data-apage-dname="_voice-set_"] h1 {
      margin-top: 0;
      font-size: 8px;
    }
    article[data-apage-dname="_voice-set_"] p {
      margin-top: 2em;
      font-size: 4px;
    }
    article[data-apage-dname="_voice-set_"].active h1 {
      font-size: 80px;
    }
    article[data-apage-dname="_voice-set_"].active p {
      font-size: 40px;
    }
    article[data-apage-dname="_voice-set_"] canvas.icon {
      display: inline-block;
      margin:  -1em .1em 0 .1em;
      width:  .5em;
      height: .5em;
      transition: all .5s;
    }
    article[data-apage-dname="_voice-set_"].active canvas.icon {
      margin:  -10em 1em 0 1em;
      width:   5em;
      height:  5em;
    }
    """




Init the Tfmm Instance
----------------------

    tfmm = new Tfmm
      arts:        arts
      $$voiceSets: $$ 'article[data-apage-dname="_voice-set_"]'




Updater
-------

Add the `TfmmApp` plugin’s updater function to Apage’s list of updaters. When 
the URL hash changes, `tfmm.updater()` will deactivate the previously active 
VoiceSet. If the URL hash now points to a VoiceSet, it will be activated. 

    updaters.push tfmm.updater



