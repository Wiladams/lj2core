package.path = "../?.lua;"..package.path

local kernel = require("lj2core.kernel")

function main()
	print("Hello Kernel!!")
	halt();
end

run(main)

