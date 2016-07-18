module("core.router", package.seeall)

local router = {}

function method()
	return string.lower(ngx.var.request_method)
end

function xpath()
	local uri = nil
	local method = nil
	local func = require("common.func")
	uri, method = func.uriformat(ngx.var.uri)
	return uri, method
end
