TfmmApp
=======

#### @todo brief explanation

@todo longer discussion

@todo update Apage so it collects `@import` statements and renders them all before any other CSS
@todo remove hack from node_modules/apage/build/apage.js:432:240
@todo remove hack from node_modules/apage/build/apage.js:432:447
@todo remove hack from node_modules/apage/build/apage.js:438:73


Inject CSS
----------

    $ 'style'
     .innerHTML += """

    /* injected by the TfmmApp plugin */
    html {
      height: 100%;
      background: #111 url(asset/image/tfmm-main-bkgnd-v2.jpg) no-repeat;
      background-size: cover;
    }
    body {
      position: absolute;
      top:    0;
      bottom: 0;
      left:   0;
      right:  0;
      overflow: hidden;
      text-align: center;
      color: rgba(255,243,51,1);
      font-family: "Podkova", Arial, sans-serif; 
      /* background-color: rgba(0,0,0,0); */
      transition: background 1s;
    }
    body.voice-set {
      /*background-color: rgba(0,0,0,0.5);*/
      /* background: #111 url(asset/image/tfmm-main-bkgnd-dark-v2.jpg) no-repeat; */
      background-size: cover;
    }
    a {
      color: rgba(255,243,51,1);
      text-decoration: none;
      transition: all .5s;
    }
    a:hover {
      color: rgba(255,78,38,1);
    }
    article {
      display: none;
    }
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
    }
    #apage_readme h4 a,
    #apage_readme li a[href="http://loop.coop"] {
      display: block;
      top:    1rem;
      font: 0/0 a!important; /* hide text */
      color: transparent!important; /* hide text */
      opacity: 0.8;
    }
    #apage_readme h4 a {
      right:  1rem;
      width:  267px;
      height: 88px;
      background: url(asset/image/tfmm-logo-800x264.png) no-repeat;
      background-size: contain;
    }
    #apage_readme li a[href="http://loop.coop"] {
      left:   1rem;
      width:  200px;
      height: 42px;
      background: url(asset/image/tfmm-ldc-logo-266x56.png) no-repeat;
      background-size: contain;
    }
    #apage_readme h4 a:hover,
    #apage_readme li a[href="http://loop.coop"]:hover {
      opacity: 1;
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
      /* position: relative;    */ /* Use Actile style instead */
      /* z-index: 55;           */ /* Use Actile style instead */
      /* display: inline-block; */ /* Use Actile style instead */
      /* vertical-align: top;   */ /* Use Actile style instead */
      /* width: 8rem;           */ /* Use Actile style instead */
      /* height: 8rem;          */ /* Use Actile style instead */
      /* transition: all .5s;   */ /* Use Actile style instead */
      cursor: pointer;
      overflow: hidden;
      opacity: 0; /* becomes `1` when preload is complete */
    }
    article[data-apage-dname="_voice-set_"]:hover {
      background-color: rgba(255,243,51,0.1);
    }
    article[data-apage-dname="_voice-set_"].active {
      /* width: 40rem;          */ /* Use Actile style instead */
      /* height: 40rem;         */ /* Use Actile style instead */
    }
    article[data-apage-dname="_voice-set_"].active:hover {
      background-color: rgba(255,243,51,0);
    }
    article[data-apage-dname="_voice-set_"] canvas.visualizer {
      width: 100%;
      height: 100%;
    }
    article[data-apage-dname="_voice-set_"] h1,
    article[data-apage-dname="_voice-set_"] p {
      position: absolute;
      left: 0;
      right: 0;
      text-align: center;
      transition: all .5s;
    }
    article[data-apage-dname="_voice-set_"] h1 {
      bottom: 12%;
      font-size: 110px;
      opacity: .8;
    }
    article[data-apage-dname="_voice-set_"] p {
      bottom: 11%;
      font-size: 40px;
      opacity: 0;
    }
    article[data-apage-dname="_voice-set_"].active h1 {
      text-shadow: -0.05em 0 0 rgba(255,78,38,1);
    }
    article[data-apage-dname="_voice-set_"].active p {
      opacity: .9;
    }

    article[data-apage-dname="_voice-set_"] h2.label {
      position:  relative;
      display:   inline-block;
      bottom:    20%;
      width:     2rem;
      height:    10rem;
      left:      5%;
      font-size: 90px;
    }
    article[data-apage-dname="_voice-set_"] canvas.icon {
      position:  relative;
      display:   inline-block;
      bottom:    24%;
      width:     6rem;
      height:    4rem;
    }
    article[data-apage-dname="_voice-set_"].active h2.label {
    }
    article[data-apage-dname="_voice-set_"].active canvas.icon {
      width:     7rem;
      height:    7rem;
    }

    body.complete article[data-apage-dname="_voice-set_"] {
      opacity: 1;
    }
    body.complete div#progress-wrap {
      border-top-width: 0;
      opacity: 0;
    }
    body.complete span#progress-bar {
      height: 0;
    }

    div#progress-wrap {
      position: absolute;
      z-index: 199;
      left:   10%;
      right:  10%;
      top:    50%;
      bottom: 50%;
      text-align: left;
      border-top: .5em solid #f0f;
      opacity: 1;
      transition: all .5s;
    }
    span#progress-bar {
      display: inline-block;
      background-color: orange;
      height: .5em;
      transition: all .5s;
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



