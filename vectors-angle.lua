--angle between two vectors

local function length(x, y) return math.sqrt(x^2 + y^2) end
local function dot(ax, ay, bx, by) return ax * bx + ay * by end
local function twocross(ax, ay, bx, by) return ax * by - bx * ay end

local function corner_angle_acos (ax, ay, bx, by, cx, cy)
	local dx, dy = bx - ax, by - ay
    local ex, ey = cx - bx, cy - by
    local dl, el = length(dx, dy), length(ex, ey)
    local is_right_turn = twocross(dx, dy, ex, ey) < 0
    return math.acos(dot(dx, dy, ex, ey) / (dl * el)) * (is_right_turn and 1 or -1)
end

local function corner_angle_atan (ax, ay, bx, by, cx, cy) -- three points in two sectors ab, bc
--	vector ab:
	local dx, dy = bx - ax, by - ay
--	vector bc:
	local ex, ey = cx - bx, cy - by
	-- returns angle in the range: [-pi; pi)
	return (math.atan2(dy, dx)-math.atan2(ey, ex)+math.pi)%(2*math.pi)-math.pi
end

for i = 1, 10 do
	
	local ax, ay = math.random ()*2-1, math.random ()*2-1
	local bx, by = math.random ()*2-1, math.random ()*2-1
	local cx, cy = math.random ()*2-1, math.random ()*2-1
	
	-- Vörnicus:
	local angle1 = corner_angle_acos(ax, ay, bx, by, cx, cy)
	
	-- darkfrei:
	local angle2 = corner_angle_atan(ax, ay, bx, by, cx, cy)
	
	print (angle1, angle2)
end

-- output: 
--	1.6046767418267	1.6046767418267
--	3.0069264350513	3.0069264350513
--	1.911022681835	1.911022681835
--	2.9932605303374	2.9932605303374
--	-0.1200252779905	-0.1200252779905
--	2.8876476963857	2.8876476963857
--	-2.9282446001575	-2.9282446001575
--	1.9595351606386	1.9595351606386
--	1.0771983259259	1.0771983259259
--	-2.4279244818819	-2.4279244818819