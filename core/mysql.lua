module("core.mysql", package.seeall)

local ActiveRecord = {}

ActiveRecord.conn = {}

ActiveRecord.env = {}

function ActiveRecord:init()
	--init configure setting, init mysql Object
	local config = require("config.conf")
	local mysql= require("luasql.mysql")
	local db = config.db()
	local env = mysql.mysql()
	ActiveRecord.conn = env:connect(db.dbname, db.user, db.pass, db.ip, db.port)
end

function ActiveRecord:execute(sql) 
	cursor,errorString = ActiveRecord.conn:execute(sql)
	row = cursor:fetch({}, "a")
	local result = {}
	while row do
	        row = cursor:fetch (row, "a") -- reusing the table of results
	        table.insert(result, row)
	end
	return result
end

ActiveRecord.init()
sql = "select * from users";
result = ActiveRecord.execute(sql)
ActiveRecord.close()
print(result)