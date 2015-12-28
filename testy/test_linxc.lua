package.path = "../?.lua;"..package.path

local lnxc = require ("lj2core.init")
local ffi = require("ffi")


using(lnxc)

local function test_process()
local PID = getpid()
print("PID: ", PID)

local buf = ffi.new("char[256]")
local size = 256;

lnxc.getcwd(buf, size)

print("CWD: ", ffi.string(buf))
end


test_process();
