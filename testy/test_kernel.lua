-- test_kernel.lua
package.path = "../lj2core/?.lua;"..package.path

local kernel = require("kernel")

local function hello()
	print("Hello LLUI!")
end

local function world()
	print("BYE BYE!")
	halt();
end

local function main()
	spawn(hello)
	spawn(world)
end

run(main)