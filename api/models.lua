-- -----------------------------------------------------------------------------
--	Database functions
--	@author R. Pusztai <rpusztai@gmail.com>
--	@date 01/14/2015
-- -----------------------------------------------------------------------------
return function ( app )
	local Models = {}

	local Movies = app:model( "movie" )

	function Movies:Get( id )
		return self:find( id )
	end
	
	function Movies:GetAll()
		return self:find_all( "id NOT NULL" )
	end
		
	Models.Movies = Movies

	return Models
end

