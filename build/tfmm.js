// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.21 //// MIT Licence //// http://tfmm.loop.coop/ */

(function() {
  var Asset, AssetManager, Blot, Flourish, Maestro, Main, MicIn, Voice, VoiceSet, ª, ªA, ªB, ªE, ªF, ªI, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªclone, ªex, ªhas, ªkeymaps, ªpopulate, ªredefine, ªretrieve, ªtype, ªuid,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ªI = 'Tfmm';

  ªV = '0.0.21';

  ªA = 'array';

  ªB = 'boolean';

  ªE = 'error';

  ªF = 'function';

  ªN = 'number';

  ªO = 'object';

  ªR = 'regexp';

  ªS = 'string';

  ªU = 'undefined';

  ªX = 'null';

  ª = console.log.bind(console);

  ªex = function(x, a, b) {
    var pos;
    if (-1 === (pos = a.indexOf(x))) {
      return x;
    } else {
      return b.charAt(pos);
    }
  };

  ªhas = function(h, n, t, f) {
    if (t == null) {
      t = true;
    }
    if (f == null) {
      f = false;
    }
    if (-1 !== h.indexOf(n)) {
      return t;
    } else {
      return f;
    }
  };

  ªtype = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  ªuid = function(p) {
    return p + '_' + (Math.random() + '1111111111111111').slice(2, 18);
  };

  ªredefine = function(obj, name, value, kind) {
    switch (kind) {
      case 'constant':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: true
        });
      case 'private':
        return Object.defineProperty(obj, name, {
          value: value,
          enumerable: false
        });
    }
  };

  ªretrieve = function(instances, identifier) {
    var instance;
    instance = instances[identifier];
    if (!instance) {
      switch (typeof identifier) {
        case ªS:
          throw new Error("'" + identifier + "' does not exist");
          break;
        case ªN:
          throw new Error("`" + identifier + "` does not exist");
          break;
        case ªU:
          throw new Error("`identifier` is `undefined`");
          break;
        default:
          throw new Error("`identifier` is type '" + (ªtype(identifier)) + "'");
      }
    }
    return instance;
  };

  ªkeymaps = {
    qwerty: {
      k2l: {
        81: [0, 0, 0],
        87: [1, 0, 1],
        69: [2, 0, 2],
        82: [3, 0, 3],
        84: [4, 0, 4],
        89: [5, 0, 5],
        85: [6, 0, 6],
        73: [7, 0, 7],
        79: [8, 0, 8],
        80: [9, 0, 9],
        65: [0, 1, 10],
        83: [1, 1, 11],
        68: [2, 1, 12],
        70: [3, 1, 13],
        71: [4, 1, 14],
        72: [5, 1, 15],
        74: [6, 1, 16],
        75: [7, 1, 17],
        76: [8, 1, 18],
        90: [0, 2, 19],
        88: [1, 2, 20],
        67: [2, 2, 21],
        86: [3, 2, 22],
        66: [4, 2, 23],
        78: [5, 2, 24],
        77: [6, 2, 25]
      }
    }
  };

  ªpopulate = function(candidate, subject, rules, updating) {
    var errors, j, key, len, len1, m, rule, test, type, use, value;
    if (ªO !== ªtype(candidate)) {
      throw new Error("`candidate` is type '" + (ªtype(candidate)) + "' not 'object'");
    }
    errors = [];
    for (j = 0, len = rules.length; j < len; j++) {
      rule = rules[j];
      key = rule[0], use = rule[1], type = rule[2], test = rule[3];
      value = candidate[key];
      if (void 0 === value) {
        if (updating || void 0 !== use) {
          continue;
        } else {
          errors.push("Missing field '" + key + "' is mandatory");
        }
      } else if (type !== ªtype(value)) {
        errors.push("Field '" + key + "' is type '" + (ªtype(value)) + "' not '" + type + "'");
      } else if (!test.test(value)) {
        errors.push("Field '" + key + "' is '" + value + "' which fails " + ('' + test));
      }
    }
    if (errors.length) {
      throw new Error(errors.join('\n'));
    }
    for (m = 0, len1 = rules.length; m < len1; m++) {
      rule = rules[m];
      key = rule[0], use = rule[1], type = rule[2], test = rule[3];
      value = candidate[key];
      if (void 0 === value) {
        if (void 0 === subject[key]) {
          if (ªA === ªtype(use)) {
            subject[key] = use[0].apply(this, use.slice(1));
          } else {
            subject[key] = use;
          }
        }
      } else {
        subject[key] = value;
      }
    }
  };

  ªclone = function(subject, rules) {
    var j, key, len, out, rule;
    out = {};
    for (j = 0, len = rules.length; j < len; j++) {
      rule = rules[j];
      key = ªS === typeof rule ? rule : rule[0];
      out[key] = subject[key];
    }
    return out;
  };

  Asset = (function() {
    Asset.prototype.C = 'Asset';

    Asset.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Asset(config) {
      if (config == null) {
        config = {};
      }
      this.setManager = bind(this.setManager, this);
      this.completeHandler = bind(this.completeHandler, this);
      this.loadHandler = bind(this.loadHandler, this);
      this.abortHandler = bind(this.abortHandler, this);
      this.errorHandler = bind(this.errorHandler, this);
      this.progressHandler = bind(this.progressHandler, this);
      this.state = 'init';
      this.progress = 0;
      this.manager = null;
      this.url = config.url;
      this.request = null;
      this.buffer = null;
    }

    Asset.prototype.load = function() {
      if ('init' !== this.state) {
        return 0;
      }
      this.state = 'loading';
      this.request = new XMLHttpRequest;
      this.request.addEventListener('progress', this.progressHandler, false);
      this.request.addEventListener('error', this.errorHandler, false);
      this.request.addEventListener('abort', this.abortHandler, false);
      this.request.addEventListener('load', this.loadHandler, false);
      this.request.open('GET', this.url, true);
      this.request.responseType = 'arraybuffer';
      this.request.send();
      return 1;
    };

    Asset.prototype.progressHandler = function(event) {
      if (event.lengthComputable) {
        this.progress = event.loaded / event.total;
        return this.manager.progressHandler();
      }
    };

    Asset.prototype.errorHandler = function(event) {
      ª(event);
      return this.manager.completeHandler('oh no, error!');
    };

    Asset.prototype.abortHandler = function(event) {
      ª(event);
      return this.manager.completeHandler('oh no, abort!');
    };

    Asset.prototype.loadHandler = function() {
      if (200 !== this.request.status) {
        return this.manager.completeHandler("Load error, status " + this.request.status);
      } else {
        this.state = 'processing';
        this.progress = 1;
        return this.manager.audioCtx.decodeAudioData(this.request.response, this.completeHandler, this.errorHandler);
      }
    };

    Asset.prototype.completeHandler = function(buffer) {
      this.buffer = buffer;
      this.state = 'complete';
      return this.manager.completeHandler();
    };

    Asset.prototype.setManager = function(manager) {
      if (!(manager instanceof AssetManager)) {
        throw new Error("`manager` must be an instance of `AssetManager`");
      }
      return this.manager = manager;
    };

    return Asset;

  })();

  AssetManager = (function() {
    AssetManager.prototype.C = 'AssetManager';

    AssetManager.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function AssetManager(config) {
      if (config == null) {
        config = {};
      }
      this.audioCtx = config.audioCtx;
      this.progress = 0;
      this.assets = [];
      this.onProgress = config.onProgress || function() {};
      this.onComplete = config.onComplete || function() {};
    }

    AssetManager.prototype.add = function(asset) {
      if (!(asset instanceof Asset)) {
        throw new Error("`asset` must be an instance of `Asset`");
      }
      asset.setManager(this);
      this.assets.push(asset);
      return this;
    };

    AssetManager.prototype.load = function() {
      var asset;
      return ((function() {
        var j, len, ref, results;
        ref = this.assets;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          asset = ref[j];
          results.push(asset.load());
        }
        return results;
      }).call(this)).reduce(function(a, b) {
        return a + b;
      });
    };

    AssetManager.prototype.progressHandler = function() {
      var i, progress;
      progress = 0;
      i = this.assets.length;
      while (i--) {
        progress += this.assets[i].progress;
      }
      return this.onProgress(progress / this.assets.length);
    };

    AssetManager.prototype.completeHandler = function(error) {
      var i;
      if (error) {
        return this.onComplete(error);
      }
      i = this.assets.length;
      while (i--) {
        if ('complete' !== this.assets[i].state) {
          return;
        }
      }
      return this.onComplete();
    };

    return AssetManager;

  })();

  Blot = (function() {
    Blot.prototype.C = 'Blot';

    Blot.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Blot(config) {
      if (config == null) {
        config = {};
      }
      this.xx = null;
    }

    return Blot;

  })();

  Blot.square = function(time, velocity, ctx2d, size) {
    var scale, topleft;
    scale = size * velocity * (1 - time);
    topleft = (size - scale) / 4;
    return ctx2d.fillRect(topleft, topleft, scale, scale);
  };

  Blot.circle = function(time, velocity, ctx2d, size) {
    var center, radius;
    radius = size * velocity * (1 - time);
    center = size / 2;
    ctx2d.beginPath();
    ctx2d.arc(center, center, radius / 2, 0, 2 * Math.PI);
    return ctx2d.fill();
  };

  Blot.triangle = function(time, velocity, ctx2d, size) {
    var center, halfScale, scale;
    scale = size * velocity * (1 - time);
    halfScale = scale / 2;
    center = size / 2;
    ctx2d.beginPath();
    ctx2d.moveTo(center, center - halfScale);
    ctx2d.lineTo(center + halfScale, center + scale);
    ctx2d.lineTo(center - halfScale, center + scale);
    return ctx2d.fill();
  };

  Blot.dots = function(time, velocity, ctx2d, size) {
    var i;
    i = 5;
    while (--i) {
      ctx2d.setTransform(1 / i * velocity, 0, 0, .5 / i, ((size * i) / 4 - (size / 4)) / 2, size / 2 - (size / 4 * velocity));
      Blot.circle(time, velocity, ctx2d, size);
    }
    return ctx2d.setTransform(1, 0, 0, 1, 0, 0);
  };

  Blot.galaxy = function(time, velocity, ctx2d, size) {
    var i;
    time = 1 - time;
    i = 5;
    while (i--) {
      ctx2d.setTransform(.5 / time, 0, 0, .5 / time / i, size / i / 4, size / 4);
      Blot.circle(time, velocity, ctx2d, size);
    }
    return ctx2d.setTransform(1, 0, 0, 1, 0, 0);
  };

  Blot.oddtriangle = function(time, velocity, ctx2d, size) {
    var center, halfScale, scale;
    scale = size * velocity * (1 - time);
    halfScale = scale / 2;
    center = size / 2;
    ctx2d.beginPath();
    ctx2d.moveTo(center, center - halfScale);
    ctx2d.lineTo(center + halfScale, scale);
    ctx2d.lineTo(center - halfScale, scale);
    return ctx2d.fill();
  };

  Flourish = (function() {
    Flourish.prototype.C = 'Flourish';

    Flourish.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Flourish(config) {
      if (config == null) {
        config = {};
      }
      this.voice = config.voice;
      this.blotRenderer = config.blotRenderer;
      this.hasScheduled = false;
      this.start = config.start;
      this.duration = config.duration;
      this.velocity = config.velocity;
    }

    Flourish.prototype.render = function(frame, ctx2d, size) {
      var now, time;
      now = frame.frac2000;
      if (this.start + this.duration < now) {
        return;
      }
      if (this.start > now) {
        return this.lookahead(now, frame);
      }
      this.hasScheduled = false;
      time = 1 / (this.duration / (now - this.start));
      return this.blotRenderer(time, this.velocity, ctx2d, size);
    };

    Flourish.prototype.lookahead = function(now, frame) {
      if (this.hasScheduled || this.start > now + 0.1) {
        return;
      }
      this.hasScheduled = true;
      return this.voice.play(this.velocity, frame.stamp + (this.start - now) * 2000);
    };

    return Flourish;

  })();

  Maestro = (function() {
    Maestro.prototype.C = 'Maestro';

    Maestro.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Maestro(config) {
      if (config == null) {
        config = {};
      }
      this.step = bind(this.step, this);
      this.audioCtx = config.audioCtx;
      this.renderers = config.renderers || [];
      if (config.raf) {
        this.raf = config.raf.bind(this);
      } else {
        this.raf = window.requestAnimationFrame.bind(window);
      }
      this.prevFlip2000 = -1;
    }

    Maestro.prototype.start = function() {
      return this.raf(this.step);
    };

    Maestro.prototype.step = function(stamp) {
      var cue, currFlip2000, flip2000, flip8000, fn, j, len, ref, renderer;
      currFlip2000 = stamp % 2000;
      if (currFlip2000 >= this.prevFlip2000) {
        flip2000 = false;
      } else {
        flip2000 = true;
        if (currFlip2000 === stamp % 8000) {
          flip8000 = true;
        } else {
          flip8000 = false;
        }
      }
      this.prevFlip2000 = currFlip2000;
      cue = {
        stamp: stamp,
        flip2000: flip2000,
        flip8000: flip8000,
        frac2000: (stamp % 2000) / 2000,
        frac8000: (stamp % 8000) / 8000
      };
      ref = this.renderers;
      fn = function(renderer) {
        return renderer.render(cue);
      };
      for (j = 0, len = ref.length; j < len; j++) {
        renderer = ref[j];
        fn(renderer);
      }
      return this.raf(this.step);
    };

    return Maestro;

  })();

  Main = (function() {
    Main.prototype.C = ªI;

    Main.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Main(config) {
      if (config == null) {
        config = {};
      }
      this.updater = bind(this.updater, this);
      this.onLoadComplete = bind(this.onLoadComplete, this);
      this.onLoadProgress = bind(this.onLoadProgress, this);
      this.audioCtx = this.initCtxAudio();
      this.active = null;
      this.arts = config.arts;
      this.maestro = new Maestro({
        audioCtx: this.audioCtx
      });
      this.allVoices = [];
      this.$$voiceSets = config.$$voiceSets;
      this.voiceSets = this.initVoiceSets();
      this.maestro.renderers = this.voiceSets;
      this.$progressWrap = document.createElement('div');
      this.$progressWrap.setAttribute('id', 'progress-wrap');
      document.body.appendChild(this.$progressWrap);
      this.$progressBar = document.createElement('span');
      this.$progressBar.setAttribute('id', 'progress-bar');
      this.$progressWrap.appendChild(this.$progressBar);
      this.assetManager = this.initAssetManager();
      this.assetManager.load();
    }

    Main.prototype.initCtxAudio = function() {
      var ctxAudio;
      ctxAudio = window.AudioContext || window.webkitAudioContext;
      if (!ctxAudio) {
        alert('Your browser does not support Web Audio, please upgrade. ');
        throw new Error('`AudioContext || webkitAudioContext` is falsey');
      }
      return new ctxAudio;
    };

    Main.prototype.initVoiceSets = function() {
      var $voiceSet, current, first, j, len, previous, voiceSets;
      voiceSets = (function() {
        var j, len, ref, results;
        ref = this.$$voiceSets;
        results = [];
        for (j = 0, len = ref.length; j < len; j++) {
          $voiceSet = ref[j];
          results.push((function(_this) {
            return function($voiceSet) {
              var fn, front, k, len1, m, ref1, ref2, v;
              front = {};
              ref1 = _this.arts[$voiceSet.id].front;
              fn = function(k, v) {
                return front[k] = v;
              };
              for (m = 0, len1 = ref1.length; m < len1; m++) {
                ref2 = ref1[m], k = ref2[0], v = ref2[1];
                fn(k, v);
              }
              return _this.arts[$voiceSet.id].voiceSet = new VoiceSet({
                $voiceSet: $voiceSet,
                front: front,
                maestro: _this.maestro,
                allVoices: _this.allVoices
              });
            };
          })(this)($voiceSet));
        }
        return results;
      }).call(this);
      if (voiceSets.length) {
        previous = null;
        for (j = 0, len = voiceSets.length; j < len; j++) {
          current = voiceSets[j];
          if (previous) {
            current.previous = previous;
            previous.next = current;
          } else {
            first = current;
          }
          previous = current;
        }
        current.next = first;
        first.previous = current;
      }
      return voiceSets;
    };

    Main.prototype.initAssetManager = function() {
      var assetManager, j, len, len1, m, ref, ref1, voice, voiceSet;
      assetManager = new AssetManager({
        onProgress: this.onLoadProgress,
        onComplete: this.onLoadComplete,
        audioCtx: this.audioCtx
      });
      ref = this.voiceSets;
      for (j = 0, len = ref.length; j < len; j++) {
        voiceSet = ref[j];
        ref1 = voiceSet.voices;
        for (m = 0, len1 = ref1.length; m < len1; m++) {
          voice = ref1[m];
          assetManager.add(voice.sample);
        }
      }
      return assetManager;
    };

    Main.prototype.onLoadProgress = function(progress) {
      return this.$progressBar.style.width = (progress * 100) + "%";
    };

    Main.prototype.onLoadComplete = function(error) {
      if (error) {
        return ª(error);
      } else {
        document.body.setAttribute('class', 'complete');
        this.enableUserInput();
        return this.maestro.start();
      }
    };

    Main.prototype.enableUserInput = function() {
      var $voiceSet, e, j, len, micIn, ref, results;
      try {
        micIn = new MicIn({
          ctxAudio: this.audioCtx,
          maestro: this.maestro,
          callback: {
            threshold: 0.5,
            fn: (function(_this) {
              return function(velocity) {
                if (null === _this.active) {
                  return;
                }
                return _this.active.trigger(velocity);
              };
            })(this)
          }
        });
      } catch (_error) {
        e = _error;
        alert(e);
      }
      window.addEventListener('keydown', (function(_this) {
        return function(event) {
          var allVoicesIndex, ref, ref1, ref2;
          if (49 <= event.keyCode && 57 >= event.keyCode) {
            _this.simulateClick((ref = _this.voiceSets[event.keyCode - 48 - 1]) != null ? ref.$canvas : void 0);
          }
          if (97 <= event.keyCode && 105 >= event.keyCode) {
            _this.simulateClick((ref1 = _this.voiceSets[event.keyCode - 96 - 1]) != null ? ref1.$canvas : void 0);
          }
          allVoicesIndex = (ref2 = ªkeymaps.qwerty.k2l[event.keyCode]) != null ? ref2[2] : void 0;
          if (ªN === typeof allVoicesIndex) {
            _this.allVoices[allVoicesIndex].trigger(1);
          }
          if (null === _this.active) {
            return;
          }
          if (48 === event.keyCode || 96 === event.keyCode) {
            _this.active.trigger(1);
          }
          if (37 === event.keyCode) {
            _this.simulateClick(_this.active.previous.$canvas);
          }
          if (39 === event.keyCode) {
            return _this.simulateClick(_this.active.next.$canvas);
          }
        };
      })(this));
      window.addEventListener('click', function() {
        return window.location.hash = '/';
      });
      ref = this.$$voiceSets;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        $voiceSet = ref[j];
        results.push((function($voiceSet) {
          return $voiceSet.addEventListener('click', function(event) {
            if (!ªhas(this.className, 'active')) {
              window.location.hash = this.id.substr(5).replace(/_/g, '/');
            } else {
              if (ªhas(event.target.className, 'visualizer')) {
                arts[this.id].voiceSet.trigger(1);
              } else if (ªhas(event.target.className, 'icon')) {
                ª(event.target);
              }
            }
            return event.stopPropagation();
          });
        })($voiceSet));
      }
      return results;
    };

    Main.prototype.updater = function(current) {
      var j, len, ref, voiceSet;
      this.active = null;
      ref = this.voiceSets;
      for (j = 0, len = ref.length; j < len; j++) {
        voiceSet = ref[j];
        if (voiceSet.deactivate) {
          voiceSet.deactivate();
        }
      }
      if (current.voiceSet) {
        this.active = current.voiceSet;
        return this.active.activate();
      }
    };

    Main.prototype.simulateClick = function($element) {
      var canceled, evt;
      if ($element) {
        evt = document.createEvent('MouseEvents');
        evt.initMouseEvent('click', true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        canceled = !$element.dispatchEvent(evt);
        if (canceled) {

        } else {

        }
      }
    };

    return Main;

  })();

  MicIn = (function() {
    MicIn.prototype.C = 'MicIn';

    MicIn.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function MicIn(config) {
      if (config == null) {
        config = {};
      }
      this.render = bind(this.render, this);
      this.initStream = bind(this.initStream, this);
      this.callbacks = [];
      if (config.callback) {
        this.callbacks.push(config.callback);
      }
      this.ctxAudio = config.ctxAudio;
      if (!this.ctxAudio) {
        throw new Error('`config.ctxAudio` not provided!');
      }
      this.maestro = config.maestro;
      if (!this.maestro) {
        throw new Error('`config.maestro` not provided!');
      }
      this.initUserMedia();
    }

    MicIn.prototype.initUserMedia = function() {
      return;
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
      if (!navigator.getUserMedia) {
        throw new Error('getUserMedia not supported!');
      }
      return navigator.getUserMedia({
        audio: true,
        video: false
      }, this.initStream, function(error) {
        if (/^Permission(Dismissed|Denied)Error$/.test(error.name)) {
          return ª("`getUserMedia()` got a '" + error.name + "'");
        } else {
          throw new Error('`getUserMedia()` error: ' + error.name);
        }
      });
    };

    MicIn.prototype.initStream = function(stream) {
      this.streamSource = this.ctxAudio.createMediaStreamSource(stream, 2);
      this.analyser = this.ctxAudio.createAnalyser();
      this.analyser.fftSize = 2048;
      this.bufferLength = this.analyser.frequencyBinCount;
      this.dataArray = new Uint8Array(this.bufferLength);
      this.streamSource.connect(this.analyser);
      return this.maestro.renderers.push(this);
    };

    MicIn.prototype.render = function(cue) {
      var highestPeak, i;
      this.analyser.getByteTimeDomainData(this.dataArray);
      highestPeak = 0;
      i = this.bufferLength;
      while (i--) {
        highestPeak = Math.max(highestPeak, this.dataArray[i]);
      }
      highestPeak = highestPeak / 128.0 - 1;
      if (0.3 < highestPeak) {
        return this.callbacks[0].fn(highestPeak * highestPeak);
      }
    };

    return MicIn;

  })();

  Voice = (function() {
    Voice.prototype.C = 'Voice';

    Voice.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Voice(config) {
      if (config == null) {
        config = {};
      }
      this.flourishes = [];
      this.now = {};
      this.maestro = config.maestro;
      this.hasFocus = false;
      this.size = 16;
      this.$canvas = document.createElement('canvas');
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      this.$canvas.setAttribute('class', 'icon');
      config.$voiceSet.appendChild(this.$canvas);
      this.icon = this.$canvas.getContext('2d');
      this.visualizer = config.visualizer;
      this.color = this.icon.fillStyle = config.color;
      this.sample = new Asset({
        url: "asset/audio/" + config.sample + ".mp3"
      });
      this.blotRenderer = config.blotRenderer;
    }

    Voice.prototype.activate = function() {
      this.size = 64;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      return this.icon.fillStyle = this.color;
    };

    Voice.prototype.deactivate = function() {
      this.size = 16;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      return this.icon.fillStyle = this.color;
    };

    Voice.prototype.render = function(frame, visSize) {
      var flourish, j, len, ref, results, time;
      this.now = frame;
      this.icon.clearRect(0, 0, this.size, this.size);
      time = 0.5 > frame.frac2000 ? 1 - frame.frac2000 : frame.frac2000;
      time = (time - 0.5) / 4;
      time += !this.hasFocus ? 0.6 : 0.3;
      this.blotRenderer(time, 1, this.icon, this.size);
      this.visualizer.fillStyle = this.color;
      ref = this.flourishes;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        flourish = ref[j];
        results.push(flourish.render(frame, this.visualizer, visSize));
      }
      return results;
    };

    Voice.prototype.trigger = function(velocity) {
      this.flourishes.push(new Flourish({
        start: this.now.frac2000,
        duration: 0.2,
        velocity: velocity,
        voice: this,
        blotRenderer: this.blotRenderer
      }));
      return this.play(velocity, 0);
    };

    Voice.prototype.play = function(velocity, stamp) {
      var gainNode, source;
      source = this.maestro.audioCtx.createBufferSource();
      source.buffer = this.sample.buffer;
      gainNode = this.maestro.audioCtx.createGain();
      source.connect(gainNode);
      gainNode.connect(this.maestro.audioCtx.destination);
      gainNode.gain.value = velocity;
      return source.start(stamp / 1000);
    };

    Voice.prototype.quieten = function(multiplier, threshold) {
      var flourish, i, results;
      i = this.flourishes.length;
      results = [];
      while (i--) {
        flourish = this.flourishes[i];
        flourish.velocity *= multiplier;
        if (threshold >= flourish.velocity) {
          results.push(this.flourishes.splice(i, 1));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };

    return Voice;

  })();

  VoiceSet = (function() {
    VoiceSet.prototype.C = 'VoiceSet';

    VoiceSet.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function VoiceSet(config) {
      var i, voice;
      if (config == null) {
        config = {};
      }
      this.maestro = config.maestro;
      this.ID = config.$voiceSet.id;
      this.allVoices = config.allVoices;
      this.focus = 0;
      this.size = 128;
      this.points = config.front.points.split(/\s+/);
      this.bkgnd = config.front.bkgnd;
      this.colors = config.front.colors.split(/\s+/);
      this.samples = config.front.samples.split(/\s+/);
      this.blots = config.front.blots.split(/\s+/);
      if (5 < this.colors.length) {
        throw new Error("'" + this.ID + "' frontmatter contains " + this.colors.length + " colors");
      }
      if (this.samples.length !== this.colors.length) {
        throw new Error("'" + this.ID + "' frontmatter contains unequal colors and samples");
      }
      if (this.blots.length !== this.colors.length) {
        throw new Error("'" + this.ID + "' frontmatter contains unequal colors and blots");
      }
      this.$canvas = document.createElement('canvas');
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      this.$canvas.setAttribute('class', 'visualizer');
      config.$voiceSet.appendChild(this.$canvas);
      this.visualizer = this.$canvas.getContext('2d');
      this.visualizer.globalCompositeOperation = 'screen';
      this.voices = [];
      i = this.colors.length;
      while (i--) {
        voice = new Voice({
          $voiceSet: config.$voiceSet,
          color: this.colors[i],
          sample: this.samples[i],
          blotRenderer: Blot[this.blots[i]],
          visualizer: this.visualizer,
          maestro: this.maestro
        });
        this.voices.push(voice);
        this.allVoices.push(voice);
      }
      this.voices[0].focus = true;
    }

    VoiceSet.prototype.activate = function() {
      var j, len, ref, results, voice;
      this.size = 512;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      ref = this.voices;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        voice = ref[j];
        results.push(voice.activate());
      }
      return results;
    };

    VoiceSet.prototype.deactivate = function() {
      var j, len, ref, results, voice;
      this.size = 128;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      ref = this.voices;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        voice = ref[j];
        results.push(voice.deactivate());
      }
      return results;
    };

    VoiceSet.prototype.render = function(frame) {
      var i, j, l, len, len1, len2, m, o, ref, ref1, ref2, voice, y;
      if (frame.flip2000) {
        ref = this.voices;
        for (j = 0, len = ref.length; j < len; j++) {
          voice = ref[j];
          voice.hasFocus = false;
        }
        if (this.voices.length <= ++this.focus) {
          this.focus = 0;
        }
        this.voices[this.focus].hasFocus = true;
        ref1 = this.voices;
        for (m = 0, len1 = ref1.length; m < len1; m++) {
          voice = ref1[m];
          voice.quieten(0.8, 0.05);
        }
      }
      this.visualizer.beginPath();
      this.visualizer.moveTo(this.points[0] * this.size, this.points[1] * this.size);
      l = this.points.length;
      i = 2;
      while (i < l) {
        this.visualizer.lineTo(this.points[i++] * this.size, this.points[i++] * this.size);
      }
      i = l - 3;
      while (i > 0) {
        y = this.points[i--] * this.size * .95;
        this.visualizer.lineTo((1 - this.points[i--]) * this.size, y);
      }
      this.visualizer.clip();
      this.visualizer.clearRect(0, 0, this.size, this.size);
      this.visualizer.fillStyle = this.bkgnd;
      this.visualizer.fillRect(0, 0, this.size, this.size);
      this.visualizer.globalCompositeOperation = 'screen';
      ref2 = this.voices;
      for (o = 0, len2 = ref2.length; o < len2; o++) {
        voice = ref2[o];
        voice.render(frame, this.size);
      }
      this.visualizer.setTransform(-1, 0, 0, 1, this.size, 0);
      this.visualizer.drawImage(this.$canvas, 0, 0);
      return this.visualizer.setTransform(1, 0, 0, 1, 0, 0);
    };

    VoiceSet.prototype.trigger = function(velocity) {
      return this.voices[this.focus].trigger(velocity);
    };

    return VoiceSet;

  })();

  if (ªF === typeof define && define.amd) {
    define(function() {
      return Main;
    });
  } else if (ªO === typeof module && module && module.exports) {
    module.exports = Main;
  } else {
    this[ªI] = Main;
  }

}).call(this);
