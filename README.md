# Corona-preference-plugin
Preference plugin for Corona SDK to save data.
## Platforms:
This plugin works on iOS and Android
## Syntax:
```markdown
  local preference = require "plugin.preference"
```
## Functions :
### preference.init(data,options)
Should be called at start.
```markdown
preference.init(data,options)
data : Initial default data at start.
options(optional): settings that you can choose, defaults to system.DocumentsDirectory.
            baseDir: Directory to store preference, system.DocumentsDirectory or system.TemprarayDirectory
            name: Directory name  
```

### preference.set(key,value)
Used to set value to perticular key
```markdown
preference.set(key,value)
key : variable name or key name.
value : value can be string, boolean, number, table
```

### preference.get(key)
Returns the value for the key.
```markdown
local var = preference.get(key)
key : variable name or key name.
```

### preference.setState(key,value)
Similar to `set` function, but would not write to file immediately. Writes to file when
`save` function is called. Can be used where file operation can be expensive.
```markdown
preference.setState(key,value)
key : variable name or key name.
value : value can be string, boolean, number, table
```

### preference.save()
Saves all the previously set states to a file.

## Usage :

```markdown
  --Require the plugin
  local preference = require "plugin.preference"
  
  --Initiating the plugin
  local data = {
    coins = 50,
    cash=20,
    name="dave",
    sound=false,
    chars = {
      char_health = 10,
      ironcat = {
        max_health = 10,
        damage = 20,
        other = {1,0,10,5}
      },
    }
  }

  local options = {
    baseDir = system.DocumentsDirectory,-- or system.TemprarayDirectory
    name = "myPrefs",
  }
  
  preference.init(data,options);
  
```
### Saving data
  ```markdown
  preference.set("coins",20);
  preference.set("name","gary");
  ```
  You can add new data to preference.
  ```markdown
    preference.set("gender","male");
  ```
  You can save to a perticalur table value
  ```markdown
    preference.set("chars.ironcat.max_health",20);
  ```
  
  You can overide existing table
  ```markdown
    `chars` is a table, now being replaced by number value.
    preference.set("chars",20);
  ```
  You cannot push new value to an array.
  ```markdown
    preference.set("chars.ironcat.other.5",20);-- This is not possible because array size that was stored was 4.
    preference.set("chars.ironcat.other.1",20);-- This is possible because array has size of 4.
    preference.set("chars.ironcat.other",{1,0,10,5,0})--This is possible, it overrides the previos array.
    preference.set("chars.ironcat.other.5",20)--This is not possible because now the array has size of 5.
  ```
  
### Getting data
```markdown
  local sound = preference.get("sound")
```
You can get perticular value from a table
  ```markdown
    local health = preference.get("chars.ironcat.max_health");
  ```
You can access an array index value
  ```markdown
    local health = preference.get("chars.ironcat.other.1");
  ```
You can get all preference table
  ```markdown
    local tab = preference.get("");
    local health = tab.chars.ironcar.max_health
  ```

### Using `setState` and `save`
  ```markdown
    preference.set("coins",30)--saved locally and to a file. When you relaunch `coins` would be 30
    preference.setState("coins",30); -- Saved to local varaible, not to file. When you relaunch `coins`
                                     -- would be previous value 20
  ```
  To save the state use `save` fucntion
  ```markdown
    preference.save()
  ```
  `save` function saves the most recent update to a key
  ```markdown
    preference.setState("coins',30);
    preference.setState("coins',40);
    preference.save()--Saves 40 to preference.
  ```
## Advanced
### preference.create()
This is return an preference object. Its similar to above `preference` but should be used with `:` instead of `.`
It is easier not to use this function.

```markdown
     local profileObj = preference.create();
     profileObj:init(data,{name="profile"); -- Note the usage of `:`
     profileObj:set("coins",20);
     
     local statObj = preference.create();
     statObj:init(data,{name="stats");
     statObj:set("games_played",2);
```
    
     
  
## Points to remember.
*Do not have variable names with `.` in it.

*Overiding a data with different dataType is expensive, so its adviced to rather add new data.
  ```markdown
    local coins = preference.get("coins',30); --`coins` is number type.
    preference.set("coins',{20,40,30});--It is expensive.
    preference.set("coinsTable',{20,40,30});--Adviced
  ```
 *Preference is a singleton so you can load and use the preference anywhere. Unless `create` function is used.
   ```markdown
   --main.lua
   local preference = require("plugin.preference");
   preference.init({},{});
   preference.set("coins",10)
   
   --File1.lua
   local preference = require("plugin.preference");
   preference.set("coins",20)
   
   --File2.lua
   local preference = require("plugin.preference");
   preference.set("coins",80)
   ```
 *`init` function should be called only once at start.








  
