'use strict';

angular.module('declarations.myProfile', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/myProfile/:mode/:action?', {
    templateUrl: 'features/myProfile/myProfile.html',
    controller: 'myProfileCtrl'
  })
  .when("/myProfile",{
        redirectTo: "/myProfile/show"
    })
}])

.controller('myProfileCtrl', 
function($scope, $rootScope, $routeParams, $location, usersSrv) {
	
	var mode = $routeParams.mode,
		action = $routeParams.action;
	
	$rootScope.$watch(usersSrv.isLoggedIn, function (isLoggedIn) {
	    $rootScope.isLoggedIn = isLoggedIn;
	    $rootScope.currentUser = usersSrv.currentUser();

		if(isLoggedIn)
			usersSrv.get({id: $rootScope.currentUser.id}, function(data){
				$scope.user = data;
				$scope.access = true;
			})
	})

	$scope.editAllowed = false;
	$scope.access = false;

	if(action == "login" && !$rootScope.isLoggedIn){
		usersSrv.login();
		
		$location.url("/myProfile");
	}
	else if(action == "logout" && $rootScope.isLoggedIn){
		usersSrv.logout();
		
		$location.url("/home");
	}

});