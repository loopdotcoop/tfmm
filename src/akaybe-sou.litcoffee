Akaybe Simple Object Utilities
==============================

#### Functions which operate on simple objects. 

A ‘simple object’ is defined as a standard JavaScript object created using the 
`{}` syntax, whose values are any of the following types: 

- `boolean`
- `number`
- `string`
- `undefined`
- `null`

Since simple objects cannot contain arrays or objects, the `sou` functions are 
much easier to use and understand. 




#### `ªpopulate()`
Checks whether a candidate’s keys and values conform to a given set of rules. 
If `candidate` breaks any rules, `ªpopulate()` returns an array of error 
messages, one for each broken rule. Otherwise, it populates `subject` with new 
values and returns `undefined`. 

    ªpopulate = (candidate, subject, rules, updating) ->

      if ªO != ªtype candidate
        throw new Error "`candidate` is type '#{ªtype candidate}' not 'object'"

Every `rule` must contain four elements:

- `key  <string>` Specifies the key to be tested
- `use  <sotype>` `undefined` for mandatory keys, else the default value to use
- `use   <array>` Where element 0 is a function, and the rest are arguments
- `type <string>` The expected result when `ªtype()` is called on the value
- `test <object>` An object with `test()` and `toString()` methods, eg a regexp

Enforce each `rule` in the `rules` array. 

      errors = []
      for rule in rules

Destructure the rule, and get the canditate’s value (if present). 

        [key,use,type,test] = rule
        value = candidate[key]

Deal with a missing value. This can be safely ignored if `rule` supplies a 
default, or if `ªpopulate()` has been called in `updating` mode. @todo test `updating` mode

        if undefined == value
          if updating or undefined != use then continue # not an error
          else errors.push "Missing field '#{key}' is mandatory"

Make sure that the value is of expected `type`, and passes the `test`. 

        else if type != ªtype value
          errors.push "Field '#{key}' is type '#{ªtype value}' not '#{type}'"
        else if ! test.test value
          errors.push "Field '#{key}' is '#{value}' which fails #{'' + test}" #@todo sanitize `value`

Throw an exception for an invalid `candidate`. 

      if errors.length then throw new Error errors.join '\n'

Record the candidate’s values in the subject. 

      for rule in rules
        [key,use,type,test] = rule
        value = candidate[key]

Deal with a missing value. Otherwise record the candidate’s value. @todo thoroughly test this logic

        if undefined == value
          if undefined == subject[key]
            if ªA == ªtype use
              subject[key] = use[0].apply @, use.slice 1
            else
              subject[key] = use
        else
          subject[key] = value

Return `undefined`, to signify no errors were encountered. 

      return




#### `ªclone()`
Uses an array of keys or rules (see `ªpopulate()` above) to clone `subject`. 

    ªclone = (subject, rules) ->
      out = {}
      for rule in rules
        key = if ªS == typeof rule then rule else rule[0]
        out[key] = subject[key]
      out




