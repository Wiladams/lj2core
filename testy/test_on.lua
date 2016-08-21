package.path = "../?.lua;"..package.path

local kernel = require("kernel")

count = 1;

local function onTestSignal(params)
	print("onTestSignal: ", count, params)
	count = count + 1;
	if count > 5 then
		halt();
	end
end

local function dosignal(words)
	signalAll("testsignal", words)
	yield();
end

local function main()
	print("running main")


	dosignal("this")
	dosignal("is")
	dosignal("the")
	dosignal("last")
	dosignal("one")
end

on("testsignal", onTestSignal)

run(main);
