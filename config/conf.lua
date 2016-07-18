module("config.conf", package.seeall)

local conf = {}

function db()
	local configure = {}
	configure["user"] = "root"
	configure["pass"] = ""
	configure["ip"] = "127.0.0.1"
	configure["port"] = "3306"
	configure["dbname"] = "testing"
	return configure
end
 
