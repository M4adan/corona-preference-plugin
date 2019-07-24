-- 
-- Abstract: Preference Library Plugin Test Project
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2015 Corona Labs Inc. All Rights Reserved.
--
------------------------------------------------------------

-- Load plugin library
local preference = require "plugin.preference"

local function printTable ( t, label, level )
	-- Validate params
	assert(
		"table" == type(t),
		"Bad argument 1 to 'printTable' (table expected, got " .. type(t) .. ")" )

	if label then print( label ) end
	level = level or 1

	for k,v in pairs( t ) do
		-- Indent according to nesting 'level'
		local prefix = ""
		for i=1,level do
			prefix = prefix .. "\t"
		end

		-- Print key/value pair
		print( prefix .. "[" .. tostring(k) .. "] = " .. tostring(v) )

		-- Recurse on tables
		if type( v ) == "table" then
			print( prefix .. "{" )
			printTable( v, nil, level + 1 )
			print( prefix .. "}" )
		end
	end
end

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

-------------IMPORTANT------------------
--I am concatinating ..math.random(100,10000) for testing only.
--Reopening the app will always give same results for testing.
--For actual project have `name` property as constant.
--Changing `name` value always will create new preference and all old data will be lost.
print("IMPORTANT: Have `name` as Constant")

--Strictly for this demo only, Use below options for your purpose
local options = {
	baseDir = system.DocumentsDirectory,-- or system.TemprarayDirectory
	name = "myPrefs"..math.random(100,10000),
}

--For your use
-- local options = {
-- 	baseDir = system.DocumentsDirectory,-- or system.TemprarayDirectory
-- 	name = "myPrefs",
-- }

--Initiate plugin with defauld data
preference.init(data,options)


print("==Data after initiating the app== ")
printTable(preference.get(),nil,1);

print("")

-- ========Save data to table 
--Saving number type
print("==Saving number type")
print("		Present `coins` value : ",preference.get("coins"))
preference.set("coins",20)
print("		Using command `preference.set('coins',20)`")
print("		Expected : 20, Result :",preference.get("coins"))

print("")

-- Saving string type
print("==Saving string type")
print("		Present `name` value : ",preference.get("name"))
preference.set("name","gary")
print("		Using command `preference.set('name','gary')`")
print("		Expected : `gary`, Result :",preference.get("name"))

print("")

-- --Saving boolean
print("==Saving boolean type")
print("		Present `sound` value : ",preference.get("sound"))
preference.set("sound",true)
print("		Using command `preference.set('sound',true)`")
print("		Expected : `true`,Result :",preference.get("sound"))

print("")

--You can save perticular value in table
print("==You can save perticular value in table")
--We can change perticular value in a table or array, works also for nested tables.
print("		Test 1 : changing nested table" )
print("			We have table `chars`, holding a table `ironcat` which has some properties.")
print("		 	Present `chars.ironcat.max_health` value : ",preference.get("chars.ironcat.max_health"))
preference.set("chars.ironcat.max_health",20);
print("		 	Using command `preference.set('chars.ironcat.max_health',20)`")
print("		 	Expected : `20`,Result :",preference.get("chars.ironcat.max_health"))

print("		Test 2 : changing a property")
print("		 	Present `chars.char_health` value : ",preference.get("chars.char_health"))
preference.set("chars.char_health",30);
print("		 	Using command `preference.set('chars.char_health',30)`")
print("		 	Expected : `30`,Result :",preference.get("chars.char_health"))

print("		Test 3 : changing a nested array")
print("		 	Present `chars.ironcat.other.1` value : ",preference.get("chars.ironcat.other.1"))
preference.set("chars.ironcat.other.1",50);
print("		 	Using command `preference.set('chars.ironcat.other.1',50)`")
print("		 	Expected : `50`,Result :",preference.get("chars.ironcat.other.1"))

print("")

--Replacing whole inner table
print("You can replace whole inner table");
print("==Replacing inner table")
print("		Present `chars.ironcat` value")
printTable(preference.get("chars.ironcat"),nil,3)
preference.set("chars.ironcat",{3,6});
print("		Using command `preference.set('chars.ironcat',{3,6})`")
print("		Result : ")
printTable(preference.get("chars.ironcat"),nil,3)

print("")

--Replacing table
print("==You can replace whole table");
print("==Replacing table")
print("		Present `chars` value")
printTable(preference.get("chars"),nil,3)
preference.set("chars",{newTable={2,4},ironLady={max_health=8}})
print("		Using command `preference.set('chars',{newTable={2,4},ironLady={max_health=8}})`")
print("		Result : ")
printTable(preference.get("chars"),nil,3)

print("")

--Add new index -to array
print("==You can add new value to an array");
print("==Adding new index in a table")
print("		Present `chars` value")
printTable(preference.get("chars.newTable"),nil,3)
preference.set("chars.newTable.3",5)
print("		Using command `preference.set('chars.newTable.3',5)`")
print("		Result : ")
printTable(preference.get("chars.newTable",5),nil,3)

--Set fuction will save the value instantly to prefernce to file
--If you need to store locally and update after sometime use.
--Similar to set will not save in file unless `preference.save()` is called.
--If `preference.save()` not called then your state will be lost when app exit.

-- preference.setState("chars.newTable.3",3)
-- preference.setState("chars.newTable.4",3)
-- preference.setState("chars.newTable.5",3)

-- later use save function, which will save all the data previously stored;
-- preference.save();

--Retreving values

print("")
print("==Retreving values");
printTable(preference.get(),"Preference table currently",3);
print("")
print("==Retreving a property")
print("		Using command `preference.get('chars')`")
print("		Result table : ")
printTable(preference.get("chars.newTable",5),nil,3)
print("")
print("		Using command `preference.get('sound')`")
print("		Result value : ",preference.get('sound'))

print("")

print("==Retreving from inner table")
print("		Using command `preference.get('chars.ironLady.max_health')`")
print("		Result : ",preference.get('chars.ironLady.max_health'))

print("")

print("==Retreving from array")
print("		Using command `preference.get('chars.newTable.1')`")
print("		Result : ",preference.get('chars.newTable.1'))
-- local chars = preference.get("chars")
-- local sound = preference.get("sound")
-- local name = preference.get("name")
-- local coins = preference.get("coins")
-- local ironcat = preference.get("chars.ironcat");
-- local ironcatHealth = preference.get("chars.ironcat.max_health");
-- local ironcatOther1 = preference.get("chars.ironcat.other.1");


--Furthur change the options at the start, remove math.random()
--Check out the advance topics at https://github.com/M4adan/corona-preference-plugin

