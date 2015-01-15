-- -----------------------------------------------------------------------------
--	Configuration settings for the webapp.
--	@author R. Pusztai <rpusztai@gmail.com>
--	@date 01/14/2015
-- -----------------------------------------------------------------------------
local Config =
{
	rest =
	{
		version			= "1.0"
	},
	database =
	{
		driver			= "sqlite3",
		connData		= { "minimalrest_sandbox.db" },
--		driver			= "postgres",
--		connData		= { "minimalrest_production", "restuser", "simplepassword", "server.com" },
	},
	queries =
	{
		maxDisplayedCount	= 10000,
		recentCount			= 5,
		paginateCount		= 10,
	},
}

return Config
