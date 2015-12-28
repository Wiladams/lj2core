package.path = "../?.lua;"..package.path

--[[
  Attach to a running process
--]]

local lnxc = require ("lj2core.init")
local ffi = require("ffi")

using(lnxc)
require("ptrace")

--[[
#include <sys/wait.h>
#include <unistd.h>
#include <linux/user.h>   /* For constants
                                   ORIG_EAX etc */
--]]


local function attach(PID)
    local status = ffi.new("int[1]",0)
    local options = ffi.new("int[1]",0)

    ptrace(ffi.C.PTRACE_ATTACH, PID)
    
    local wpid = waitpid(PID, status, options)

 end

local function detach(PID)
    ptrace(ffi.C.PTRACE_CONT,PID)
end

-- command line should specify a process id (PID)
local pid = tonumber(arg[1])
assert(pid, "must specify a process ID")


attach(pid)
detach(pid)