-- License CC0 (Creative Commons license) (c) darkfrei, 2021


local function is_flat (tabl)
	for i, v in pairs (tabl) do
		if not (type(v) == "string" or type(v) == "number" or type(v) == "boolean") then
			-- not flat
			return false
		end
	end
	return true
end

local function is_list_only (tabl)
	-- not list
--		if tabl[1] ~= nil then return true end
	if tabl[1] == nil then return false end
	local amount = #tabl
	for i, v in pairs (tabl) do
		if amount < 0 then
			print (amount, #tabl)
			return false
		end
		amount = amount - 1
	end
	return true
end

local function i_v_to_string (i, v)
	local str = ""
	
	if type (v) == "table" then
		if is_flat (v) and is_list_only (v) then
			str = str .. table.concat(v, ',')
		else
			
		end
	end
	
	return str
end

local new_line = string.char(10)

local function deep_tts(tabl, level, name)
	local str = ""
	local pre = string.rep('	', level)
	
	if is_flat (tabl) and is_list_only (tabl) then
		str = str .. pre .. '-- concat: ' .. #tabl .. new_line
		str = str .. pre .. table.concat(tabl, ',')
	elseif is_list_only (tabl) then
--		str = str .. ' -- list! ' .. new_line
		for i, v in pairs (tabl) do
			str = str .. new_line .. pre .. '-- ' .. i .. new_line
			if type (v) == "table" then
				str = str .. pre .. '{'..deep_tts(v, level+1, i).. pre .. '},'
			elseif type (v) == "string" then
				str = str .. pre .. '"'.. v .. '",'
			else	
				str = str .. pre .. v .. ','
			end
--			str = str .. '-- 2' .. new_line
		end
	else
		print (name .. ' is not flat list:')
		for i, v in pairs (tabl) do
			local index = '[' .. i .. ']'
			local value = ''
			if type (i) == "string" then index = '["'..i..'"]' end
			if type (v) == "table" then
				value = '{'.. new_line .. deep_tts(v, level+1, i) .. new_line .. pre .. '}'
			elseif type (v) == "string" then
				value = '"' .. v .. '"'
			else
				value = tostring (v)
			end
--			str = str .. pre .. index .. '=' .. value .. ',' .. new_line
--			str = str .. new_line .. pre .. index .. '=' .. value .. ',-- 3'..new_line
			str = str .. new_line .. pre .. index .. '=' .. value .. ','
		end
		str = str .. new_line
	end
	
	return str
end



local tts = function (tabl)
	local str = '{' .. 
	new_line .. deep_tts(tabl, 1, "origin") .. 
	new_line .. '}'
	
	return str
end

return tts

