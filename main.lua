-- 
-- Abstract: Preference Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local preference = require "plugin.preference"

--=======INITIAL DATA
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

--Initiate plugin with defauld data
preference.init(data,options)

--========Save data to table 
--Saving number type
preference.set("coins",20)

--Saving string type
preference.set("name","gary")

--Saving boolean
preference.set("sound",false)

--Saving perticular value in table
preference.set("chars.ironcat.max_health",20);
preference.set("chars.char_health",30);
preference.set("chars.ironcat.other.1",50);

--Replace whole inner table
preference.set("chars.ironcat",{3,6});


--Replacing table
preference.set("chars",{newTable={2,4}})


--Set fuction will save the value instantly to prefernce to file
--If you need to store locally and update after sometime use.

preference.setState("chars.newTable.3",3)
preference.setState("chars.newTable.4",3)
preference.setState("chars.newTable.5",3)

--later use save function, which will save all the data previously stored;
preference.save();

--Retreving values
local chars = preference.get("chars")
local sound = preference.get("sound")
local name = preference.get("name")
local coins = preference.get("coins")
local ironcat = preference.get("chars.ironcat");
local ironcatHealth = preference.get("chars.ironcat.max_health");
local ironcatOther1 = preference.get("chars.ironcat.other.1");

