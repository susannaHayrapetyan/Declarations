'use strict';

angular.module('declarations.decDetails', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/decDetails/:id/:mode', {
    templateUrl: 'views/decDetails/decDetails.html',
    controller: 'decDetailsCtrl',
    access: {
	    isFree: true
	}
  });
}])

.controller('decDetailsCtrl', ['$scope', '$routeParams', 'declarationsSrv', 'filtersSrv', 'usersSrv', 
function($scope, $routeParams, declarationsSrv, filtersSrv, usersSrv) {

	$scope.mode = $routeParams.mode;
	$scope.filters = {};
	$scope.address = {};

	declarationsSrv
	.getDeclaration($routeParams.id)
	.success(function(data){
		$scope.declaration = data;
		$scope.filters.security = $scope.declaration.security
		$scope.filters.gender = $scope.declaration.gender
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

	$scope.saveDeclaration = function(){
		var addr = $scope.address.place.address_components.reverse(),
			newDec = {},
			countryId,
			regionId,
			cvdId,
			streetId,
			addressId;

		newDec.address = {
			fullName : $scope.address.fullName
		};

		angular.forEach(addr, function(val) {
	        
	        if(val.types.indexOf('street_number') != -1)
	        	newDec.address.house = val.short_name;
	        if(val.types.indexOf('route') != -1)
	        	newDec.address.street = val.short_name;
	        if(val.types.indexOf('sublocality') != -1 || val.types.indexOf('locality') != -1)
	        	newDec.address.cityVillageDistrict = val.short_name;
	        if(val.types.indexOf('administrative_area_level_1') != -1)
	        	newDec.address.region = val.short_name;
	        if(val.types.indexOf('country') != -1)
	        	newDec.address.country = val.long_name;

	    });

		if(!$scope.declaration.addressId /*|| $scope.declaration.address.fullName != $scope.address.fullName*/){
			filtersSrv
			.saveAddress(newDec.address)
			.success(function(data){
				console.log(data);
			})
		}

	}

}]);