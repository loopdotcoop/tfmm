// Generated by CoffeeScript 1.9.2

/*! Tfmm 0.0.1 //// MIT Licence //// http://tfmm.loop.coop/ */

(function() {
  var Tfmm, Tudor, tudor, ª, ªA, ªB, ªE, ªF, ªI, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªclone, ªex, ªhas, ªpopulate, ªredefine, ªretrieve, ªtype, ªuid,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  ªI = 'Tfmm';

  ªV = '0.0.1';

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

  Tfmm = (function() {
    Tfmm.prototype.I = ªI;

    Tfmm.prototype.ID = function() {
      return ªuid(this.I.toLowerCase());
    };

    Tfmm.prototype.toString = function() {
      return "[object " + this.I + "]";
    };

    function Tfmm(config) {
      var fn1, key, value;
      if (config == null) {
        config = {};
      }
      fn1 = (function(_this) {
        return function(key, value) {
          if ('_' === key.substr(0, 1)) {
            ª(key);
            return ªredefine(_this, key, value, 'private');
          } else if (/^[_A-Z]+$/.test(key)) {
            if (ªF === typeof value) {
              value = _this[key]();
            }
            return ªredefine(_this, key, value, 'constant');
          }
        };
      })(this);
      for (key in this) {
        value = this[key];
        fn1(key, value);
      }
      ªredefine(this, 'toString', this.toString, 'constant');
      ªredefine(this, 'valueOf', this.valueOf, 'constant');
      Object.freeze(this);
    }

    return Tfmm;

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

  Tudor = (function() {
    Tudor.prototype.I = 'Tudor';

    Tudor.prototype.toString = function() {
      return "[object " + I + "]";
    };

    Tudor.prototype.articles = [];

    function Tudor(opt) {
      this.opt = opt != null ? opt : {};
      this["do"] = bind(this["do"], this);
      switch (this.opt.format) {
        case 'html':
          this.pageHead = function(summary) {
            return "<style>\n  body     { font-family: sans-serif; }\n  a        { outline: 0; }\n  b        { display: inline-block; width: .7em }\n\n  b.pass              { color: #393 }\n  b.fail              { color: #bbb }\n  article.fail b.pass { color: #bbb }\n  section.fail b.pass { color: #bbb }\n\n  pre      { padding: .5em; margin: .2em 0; border-radius: 4px; }\n  pre.fn   { background-color: #fde }\n  pre.pass { background-color: #cfc }\n  pre.fail { background-color: #d8e0e8 }\n\n  article  { margin-bottom: .5rem }\n  article h2 { padding-left:.5rem; margin:0; font-weight:normal }\n  article.pass { border-left: 5px solid #9c9 }\n  article.fail { border-left: 5px solid #9bf }\n  article.fail h2 { margin-bottom: .5rem }\n  article.pass >div { display: none }\n\n  section  { margin-bottom: .5rem }\n  section h3   { padding-left: .5rem; margin: 0; }\n  section.pass { border-left: 3px solid #9c9 }\n  section.fail { border-left: 3px solid #9bf }\n  section.fail h3 { margin-bottom: .5rem }\n  section.pass >div { display: none }\n\n  article.fail section.pass { border-left-color: #ccc }\n\n  div      { padding-left: .5em; }\n  div.fail { border-left: 3px solid #9bf; font-size: .8rem }\n  div h4   { margin: 0 }\n  div h4 { font: normal .8rem/1.2rem monaco, monospace }\n  div.fail, div.fail h4 { margin: .5rem 0 }\n\n</style>\n<h4><a href=\"#end\" id=\"top\">\u2b07</a>  " + summary + "</h4>";
          };
          this.pageFoot = function(summary) {
            return "<h4><a href=\"#top\" id=\"end\">\u2b06</a>  " + summary + "</h4>\n<script>\n  document.title='" + (summary.replace(/<\/?[^>]+>/g, '')) + "';\n</script>";
          };
          this.articleHead = function(heading, fail) {
            return ("<article class=\"" + (fail ? 'fail' : 'pass') + "\">") + ("<h2>" + (fail ? this.cross : this.tick) + heading + "</h2><div>");
          };
          this.articleFoot = '</div></article>';
          this.sectionHead = function(heading, fail) {
            return ("<section class=\"" + (fail ? 'fail' : 'pass') + "\">") + ("<h3>" + (fail ? this.cross : this.tick) + heading + "</h3><div>");
          };
          this.sectionFoot = '</div></section>';
          this.jobFormat = function(heading, result) {
            return ("<div class=\"" + (result ? 'fail' : 'pass') + "\">") + ("<h4>" + (result ? this.cross : this.tick) + heading + "</h4>") + ("" + (result ? this.formatError(result) : '')) + "</div>";
          };
          this.tick = '<b class="pass">\u2713</b> ';
          this.cross = '<b class="fail">\u2718</b> ';
          break;
        default:
          this.pageHead = function(summary) {
            return "" + summary;
          };
          this.pageFoot = function(summary) {
            return "\n" + summary;
          };
          this.articleHead = function(heading, fail) {
            return "\n" + (fail ? this.cross : this.tick) + " " + heading + "\n===" + (new Array(heading.length).join('=')) + "\n";
          };
          this.articleFoot = '';
          this.sectionHead = function(heading, fail) {
            return "\n" + (fail ? this.cross : this.tick) + " " + heading + "\n---" + (new Array(heading.length).join('-')) + "\n";
          };
          this.sectionFoot = '';
          this.jobFormat = function(heading, result) {
            return ((result ? this.cross : this.tick) + " " + heading) + ("" + (result ? '\n' + this.formatError(result) : ''));
          };
          this.jobFoot = '';
          this.tick = '\u2713';
          this.cross = '\u2718';
      }
    }

    Tudor.prototype.add = function(lines) {
      var article, i, line, runner, section;
      article = {
        sections: []
      };
      runner = null;
      section = null;
      if (ªA !== ªtype(lines)) {
        throw new Error("`lines` isn’t an array");
      }
      if (0 === lines.length) {
        throw new Error("`lines` has no elements");
      }
      if (ªS !== ªtype(lines[0])) {
        throw new Error("`lines[0]` isn’t a string");
      }
      article.heading = lines.shift();
      i = 0;
      while (i < lines.length) {
        line = lines[i];
        switch (ªtype(line)) {
          case ªO:
            if (!line.runner) {
              throw new Error("Errant object");
            }
            runner = line.runner;
            break;
          case ªF:
            section.jobs.push(line);
            break;
          case ªS:
            if (this.isAssertion(lines[i + 1], lines[i + 2])) {
              if (!section) {
                throw new Error("Cannot add an assertion here");
              }
              section.jobs.push([runner, line, lines[++i], lines[++i]]);
            } else {
              section = {
                heading: line,
                jobs: []
              };
              article.sections.push(section);
            }
        }
        i++;
      }
      return this.articles.push(article);
    };

    Tudor.prototype["do"] = function() {
      var actual, art, artFail, artPass, article, e, error, expect, heading, j, job, k, l, len, len1, len2, mock, pge, pgeFail, pgePass, ref, ref1, ref2, result, runner, sec, secFail, secPass, section, summary;
      pge = [];
      mock = null;
      pgePass = pgeFail = 0;
      ref = this.articles;
      for (j = 0, len = ref.length; j < len; j++) {
        article = ref[j];
        art = [];
        artPass = artFail = 0;
        ref1 = article.sections;
        for (k = 0, len1 = ref1.length; k < len1; k++) {
          section = ref1[k];
          sec = [];
          secPass = secFail = 0;
          ref2 = section.jobs;
          for (l = 0, len2 = ref2.length; l < len2; l++) {
            job = ref2[l];
            switch (ªtype(job)) {
              case ªF:
                try {
                  mock = job(mock);
                } catch (_error) {
                  e = _error;
                  error = e.message;
                }
                if (error) {
                  sec.push(this.formatMockModifierError(job, error));
                }
                break;
              case ªA:
                runner = job[0], heading = job[1], expect = job[2], actual = job[3];
                result = runner(expect, actual, mock);
                if (!result) {
                  sec.push(this.jobFormat("" + (this.sanitize(heading))));
                  pgePass++;
                  artPass++;
                  secPass++;
                } else {
                  sec.push(this.jobFormat("" + (this.sanitize(heading)), result));
                  pgeFail++;
                  artFail++;
                  secFail++;
                }
            }
          }
          sec.unshift(this.sectionHead("" + (this.sanitize(section.heading)), secFail));
          sec.push(this.sectionFoot);
          art = art.concat(sec);
        }
        art.unshift(this.articleHead("" + (this.sanitize(article.heading)), artFail));
        art.push(this.articleFoot);
        pge = pge.concat(art);
        summary = pgeFail ? this.cross + " FAILED " + pgeFail + "/" + (pgePass + pgeFail) : this.tick + " Passed " + pgePass + "/" + (pgePass + pgeFail);
      }
      pge.unshift(this.pageHead(summary));
      pge.push(this.pageFoot(summary));
      return pge.join('\n');
    };

    Tudor.prototype.formatError = function(result) {
      switch (result.length + "-" + this.opt.format) {
        case '2-html':
          return result[0] + "\n<pre class=\"fail\">" + (this.sanitize(result[1].message)) + "</pre>";
        case '2-plain':
          return result[0] + "\n" + (this.sanitize(result[1].message));
        case '3-html':
          return "<pre class=\"fail\">" + (this.sanitize(this.reveal(result[0]))) + "</pre>\n..." + result[1] + "...\n<pre class=\"pass\">" + (this.sanitize(this.reveal(result[2]))) + "</pre>";
        case '3-plain':
          return (this.sanitize(this.reveal(result[0]))) + "\n..." + result[1] + "...\n" + (this.sanitize(this.reveal(result[2])));
        case '4-html':
          return "<pre class=\"fail\">" + (this.sanitize(this.reveal(result[0]))) + " (" + (ªtype(result[0])) + ")</pre>\n..." + result[1] + "...\n<pre class=\"pass\">" + (this.sanitize(this.reveal(result[2]))) + " (" + (ªtype(result[2])) + ")</pre>";
        case '4-plain':
          return (this.sanitize(this.reveal(result[0]))) + " (" + (ªtype(result[0])) + ")\n..." + result[1] + "...\n" + (this.sanitize(this.reveal(result[2]))) + " (" + (ªtype(result[2])) + ")";
        default:
          throw new Error("Cannot process '" + result.length + "-" + this.opt.format + "'");
      }
    };

    Tudor.prototype.formatMockModifierError = function(fn, error) {
      switch (this.opt.format) {
        case 'html':
          return "<pre class=\"fn\">" + (this.sanitize(fn + '')) + "</pre>\n...encountered an exception:\n<pre class=\"fail\">" + (this.sanitize(error)) + "</pre>";
        default:
          return (this.sanitize(fn + '')) + "\n...encountered an exception:\n" + (this.sanitize(error));
      }
    };

    Tudor.prototype.reveal = function(value) {
      return value != null ? value.toString().replace(/^\s+|\s+$/g, function(match) {
        return '\u00b7' + (new Array(match.length)).join('\u00b7');
      }) : void 0;
    };

    Tudor.prototype.sanitize = function(value) {
      switch (this.opt.format) {
        case 'html':
          return value != null ? value.toString().replace(/</g, '&lt;') : void 0;
        default:
          return value;
      }
    };

    Tudor.prototype["throw"] = {
      runner: function(expect, actual, mock) {
        var e, error;
        error = false;
        try {
          actual(mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (!error) {
          return ['No exception thrown, expected', expect];
        } else if (expect !== error.message) {
          return [error.message, 'was thrown, but expected', expect];
        }
      }
    };

    Tudor.prototype.equal = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual(mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (expect !== result) {
          if (result + '' === expect + '') {
            return [result, 'was returned, but expected', expect, true];
          } else {
            return [result, 'was returned, but expected', expect];
          }
        }
      }
    };

    Tudor.prototype.is = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual(mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (expect !== ªtype(result)) {
          return ["type " + (ªtype(result)), 'was returned, but expected', "type " + expect];
        }
      }
    };

    Tudor.prototype.match = {
      runner: function(expect, actual, mock) {
        var e, error, result;
        error = false;
        try {
          result = actual(mock);
        } catch (_error) {
          e = _error;
          error = e;
        }
        if (error) {
          return ['Unexpected exception', error];
        } else if (ªF !== typeof expect.test) {
          return [
            '`test()` is not a function', {
              message: expect
            }
          ];
        } else if (!expect.test('' + result)) {
          return ['' + result, 'failed test', expect];
        }
      }
    };

    Tudor.prototype.isAssertion = function(line1, line2) {
      if (ªF !== ªtype(line2)) {
        return false;
      }
      if ((ªO === ªtype(line1)) && ªF === ªtype(line1.runner)) {
        return false;
      }
      return true;
    };

    return Tudor;

  })();

  tudor = new Tudor({
    format: ªO === typeof window ? 'html' : 'plain'
  });

  Tfmm.runTest = tudor["do"];

  tudor.add([
    "01 Tfmm Constructor Usage", "The class and instance are expected types", tudor.is, "The class is a function", ªF, function() {
      return Tfmm;
    }, function() {
      return new Tfmm;
    }, "An instance is an object", ªO, function(mock) {
      return mock;
    }, tudor.equal, "The class is an `instanceof` a `Function`", true, function() {
      return Tfmm instanceof Function;
    }, "An instance is an `instanceof` an `Object`", true, function(mock) {
      return mock instanceof Object;
    }, "An instance is an `instanceof` the class", true, function(mock) {
      return mock instanceof Tfmm;
    }, "Public members exist, and are accessible as expected", "Enumerable properties as expected", 'I,ID,toString,valueOf', function(mock) {
      var prop;
      return ((function() {
        var results;
        results = [];
        for (prop in mock) {
          results.push(prop);
        }
        return results;
      })()).join();
    }, "`I` is 'Tfmm' and immutable", 'Tfmm', function(mock) {
      mock.I = 'x';
      return mock.I;
    }, "`toString()` is auto-assigned and immutable", '[object Tfmm]', function(mock) {
      mock.toString = function() {
        return 'x';
      };
      return mock.toString();
    }, "`valueOf()` is the instance itself and immutable", true, function(mock) {
      mock.valueOf = function() {
        return 'x';
      };
      return mock === mock.valueOf();
    }, tudor.match, "`ID` is auto-assigned and immutable", /^tfmm_[0-9]{16}$/, function(mock) {
      mock.ID = 'tfmm_1234567890123456';
      return mock.ID;
    }, "An extending class can override `I`", "An extending class can override `ID`", "Private members are only accessible via getters and setters", "auto-assigned ids are unique", "Basic `config`"
  ]);

}).call(this);
