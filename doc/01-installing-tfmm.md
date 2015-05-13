Installing Tfmm
===============

Old fashioned browser install, providing `window.Tfmm`: 
```html
<script src="http://tfmm.loop.coop/build/tfmm.js"></script>
<script>console.log( new window.Tfmm().I ); // -> 'Tfmm'</script>
```

Install as a [CommonJS Module](http://goo.gl/ZrbaB0), eg for 
[Node](https://nodejs.org/): 
```javascript
var Tfmm = require('tfmm');
console.log( new Tfmm().I ); // -> 'Tfmm'
```

Install using [RequireJS inline-style](http://goo.gl/mp7Snw), providing `Tfmm` 
as an argument: 
```html
<script src="lib/require.js"></script>
<script>
  require(['path/to/tfmm'], function(Tfmm) {
    console.log( new Tfmm().I ); // -> 'Tfmm'
  })
</script>
```

@todo more installation examples




