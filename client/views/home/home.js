'use strict';

angular.module('declarations.home', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/home', {
    templateUrl: 'views/home/home.html',
    controller: 'homeCtrl',
    access: {
	    isFree: true
	}
  });
}])

.controller('homeCtrl', ['$scope', 'declarationsSrv', 'filtersSrv', function($scope, declarationsSrv, filtersSrv) {

	$scope.stopLoading = false;
	$scope.filters = {};
	
	declarationsSrv
	.getDeclarations(0,30)
	.success(function(data){
		$scope.declarationsList = data;
	})

	filtersSrv
	.getSecurities()
	.success(function(data){
		$scope.filters.securities = data;
	})

	filtersSrv
	.getGenders()
	.success(function(data){
		$scope.filters.genders = data;
	})

	$scope.$watch('filters', function(){
		
		if(!angular.equals({}, $scope.filters)){
			
			var privacyId = $scope.filters.security ? $scope.filters.security.id : null,
				genderId = $scope.filters.gender ? $scope.filters.gender.id : null;

			declarationsSrv
			.getDeclarations(0, 30, privacyId, genderId)
			.success(function(data){
				$scope.declarationsList = data;
			})
	
		}
	
	}, true)

	$scope.addMoreDeclarations = function() {
	
		if($scope.stopLoading || !$scope.declarationsList) return;
		$scope.stopLoading = true;

		var limit = 15,
			offset = $scope.declarationsList.length;
	
		declarationsSrv
		.getDeclarations(offset, limit)
		.success(function(data){
			
			$scope.declarationsList = $scope.declarationsList.concat(data);
			$scope.stopLoading = false;
		})

    };
	
}]);