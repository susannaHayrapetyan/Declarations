'use strict';

angular.module('declarations.userProfile', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/userProfile/:mode/:id?', {
    templateUrl: 'features/userProfile/userProfile.html',
    controller: 'userProfileCtrl'
  })
  .when("/userProfile",{
        redirectTo: "/userProfile/show"
    })
}])

.controller('userProfileCtrl', 
function($scope, $rootScope, $routeParams, $location, usersSrv) {
	
	var mode = $routeParams.mode,
		userId = $routeParams.id ? $routeParams.id : $rootScope.currentUser.id;

	if(userId)
		usersSrv.get({id: userId}, function(data){
			$scope.user = data;
			$scope.access = true;
		})

	if(userId && userId == $rootScope.currentUser.id)
		$scope.owner = true;

	$scope.editAllowed = false;
	$scope.access = false;

});