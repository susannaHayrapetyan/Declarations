'use strict';

angular.module('declarations.home', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/home/:action?', {
    templateUrl: 'features/home/home.html',
    controller: 'homeCtrl'
  });
}])

.controller('homeCtrl',
	function($scope, $routeParams, $rootScope, $location,
		declarationsSrv, gendersSrv, securitiesSrv, addressesSrv, countriesSrv, locationsSrv, usersSrv) {

	$scope.stopLoading = false;
	$scope.filters = {};
	$scope.friends = {};

	var	action = $routeParams.action,
		declarationFilters = {};
		
	$rootScope.$watch(usersSrv.isLoggedIn, function (isLoggedIn) {
		$rootScope.isLoggedIn = isLoggedIn;
	    $rootScope.currentUser = usersSrv.currentUser();

	    $scope.friends = usersSrv.getFriends($rootScope.currentUser.id)

	    if(!isLoggedIn)
	    	declarationFilters = {"filter[where][securityId]": 1};
		else
			declarationFilters = {
				"filter[where][or][0][securityId]": 1,
				"filter[where][or][1][securityId]": 3
			}

		declarationsSrv.get(declarationFilters, function(data){
			$scope.declarationsList = data;
		})

	})

	if(action == "login" && !$rootScope.isLoggedIn){
		usersSrv.login();

		$location.url("/home");
	}
	else if(action == "logout" && $rootScope.isLoggedIn){
		usersSrv.logout();
		
		$location.url("/home");
	}

	gendersSrv
	.get(function(data){
		$scope.genders = data;
	})

	countriesSrv
	.get(function(data){
		$scope.countries = data;
	})

	locationsSrv
	.get(function(data){
		$scope.locations = data;
	})
	$scope.$watch('filters', function(){
		
		if(!angular.equals({}, $scope.filters)){
			
			var genderId = $scope.filters.gender ? $scope.filters.gender.id : null;

			declarationFilters["filter[where][genderId]"] = genderId
			
			declarationsSrv.get(declarationFilters, 
			function(data){
				$scope.declarationsList = data;
			})
		}
	
	}, true)

	$scope.addMoreDeclarations = function() {
	
		if($scope.stopLoading || !$scope.declarationsList) return;
		$scope.stopLoading = true;

		var limit = 15,
			offset = $scope.declarationsList.length;
	
		declarationFilters["filter[skip]"] = offset;
		declarationFilters["filter[limit]"] = limit;
			
		declarationsSrv.get(declarationFilters, 
		function(data){
			$scope.declarationsList = $scope.declarationsList.concat(data);
			$scope.stopLoading = false;
		})
    };
	
});