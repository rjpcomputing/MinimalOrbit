-- -----------------------------------------------------------------------------
--	Utility functions
--	@author R. Pusztai <rpusztai@gmail.com>
--	@date 01/14/2015
-- -----------------------------------------------------------------------------
local json				= require( "json" )

local Utils	= {}

function Utils.JSON( web, payload )
	web.headers["Content-Type"] = "application/json"
	return json.encode( payload )
end

function Utils.Error( web, httpCode, userMessage, developerMessage, additional )
	assert( type( web )			== "table", ("Invalid web (arg1) type. Expected 'table', but found %s"):format( type( web ) ) )
	assert( type( httpCode )	== "number", ("Invalid httpCode (arg2) type. Expected 'number', but found %s"):format( type( httpCode ) ) )
	assert( type( userMessage )	== "string", ("Invalid userMessage (arg3) type. Expected 'string', but found %s"):format( type( userMessage ) ) )
	web.status = ("%i %s"):format( httpCode, userMessage )
	developerMessage = developerMessage or userMessage
	local data = "post" == web.method:lower() and web.POST or web.GET

	return Utils.JSON( web, { code = httpCode, method = web.method:upper(), url = web.prefix .. web.path_info, data = data, userMessage = userMessage, developerMessage = developerMessage, additionalDetails = additional } )
end

return Utils
