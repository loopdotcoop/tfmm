// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.6 //// MIT Licence //// http://tfmm.loop.coop/ */

(function() {
  var Flourish, Tfmm, Timeline, Voice, ª, ªA, ªB, ªE, ªF, ªI, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªclone, ªex, ªhas, ªpopulate, ªredefine, ªretrieve, ªtype, ªuid;

  ªI = 'Tfmm';

  ªV = '0.0.6';

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

  ªpopulate = function(candidate, subject, rules, updating) {
    var errors, j, k, key, len, len1, rule, test, type, use, value;
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
    for (k = 0, len1 = rules.length; k < len1; k++) {
      rule = rules[k];
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

  Flourish = (function() {
    Flourish.prototype.C = 'Flourish';

    Flourish.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Flourish(config) {
      if (config == null) {
        config = {};
      }
      this.start = config.start;
      this.duration = config.duration;
      this.velocity = config.velocity;
    }

    Flourish.prototype.render = function(now, context, size) {
      var pos, scale, thing;
      if (this.start + this.duration < now) {
        return;
      }
      if (this.start > now) {
        return;
      }
      thing = 1 - 1 / (this.duration / (now - this.start));
      scale = size * this.velocity * thing;
      pos = (size - scale) / 2;
      return context.fillRect(pos, pos, scale, scale);
    };

    return Flourish;

  })();

  Tfmm = (function() {
    Tfmm.prototype.C = 'Tfmm';

    Tfmm.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    Tfmm.prototype.receptive = 0;

    Tfmm.prototype.size = 32;

    function Tfmm(config) {
      var color, j, len, ref;
      if (config == null) {
        config = {};
      }
      this.ID = config.$player.id;
      this.POINTS = config.front.points.split(/\s+/);
      this.COLORS = config.front.colors.split(/\s+/);
      if (5 < this.COLORS.length) {
        throw new Error("'" + this.ID + "' frontmatter contains " + this.COLORS.length + " colors");
      }
      if (config.$player) {
        this.$canvas = document.createElement('canvas');
        this.$canvas.setAttribute('width', this.size + 'px');
        this.$canvas.setAttribute('height', this.size + 'px');
        this.$canvas.setAttribute('class', 'main');
        this.main = this.$canvas.getContext('2d');
        config.$player.appendChild(this.$canvas);
        this.voices = [];
        ref = this.COLORS;
        for (j = 0, len = ref.length; j < len; j++) {
          color = ref[j];
          this.voices.push(new Voice({
            $player: config.$player,
            color: color,
            main: this.main
          }));
        }
        this.voices[0].receptive = true;
      }
    }

    Tfmm.prototype.activate = function() {
      var j, len, ref, results, voice;
      this.size = 256;
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

    Tfmm.prototype.deactivate = function() {
      var j, len, ref, results, voice;
      this.size = 32;
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

    Tfmm.prototype.render = function(frame) {
      var j, k, l, len, len1, len2, ref, ref1, ref2, voice;
      this.main.clearRect(0, 0, this.size, this.size);
      if (frame.flip2000) {
        ref = this.voices;
        for (j = 0, len = ref.length; j < len; j++) {
          voice = ref[j];
          voice.receptive = false;
        }
        if (this.voices.length <= ++this.receptive) {
          this.receptive = 0;
        }
        this.voices[this.receptive].receptive = true;
      }
      if (frame.flip8000) {
        ref1 = this.voices;
        for (k = 0, len1 = ref1.length; k < len1; k++) {
          voice = ref1[k];
          voice.timeline.quieten(0.5, 0.1);
        }
      }
      ref2 = this.voices;
      for (l = 0, len2 = ref2.length; l < len2; l++) {
        voice = ref2[l];
        voice.render(frame, this.size);
      }
      this.main.fillStyle = "rgba(0,100,0,.5)";
      return this.main.fillRect(0, 0, frame.frac8000 * this.size, frame.frac8000 * this.size);
    };

    Tfmm.prototype.trigger = function(velocity) {
      return this.voices[this.receptive].timeline.add(velocity);
    };

    return Tfmm;

  })();

  Timeline = (function() {
    Timeline.prototype.C = 'Timeline';

    Timeline.prototype.toString = function() {
      return "[object " + this.C + "]";
    };

    function Timeline(config) {
      if (config == null) {
        config = {};
      }
      this.flourishes = [];
      this.now = 0;
    }

    Timeline.prototype.add = function(velocity) {
      return this.flourishes.push(new Flourish({
        start: this.now,
        duration: 0.2,
        velocity: velocity
      }));
    };

    Timeline.prototype.render = function(frame, context, size) {
      var flourish, j, len, ref, results;
      this.now = frame.frac2000;
      ref = this.flourishes;
      results = [];
      for (j = 0, len = ref.length; j < len; j++) {
        flourish = ref[j];
        results.push(flourish.render(this.now, context, size));
      }
      return results;
    };

    Timeline.prototype.quieten = function(multiplier, threshold) {
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

    return Timeline;

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
      this.timeline = new Timeline;
      this.receptive = false;
      this.size = 8;
      this.$canvas = document.createElement('canvas');
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      this.$canvas.setAttribute('class', 'icon');
      config.$player.appendChild(this.$canvas);
      this.icon = this.$canvas.getContext('2d');
      this.main = config.main;
      this.color = this.icon.fillStyle = config.color;
    }

    Voice.prototype.activate = function() {
      this.size = 64;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      return this.icon.fillStyle = this.color;
    };

    Voice.prototype.deactivate = function() {
      this.size = 8;
      this.$canvas.setAttribute('width', this.size + 'px');
      this.$canvas.setAttribute('height', this.size + 'px');
      return this.icon.fillStyle = this.color;
    };

    Voice.prototype.render = function(frame, mainSize) {
      var scaleMultiplier;
      scaleMultiplier = this.receptive ? 1 : 0.5;
      this.icon.clearRect(0, 0, this.size, this.size);
      this.drawSquare(this.icon, frame.frac8000 * scaleMultiplier, this.size);
      this.main.fillStyle = this.color;
      return this.timeline.render(frame, this.main, mainSize);
    };

    Voice.prototype.drawSquare = function(ctx, scale, size) {
      var pos;
      scale = size * scale;
      pos = (size - scale) / 2;
      return ctx.fillRect(pos, pos, scale, scale);
    };

    return Voice;

  })();

  if (ªF === typeof define && define.amd) {
    define(function() {
      return Tfmm;
    });
  } else if (ªO === typeof module && module && module.exports) {
    module.exports = Tfmm;
  } else {
    this[ªI] = Tfmm;
  }

}).call(this);
