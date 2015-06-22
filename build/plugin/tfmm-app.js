// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.24 //// MIT Licence //// http://tfmm.loop.coop/
 *  plugin/tfmm-app.litcoffee
 */

(function() {
  var tfmm;

  $('style').innerHTML += "\n/* injected by the TfmmApp plugin */\n@import url(http://fonts.googleapis.com/css?family=Podkova:400,700);\nhtml {\n  height: 100%;\n  background: #111 url(asset/image/tfmm-main-bkgnd-v2.jpg) no-repeat;\n  background-size: cover;\n}\nbody {\n  position: absolute;\n  top:    0;\n  bottom: 0;\n  left:   0;\n  right:  0;\n  overflow: hidden;\n  text-align: center;\n  color: rgba(255,243,51,1);\n  font-family: \"Podkova\", Arial, sans-serif; \n  /* background-color: rgba(0,0,0,0); */\n  transition: background 1s;\n}\nbody.voice-set {\n  /*background-color: rgba(0,0,0,0.5);*/\n  background: #111 url(asset/image/tfmm-main-bkgnd-dark-v2.jpg) no-repeat;\n  background-size: cover;\n}\nh1 {\n  text-shadow: -0.05em 0 0 rgba(255,78,38,1);\n}\na {\n  color: rgba(255,243,51,1);\n  text-decoration: none;\n  transition: all .5s;\n}\na:hover {\n  color: rgba(255,78,38,1);\n}\narticle {\n  display: none;\n}\narticle.active,\n#apage_readme {\n  display: block;\n}\n#apage_readme h1 {\n  display: none;\n}\n#apage_readme li {\n  list-style-type: none;\n}\n#apage_readme h4 a,\n#apage_readme li a {\n  position: absolute;\n  z-index: 99;\n}\n#apage_readme h4 a,\n#apage_readme li a[href=\"http://loop.coop\"] {\n  display: block;\n  top:    1rem;\n  font: 0/0 a!important; /* hide text */\n  color: transparent!important; /* hide text */\n  opacity: 0.8;\n}\n#apage_readme h4 a {\n  right:  1rem;\n  width:  267px;\n  height: 88px;\n  background: url(asset/image/tfmm-logo-800x264.png) no-repeat;\n  background-size: contain;\n}\n#apage_readme li a[href=\"http://loop.coop\"] {\n  left:   1rem;\n  width:  200px;\n  height: 42px;\n  background: url(asset/image/tfmm-ldc-logo-266x56.png) no-repeat;\n  background-size: contain;\n}\n#apage_readme h4 a:hover,\n#apage_readme li a[href=\"http://loop.coop\"]:hover {\n  opacity: 1;\n}\n#apage_readme li a[href*=\"www.facebook.com\"] {\n  bottom: 0;\n  left:   0;\n}\n#apage_readme li a[href*=\"twitter.com\"] {\n  bottom: 0;\n  left:   100px;\n}\n#apage_readme li a[href$=\"documentation\"] {\n  bottom: 0;\n  right:  0;\n}\n\narticle[data-apage-dname=\"_doc_\"] {\n  position: absolute;\n  z-index: 99;\n  top:    15%;\n  right:  20%;\n  bottom: 20%;\n  left:   20%;\n  overflow-y: scroll;\n  text-align: left;\n  border: 4px solid cyan; \n}\n\narticle[data-apage-dname=\"_voice-set_\"] {\n  position: relative;\n  z-index: 55;\n  display: inline-block;\n  opacity: 0; /* becomes `1` when preload is complete */\n  vertical-align: top;\n  width: 8rem;\n  height: 8rem;\n  cursor: pointer;\n  border-radius: 1em;\n  overflow: hidden;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"]:hover {\n  background-color: rgba(255,243,51,0.1);\n}\narticle[data-apage-dname=\"_voice-set_\"].active {\n  border-top:    0px solid rgba(255,243,51,0);\n  width: 40rem;\n  height: 40rem;\n  border-radius: 3em;\n}\narticle[data-apage-dname=\"_voice-set_\"].active:hover {\n  background-color: rgba(255,243,51,0);\n}\narticle[data-apage-dname=\"_voice-set_\"] canvas.visualizer {\n  width: 100%;\n  height: 100%;\n}\narticle[data-apage-dname=\"_voice-set_\"] h1,\narticle[data-apage-dname=\"_voice-set_\"] p {\n  position: absolute;\n  width: 8rem;\n  opacity: 0;\n  text-align: center;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"] h1 {\n  margin-top: 40%;\n  font-size: 8px;\n}\narticle[data-apage-dname=\"_voice-set_\"] p {\n  margin-top: 53%;\n  font-size: 4px;\n}\narticle[data-apage-dname=\"_voice-set_\"].active h1 {\n  width: 40rem;\n  font-size: 80px;\n  opacity: .8;\n}\narticle[data-apage-dname=\"_voice-set_\"].active p {\n  width: 40rem;\n  font-size: 40px;\n  opacity: .9;\n}\narticle[data-apage-dname=\"_voice-set_\"] canvas.icon {\n  display: inline-block;\n  margin:  -2em .2em 0 .2em;\n  width:  1em;\n  height: 1em;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"].active canvas.icon {\n  margin:  -10em 1em 0 1em;\n  width:   5em;\n  height:  5em;\n}\n\nbody.complete article[data-apage-dname=\"_voice-set_\"] {\n  opacity: 1;\n}\nbody.complete div#progress-wrap {\n  border-top-width: 0;\n  opacity: 0;\n}\nbody.complete span#progress-bar {\n  height: 0;\n}\n\ndiv#progress-wrap {\n  position: absolute;\n  z-index: 199;\n  left:   10%;\n  right:  10%;\n  top:    50%;\n  bottom: 50%;\n  text-align: left;\n  border-top: .5em solid #f0f;\n  opacity: 1;\n  transition: all .5s;\n}\nspan#progress-bar {\n  display: inline-block;\n  background-color: orange;\n  height: .5em;\n  transition: all .5s;\n}";

  tfmm = new Tfmm({
    arts: arts,
    $$voiceSets: $$('article[data-apage-dname="_voice-set_"]')
  });

  updaters.push(tfmm.updater);

}).call(this);
