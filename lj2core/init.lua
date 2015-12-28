--init.lua
-- initialize lj2core

function using(tbl)
	for k,v in pairs(tbl) do
		_G[k] = v;
	end
end

return require("lj2core.linux.c")