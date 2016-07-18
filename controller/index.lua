module("controller.index", package.seeall)

local index = {}

function default()
	return "hello world"
end

function hello(args)
	return "hello method"
end

