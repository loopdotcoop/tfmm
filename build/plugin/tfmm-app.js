// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.7 //// MIT Licence //// http://tfmm.loop.coop/
 *  plugin/tfmm-app.litcoffee
 */

(function() {
  var tfmm;

  $('style').innerHTML += "\n/* injected by the TfmmApp plugin */\nbody {\n  overflow: hidden;\n  text-align: center;\n  background: #111;\n  color: #ccc;\n}\na {\n  color: #ccc;\n  text-decoration: none;\n  transition: all .5s;\n}\na:hover {\n  color: #f2f;\n}\narticle {\n  display: none;\n}\narticle.active,\n#apage_readme {\n  display: block;\n}\n#apage_readme h1 {\n  display: none;\n}\n#apage_readme li {\n  list-style-type: none;\n}\n#apage_readme h4 a,\n#apage_readme li a {\n  position: absolute;\n  z-index: 99;\n  padding: .5em;\n}\n#apage_readme h4 a {\n  top:    0;\n  right:  0;\n}\n#apage_readme li a[href=\"http://loop.coop\"] {\n  top:    0;\n  left:   0;\n}\n#apage_readme li a[href*=\"www.facebook.com\"] {\n  bottom: 0;\n  left:   0;\n}\n#apage_readme li a[href*=\"twitter.com\"] {\n  bottom: 0;\n  left:   100px;\n}\n#apage_readme li a[href$=\"documentation\"] {\n  bottom: 0;\n  right:  0;\n}\n\narticle[data-apage-dname=\"_doc_\"] {\n  position: absolute;\n  z-index: 99;\n  top:    15%;\n  right:  20%;\n  bottom: 20%;\n  left:   20%;\n  overflow-y: scroll;\n  text-align: left;\n  border: 4px solid cyan; \n}\n\narticle[data-apage-dname=\"_voice-set_\"] {\n  position: relative;\n  z-index: 55;\n  display: inline-block;\n  vertical-align: top;\n  width: 4em;\n  height: 4em;\n  cursor: pointer;\n  border: 4px solid magenta;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"].active {\n  border: 4px solid orange;\n  width: 40em;\n  height: 40em;\n}\narticle[data-apage-dname=\"_voice-set_\"] canvas.visualizer {\n  width: 100%;\n  height: 100%;\n}\narticle[data-apage-dname=\"_voice-set_\"] h1,\narticle[data-apage-dname=\"_voice-set_\"] p {\n  position: absolute;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"] h1 {\n  margin-top: 0;\n  font-size: 8px;\n}\narticle[data-apage-dname=\"_voice-set_\"] p {\n  margin-top: 2em;\n  font-size: 4px;\n}\narticle[data-apage-dname=\"_voice-set_\"].active h1 {\n  font-size: 80px;\n}\narticle[data-apage-dname=\"_voice-set_\"].active p {\n  font-size: 40px;\n}\narticle[data-apage-dname=\"_voice-set_\"] canvas.icon {\n  display: inline-block;\n  margin:  -1em .1em 0 .1em;\n  width:  .5em;\n  height: .5em;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_voice-set_\"].active canvas.icon {\n  margin:  -10em 1em 0 1em;\n  width:   5em;\n  height:  5em;\n}";

  tfmm = new Tfmm({
    arts: arts,
    $$voiceSets: $$('article[data-apage-dname="_voice-set_"]')
  });

  updaters.push(tfmm.updater);

}).call(this);