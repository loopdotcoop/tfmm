Handy Scripts
=============

#### `v:list`
Shows a list of files which contain the `version` string from ‘package.json’. 
Each filename is suffixed by a colon, followed by the line-number where the 
version string appears, eg `README.md:1 package.json:4`. 

```bash
npm run v:list
```

Which runs: 

```bash
grep -ron $npm_package_version {bin,src,*.json} | awk 1 ORS=' ' | sed "s@:$npm_package_version@@g"
```

Or verbosely: 

```bash
grep --recursive --only-matching --line-number $npm_package_version \
{bin,src,*.json} \
| \
awk 1 ORS=' ' \
| \
sed "s@:$npm_package_version@@g"
```

Which means: 

1.  Use `grep` to get a newline-delimited list of files which contain the 
    `version` string from ‘package.json’
    - `--recursive` search in subdirectories
    - `--only-matching` don’t show leading/trailing context in the results
    - `--line-number` included after a colon, eg `bower.json:3`
2.  Search in bin/, src/, package.json, bower.json, etc
3.  Pipe the list to `awk`
4.  [Convert all newlines to spaces](http://goo.gl/1WNas5)
5.  Pipe the list to `sed`
6.  Delete the trailing colon and version from each filename, eg `:1.2.3-4`




#### `v:open`
Opens a list of files which contain the `version` string from ‘package.json’ in 
Sublime Text. You will need Sublime Text installed, and a symlink to its `subl` 
binary [added to your PATH](http://goo.gl/wJqkjY). 

```bash
npm run v:open
```

Which runs: 

```bash
subl $(npm run v:list --loglevel silent)
```

Note `--loglevel silent`, which prevents `subl` from being sent the results-log 
which `npm run` usually outputs. 




