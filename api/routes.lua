local R = require( "orbit.routes" )
local Utils	= require( "utils" )

return function( app )
	local Models = require( "models" )( app )
	-- Alias
	local Movies = Models.Movies
	
	app:dispatch_get( function( web, params )
		local movies = Movies:GetAll() or {}
		web.headers["X-Total-Count"] = #movies
		
		return Utils.JSON( web, movies )
	end, R"/movies" )
	
	app:dispatch_get( function( web, params )
		local res = Movies:Get( params.id )
		if res then
			return Utils.JSON( web, res )
		else
			return Utils.Error( web, 404, "Movie not found", ("No movie exists with the id '%i'"):format( params.id ) )
		end
	end, R"/movies/:id" )
end
