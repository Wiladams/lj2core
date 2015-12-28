package.path = "../?.lua;"..package.path

local kernel = require("kernel")

function main()
	print("Hello Kernel!!")
	halt();
end

run(main)

