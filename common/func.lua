module("common.func", package.seeall)

local func = {}

function split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end
	
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

--处理URI
function uriformat(uri)
	local uri = split(trim(string.lower(uri), "/"), "/")
	if type(uri) ~= "table" then
		return "controller.index", "default"
	end
	local fun = "controller"	
	local method = nil
	local len = table.getn(uri)
	local n = len - 1
	if len > 1 then
		for i=1, n do
			fun = fun.."."..uri[i]
		end
		fun = trim(fun, ".")
		method = uri[len]
		if method == "index" then
			method = "default"
		end
	else
		fun = fun.."."..uri[len]
		method = "default"
	end
	return fun, method
end

--字符串按位分割函数
--传入字符串，返回分割后的table，必须为字母、数字，否则返回nil
function gsplit(str)
	local str_tb = {}
	if string.len(str) ~= 0 then
		for i=1,string.len(str) do
			new_str= string.sub(str,i,i)			
			if (string.byte(new_str) >=48 and string.byte(new_str) <=57) or (string.byte(new_str)>=65 and string.byte(new_str)<=90) or (string.byte(new_str)>=97 and string.byte(new_str)<=122) then 				
				table.insert(str_tb,string.sub(str,i,i))				
			else
				return nil
			end
		end
		return str_tb
	else
		return nil
	end
end

function trim(inputString, delimiter)
	inputString = ltrim(inputString, delimiter)
	inputString = rtrim(inputString, delimiter)
	return inputString
end

--Method : ltrim
--Desc : trim left delimiter from string
--param : FulString String eg. : abcdefg
--        delimiter String eg. : a
--return : String eg. : bcdefg
function ltrim(inputString, delimiter)
	local usageString = inputString
	local stringLen = string.len(inputString)
	for zIndex = 1, stringLen
	do
		if string.sub(inputString, zIndex, zIndex) ~= delimiter
		then
			break
		end
		usageString = string.sub(inputString, zIndex + 1)
	end
	return usageString
end

--Method : rtrim
--Desc : trim right delimiter from string
--param : FulString String eg. : abcdefg
--        delimiter String eg. : g
--return : String eg. : abcdef
function rtrim(inputString, delimiter) 
	inputString = string.reverse(inputString)
	local usageString = inputString
	local stringLen = string.len(inputString)
	for zIndex = 1, stringLen
	do
		if string.sub(inputString, zIndex, zIndex) ~= delimiter
		then
			break
		end
		usageString = string.sub(inputString, zIndex + 1)
	end
	inputString = string.reverse(usageString)
	return inputString
end
