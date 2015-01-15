#!/usr/bin/env wsapi.fcgi

-- Add 'init.lua' as an entry point of a module
package.path = package.path .. ";./?/init.lua;./api/?.lua;./api/?/init.lua"

return require( "api" )
