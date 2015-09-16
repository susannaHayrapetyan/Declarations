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

		/*if(newDec.address.country) {*/
			/*countryId = checkCountryExists(newDec.address.country);debugger
			countryId = countryId ? countryId : addCountry(newDec.address.country); 
			regionId = checkRegionExists(newDec.address.region, countryId) || addRegion(newDec.address.region, countryId);*/
			/*cvdId = checkCvdExists(newDec.address.cityVillageDistrict, regionId) || addCityVillageDistrict(newDec.address.cityVillageDistrict, regionId);
			streetId = checkStreetExists(newDec.address.street, cvdId) || addStreet(newDec.address.street, cvdId)
			addressId = checkAddressExists($scope.address.fullName) || addAddress(newDec.address.house, streetId, cvdId, regionId, countryId, $scope.address.fullName)*/
		
		//}		

	}
/*
	function addCountry(name){

		filtersSrv
		.addCountry(name)
		.success(function(data){
			
			return data.id;
		})

	}

	function checkCountryExists(name){
		
		filtersSrv
		.getOneCountry(name)
		.success(function(data){
			if(data.id)
				return data.id;
			else
				return false;
		})
	}

	function addRegion(name, countryId){

		filtersSrv
		.addRegion(name, countryId)
		.success(function(data){
			
			return data.id;
		})

	}

	function checkRegionExists(name, countryId){
		
		filtersSrv
		.getOneRegion(name, countryId)
		.success(function(data){
			if(data.id)
				return data.id;
			else
				return false;
		})
	}

	function addCityVillageDistrict(name, regionId){

		filtersSrv
		.addCityVillageDistrict(name, regionId)
		.success(function(data){
			
			return data.id;
		})

	}

	function checkCvdExists(name, regionId){
		
		filtersSrv
		.getOneCityVillageDistrict(name, regionId)
		.success(function(data){
			if(data.id)
				return data.id;
			else
				return false;
		})
	}

	function addStreet(name, cvdId){

		filtersSrv
		.addStreet(name, cvdId)
		.success(function(data){
			
			return data.id;
		})

	}

	function checkStreetExists(name, cvdId){
		
		filtersSrv
		.getOneStreet(name, cvdId)
		.success(function(data){
			if(data.id)
				return data.id;
			else
				return false;
		})
	}
	function addAddress(house, streetId, cvdId, regionId, countryId, fullName){

		filtersSrv
		.addAddress(house, streetId, cvdId, regionId, countryId, fullName)
		.success(function(data){
			
			return data.id;
		})

	}

	function checkAddressExists(fullName){
		
		filtersSrv
		.getOneAddress(fullName)
		.success(function(data){
			if(data.id)
				return data.id;
			else
				return false;
		})
	}*/
}]);