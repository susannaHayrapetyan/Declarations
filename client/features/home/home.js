'use strict';

angular.module('declarations.home', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/home', {
    templateUrl: 'features/home/home.html',
    controller: 'homeCtrl',
    access: {
	    isFree: true
	}
  });
}])

.controller('homeCtrl',
	function($scope, declarationsSrv, gendersSrv, securitiesSrv, addressesSrv, countriesSrv, locationsSrv) {

	$scope.stopLoading = false;
	$scope.filters = {};
	
	declarationsSrv.get({}, function(data){
		$scope.declarationsList = data;
	})

	securitiesSrv
	.get(function(data){
		$scope.filters.securities = data;
	})

	gendersSrv
	.get(function(data){
		$scope.filters.genders = data;
	})

	countriesSrv
	.get(function(data){
		$scope.filters.countries = data;
	})

	locationsSrv
	.get(function(data){
		$scope.filters.locations = data;
	})
	$scope.$watch('filters', function(){
		
		if(!angular.equals({}, $scope.filters)){
			
			var privacyId = $scope.filters.security ? $scope.filters.security.id : null,
				genderId = $scope.filters.gender ? $scope.filters.gender.id : null;

			declarationsSrv.get({
				"filter[where][securityId]": privacyId,
				"filter[where][genderId]": genderId}, 
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
	
		declarationsSrv.get({
			"filter[skip]": offset,
			"filter[limit]": limit}, 
		function(data){
			$scope.declarationsList = $scope.declarationsList.concat(data);
			$scope.stopLoading = false;
		})
    };
	
});