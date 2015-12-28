package.path = "../?.lua;"..package.path

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


local function main()
    long orig_eax;
    local child = fork();
    if(child == 0) then
        ptrace(ffi.C.PTRACE_TRACEME, 0, NULL, NULL);
        execve("/bin/ls", NULL, NULL);
    else
        wait(NULL);
        orig_eax = ptrace(PTRACE_PEEKUSER,
                          child, 
                          4 * ORIG_EAX,
                          NULL);
        print(string.format("The child made a system call %ld", orig_eax));
        ptrace(PTRACE_CONT, child, NULL, NULL);
    end
end

main()
