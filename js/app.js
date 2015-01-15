( function()
{
	angular.module( "MovieApp", ["ngRoute"] )
	.config( ["$httpProvider", "$routeProvider", function ( $httpProvider, $routeProvider )
	{
		// Intercept POST requests, convert to standard form encoding
//		$httpProvider.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
//		$httpProvider.defaults.transformRequest.unshift( function (data, headersGetter)
//		{
//			var key, result = [];
//			for (key in data)
//			{
//				if ( data.hasOwnProperty( key ) )
//				{
//					result.push( encodeURIComponent( key ) + "=" + encodeURIComponent( data[key] ) );
//				}
//			}
//			
//			return result.join( "&" );
//		} );
		
		// Routes in the app
		$routeProvider
			.when( "/", { templateUrl: "partials/home.html", controller: "HomeCtrl" } )
			.when( "/about", { templateUrl: "partials/about.html", controller: "AboutCtrl" } )
//			.when( "/contact", { templateUrl: "partials/contact.html", controller: "ContactCtrl" } )
			.otherwise( { redirectTo: '/' } );
	} ])
	
	.controller( "TabCtrl", [ "$scope", "$location",
	function ( $scope, $location )
	{
        this.IsActive = function( viewLocation )
		{
			return viewLocation === $location.path();
		};
    } ])
	
	.controller( "HomeCtrl", [ "$scope", "$routeParams", "$http", "$filter",
	function( $scope, $routeParams, $http, $filter )
	{
		$scope.movies = [];
		$scope.totalcount = 0;
		
		GetAllMovies();

		function GetAllMovies()
		{
			$http.get( "api.ws/movies" )
			.success( function( data, status, headers )
			{
				$scope.movies = data;
				$scope.totalcount = headers( "x-total-count" );
				//$( "#loading-dialog" ).modal( "hide" );
			} )
			.error( function( errorDetails )
			{
				console.log( "Error Occured!" );
				console.log( errorDetails );
			} );
		}
	} ])
	
	.controller( "AboutCtrl", [ "$scope", "$routeParams", "$http", "$filter",
	function( $scope, $routeParams, $http, $filter )
	{
	} ]);
} )();
