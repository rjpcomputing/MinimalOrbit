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
--		connData		= { "visiondb_production", "vdb_readonly", "gentex", "zvm90-debian76.gentex.com" },
	},
	queries =
	{
		maxDisplayedCount	= 10000,
		recentCount			= 5,
		paginateCount		= 10,
	},
}

return Config
