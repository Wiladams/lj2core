package.path = "../?.lua;"..package.path

local lnxc = require ("lj2core.linux.c")
local ffi = require("ffi")


local function using(tbl)
	for k,v in pairs(tbl) do
		_G[k] = v;
	end
end

using(lnxc)


local PID = getpid()
print("PID: ", PID)

local buf = ffi.new("char[256]")
local size = 256;

lnxc.getcwd(buf, size)

print("CWD: ", ffi.string(buf))
