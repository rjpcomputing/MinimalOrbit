-- -----------------------------------------------------------------------------
--	Main entry point for the REST Api.
--
--	Author:	R. Pusztai <rpusztai@gmail.com>
--	Date:	01/14/2015
-- -----------------------------------------------------------------------------
local orbit	= require( "orbit" )
local model	= require( "orbit.model" )
local json	= require( "json" )

-- Create our application class
local Minimal = orbit.new()

-- DEBUGGING ONLY --
-- Redirect 'print()' to the log
function print1( ... )
	local inputs = {}
	for _, val in ipairs( { ... } ) do
		inputs[1 + #inputs] = tostring( val )
	end
	local f = assert( io.open( "/var/log/xavante.log", "a+" ) )
	f:write( ("[%s] "):format( os.date( "%Y-%m-%d %T" ) ), table.concat( inputs, "\t" ), "\n" )
	f:close()
end

-- Load the config
local config = require( "config" )

-- Setup the database connector.
local luasql				= require( "luasql." .. config.database.driver:lower() )
local env					= assert( luasql[config.database.driver]() )
-- Configure the models for the Minimal application
Minimal.mapper.driver		= config.database.driver
Minimal.mapper.logging		= true		-- Turn on SQL logging
Minimal.mapper.table_prefix	= ""		-- Make it so that there are no prefixes on the table names. This seems much more sane, especially using PostgreSQL.
Minimal.mapper.conn			= model.recycle( function ()
								local connection = assert( env:connect( unpack( config.database.connData ) ) )
								connection:execute( "PRAGMA foreign_keys = ON;" )
								--connection:execute( "PRAGMA recursive_triggers = ON;" )
								return connection
							  end )

-- Error handlers
Minimal.not_found = function( web )
	web.status = "404 Not Found"
	web.headers["Content-Type"] = "application/json"
	local data = "post" == web.method:lower() and web.POST or web.GET
	local payload = { code = "404", method = web.method:upper(), url = web.prefix .. web.path_info, data = data }
	payload.userMessage = ("'%s' not found" ):format( payload.url )
	payload.developerMessage = "The URL passed has no routes associated with it. This normally means that you have a malformed URL."
	
	return json.encode( payload )
end

Minimal.server_error = function( web, msg )
	web.status = "500 Server Error"
	web.headers["Content-Type"] = "application/json"
	local data = "post" == web.method:lower() and web.POST or web.GET
	local payload = { code = "500", method = web.method:upper(), url = web.prefix .. web.path_info, data = data }
	payload.userMessage = ("An unexpected error occured with URL: %s" ):format( payload.url )
	payload.developerMessage = msg
	
	return json.encode( payload )
end

require( "routes" )( Minimal )

return Minimal
