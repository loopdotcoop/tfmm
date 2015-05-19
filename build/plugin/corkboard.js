// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.4 //// MIT Licence //// http://tfmm.loop.coop/
 *  plugin/corkboard.litcoffee
 */

(function() {
  var $player, $ref, art, fn, fn1, i, j, l, len, len1, len2, ref, ref1, step, tfmms;

  $('style').innerHTML += "\n/* injected by Apage’s Corkboard plugin */\nbody {\n  overflow: hidden;\n  text-align: center;\n  background: #111;\n  color: #ccc;\n}\na {\n  color: #ccc;\n  text-decoration: none;\n  transition: all .5s;\n}\na:hover {\n  color: #f2f;\n}\narticle {\n  display: none;\n}\narticle.active,\n#apage_readme {\n  display: block;\n}\n\n#apage_readme h1 {\n  display: none;\n}\n#apage_readme li {\n  list-style-type: none;\n}\n#apage_readme h4 a,\n#apage_readme li a {\n  position: absolute;\n  z-index: 99;\n  padding: .5em;\n}\n#apage_readme h4 a {\n  top:    0;\n  right:  0;\n}\n#apage_readme li a[href=\"http://loop.coop\"] {\n  top:    0;\n  left:   0;\n}\n#apage_readme li a[href*=\"www.facebook.com\"] {\n  bottom: 0;\n  left:   0;\n}\n#apage_readme li a[href*=\"twitter.com\"] {\n  bottom: 0;\n  left:   100px;\n}\n#apage_readme li a[href$=\"documentation\"] {\n  bottom: 0;\n  right:  0;\n}\n\narticle[data-apage-dname=\"_doc_\"] {\n  position: absolute;\n  z-index: 99;\n  top:    15%;\n  right:  20%;\n  bottom: 20%;\n  left:   20%;\n  overflow-y: scroll;\n  text-align: left;\n  border: 4px solid cyan; \n}\n\narticle[data-apage-dname=\"_play_\"] {\n  position: relative;\n  z-index: 55;\n  display: inline-block;\n  vertical-align: top;\n  width: 4em;\n  height: 4em;\n  cursor: pointer;\n  border: 4px solid magenta;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_play_\"].active {\n  border: 4px solid orange;\n  width: 40em;\n  height: 40em;\n}\narticle[data-apage-dname=\"_play_\"] canvas.main {\n  width: 100%;\n  height: 100%;\n}\narticle[data-apage-dname=\"_play_\"] h1,\narticle[data-apage-dname=\"_play_\"] p {\n  position: absolute;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_play_\"] h1 {\n  margin-top: 0;\n  font-size: 8px;\n}\narticle[data-apage-dname=\"_play_\"] p {\n  margin-top: 2em;\n  font-size: 4px;\n}\narticle[data-apage-dname=\"_play_\"].active h1 {\n  font-size: 80px;\n}\narticle[data-apage-dname=\"_play_\"].active p {\n  font-size: 40px;\n}\narticle[data-apage-dname=\"_play_\"] canvas.button {\n  display: inline-block;\n  margin:  -1em .1em 0 .1em;\n  width:  .5em;\n  height: .5em;\n  transition: all .5s;\n}\narticle[data-apage-dname=\"_play_\"].active canvas.button {\n  margin:  -10em 1em 0 1em;\n  width:   5em;\n  height:  5em;\n}";

  $ref = document.createElement('article');

  $ref.setAttribute('class', 'apage');

  $ref.setAttribute('id', 'apage_undefined');

  $ref.innerHTML = "<!-- injected by Apage’s Pagination plugin -->\n<h1>Not Found!</h1>";

  d.body.appendChild($ref);

  arts.push({
    id: 'undefined',
    opath: '',
    dname: '',
    order: 0,
    front: [],
    title: 'Article Not Found',
    $ref: $ref
  });

  for (i = 0, len = arts.length; i < len; i++) {
    art = arts[i];
    arts[art.id] = art;
  }

  arts['_'] = arts[0] || arts.undefined;

  tfmms = [];

  ref = $$('article[data-apage-dname="_play_"]');
  fn = function($player) {
    var fn1, front, k, l, len2, ref1, ref2, v;
    front = {};
    ref1 = arts[$player.id].front;
    fn1 = function(k, v) {
      return front[k] = v;
    };
    for (l = 0, len2 = ref1.length; l < len2; l++) {
      ref2 = ref1[l], k = ref2[0], v = ref2[1];
      fn1(k, v);
    }
    return tfmms.push(arts[$player.id].tfmm = new window.Tfmm({
      $player: $player,
      front: front
    }));
  };
  for (j = 0, len1 = ref.length; j < len1; j++) {
    $player = ref[j];
    fn($player);
  }

  window.addEventListener('click', function() {
    return window.location.hash = '/';
  });

  ref1 = $$('article[data-apage-dname="_play_"]');
  fn1 = function($player) {
    return $player.addEventListener('click', function(event) {
      if (-1 === this.className.indexOf('active')) {
        window.location.hash = this.id.substr(5).replace(/_/g, '/');
      } else {
        console.log(arts[this.id].tfmm);
      }
      return event.stopPropagation();
    });
  };
  for (l = 0, len2 = ref1.length; l < len2; l++) {
    $player = ref1[l];
    fn1($player);
  }

  resolvers.push(function(query) {
    if (!query) {
      return {
        art: arts[0]
      };
    }
    if (arts[query]) {
      return {
        art: arts[query]
      };
    }
    query = 'apage' + query;
    if (arts[query]) {
      return {
        art: arts[query]
      };
    }
    return {
      backstop: arts.undefined
    };
  });

  updaters.push(function(current) {
    var len3, m;
    for (m = 0, len3 = arts.length; m < len3; m++) {
      art = arts[m];
      art.$ref.className = art.$ref.className.replace(/\s*active|\s*$/g, '');
    }
    current.$ref.className += ' active';
    return d.title = current.title;
  });

  step = function(stamp) {
    var fn2, len3, m, tfmm;
    fn2 = function(tfmm) {
      return tfmm.render((stamp % 10000) / 100);
    };
    for (m = 0, len3 = tfmms.length; m < len3; m++) {
      tfmm = tfmms[m];
      fn2(tfmm);
    }
    return window.requestAnimationFrame(step);
  };

  window.requestAnimationFrame(step);

}).call(this);
