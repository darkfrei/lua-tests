-- nonoblock
-- https://rosettacode.org/wiki/Nonoblock

local examples = {
	{5, {2, 1}},
	{5, {}},
	{10, {8}},
	{15, {2, 3, 2, 3}},
	{5, {2, 3}},
}
 
function deep (blocks, iBlock, freedom, str)
	if iBlock == #blocks then -- last
		for takenFreedom = 0, freedom do
			print (str..string.rep("0", takenFreedom) .. string.rep("1", blocks[iBlock]) .. string.rep("0", freedom - takenFreedom))
			total = total + 1
		end
	else
		for takenFreedom = 0, freedom do
			local str2 = str..string.rep("0", takenFreedom) .. string.rep("1", blocks[iBlock]) .. "0"
			deep (blocks, iBlock+1, freedom-takenFreedom, str2)
		end
	end
end
 
function main (cells, blocks) -- number, list
	local str = "	"
	print (cells .. ' cells and {' .. table.concat(blocks, ', ') .. '} blocks')
	local freedom = cells - #blocks + 1 -- freedom
	for iBlock = 1, #blocks do
		freedom = freedom - blocks[iBlock]
	end
	if #blocks == 0 then
		print ('no blocks')
		print (str..string.rep("0", cells))
		total = 1
	elseif freedom < 0 then
		print ('no solutions')
	else
		print ('Possibilities:')
		deep (blocks, 1, freedom, str)
	end
end
 
for i, example in ipairs (examples) do
	print ("\n--")
	total = 0
	main (example[1], example[2])
	print ('A total of ' .. total .. ' possible configurations.')
end


--[[ result:
--
5 cells and {2, 1} blocks
Possibilities:
	11010
	11001
	01101
A total of 3 possible configurations.

--
5 cells and {} blocks
no blocks
	00000
A total of 1 possible configurations.

--
10 cells and {8} blocks
Possibilities:
	1111111100
	0111111110
	0011111111
A total of 3 possible configurations.

--
15 cells and {2, 3, 2, 3} blocks
Possibilities:
	110111011011100
	110111011001110
	110111011000111
	110111001101110
	110111001100111
	110111000110111
	110011101101110
	110011101100111
	110011100110111
	110001110110111
	011011101101110
	011011101100111
	011011100110111
	011001110110111
	001101110110111
A total of 15 possible configurations.

--
5 cells and {2, 3} blocks
no solutions
A total of 0 possible configurations.
]]
