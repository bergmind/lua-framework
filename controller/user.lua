module("controller.user", package.seeall)

local user = {}

function index()

end

function list()
	local ActiveRecord = require("common.ActiveRecord")
	ActiveRecord.init()
	users_table = ActiveRecord.execute("select * from user")
	return users_table
end
