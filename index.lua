ngx.header.content_type = "text/html"
local request_method = ngx.var.request_method
local args = nil
--parse request path
--get response params
if "GET" == request_method then
    args = ngx.req.get_uri_args()
elseif "POST" == request_method then
　　ngx.req.read_body()
　　args = ngx.req.get_post_args()
end
ngx["args"] = args; 
local uri = nil
local method = nil
local func = require("common.func")
local json = require("cjson")
local router = require("core.router")
--Router
uri, method = router.xpath()
local xurl = "controller."..method
local ret, errmsg = pcall(require, uri)

if ret == false then
	local errinfo = {
                ["errcode"] = 100001,
                ["errmsg"] = "The URI "..uri.." is not found",
              }
        ngx.print(json.encode(errinfo))
	return
end

controller = require(uri)
local ret, errmsg = pcall(loadstring(xurl.."()"), args)
if ret == false then
	local errinfo = {
		["errcode"] = 100002,
	        ["errmsg"] = "The Method "..method.." is not found",
              }
	ngx.print(json.encode(errinfo))
	return
end
local result = assert(loadstring("return "..xurl.."()"))()
ngx.print(json.encode(result))
