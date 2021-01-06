-- y = x+cos(x)
-- how to get x?

function get_y (x, derivative)
	if not derivative then
		return x+math.cos(x)
	else
		return 1-math.sin(x)
	end
end


--local target_y = 8
--local target_y = 1.575
local target_y = math.pi/2
local x = 0 -- first wrong solution
local delta = 1
local ddelta = 0.25
local cdelta = false

for i = 1, 100 do
	local y = get_y (x)
	local diff = (y-target_y)
	print('x:'..x..' y:'..y..' diff:'..diff..' delta:'..delta)
	if diff<0 then
		if cdelta then 
			delta = ddelta*delta 
			cdelta = false
		end
		x = x+delta
	elseif diff>0 then
		if not cdelta then 
			delta = ddelta*delta 
			cdelta = true 
		end
		x = x-delta
	else
		print('done: '..i..' x='..x..' y='..get_y (x))
		return
	end
end