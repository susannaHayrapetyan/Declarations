'use strict';

angular.module('declarations.decDetails', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/decDetails/:mode/:id?', {
    templateUrl: 'features/decDetails/decDetails.html',
    controller: 'decDetailsCtrl',
    access: {
	    isFree: true
	}
  });
}])

.controller('decDetailsCtrl', 
function($scope, $rootScope, $routeParams, $location, 
	declarationsSrv, gendersSrv, addressesSrv, securitiesSrv, usersSrv, countriesSrv, locationsSrv) {
	
	var user = $rootScope.currentUser,
		addrFullName;

	$scope.mode = $routeParams.mode;
	$scope.editAllowed = false;
	$scope.owner = false;
	$scope.filters = {};
	$scope.address = {};
	$scope.declaration = {};
	$scope.showSuccess = false;

	if($routeParams.id && $scope.mode != "new"){

		declarationsSrv.get({id: $routeParams.id}, 
			function(data){
				var dec = data[0]
				var sec = dec.security;

				$scope.declaration = dec;
				$scope.filters.gender = dec.gender
				$scope.address.fullName = dec.address.length ? dec.address[dec.address.length-1].fullName : "";

				addrFullName = $scope.address.fullName;

				if(user && dec && user.id && dec.userAccount.id == user.id)
					$scope.owner = true;

				if($scope.owner && $scope.mode == "edit")
					$scope.editAllowed = true;

				if(sec.key == "public")
					sec.glyphicon = "glyphicon-globe";
				else if(sec.key == "friends")
					sec.glyphicon = "glyphicon-user";
				else if(sec.key == "private")
					sec.glyphicon = "glyphicon-lock";

				$scope.filters.security = sec;
			}
		)
	}
	else if($scope.mode == "new")
		$scope.editAllowed = true;

	securitiesSrv
	.get(function(data){
		$scope.filters.securities = data;
	})
	
	gendersSrv
	.get(function(data){
		$scope.filters.genders = data;
	})

	$scope.saveDeclaration = function(){
		var dec = $scope.declaration;

		dec.genderId = $scope.filters.gender.id;
		dec.securityId = $scope.filters.security.id;
		dec.userId = 155;

		declarationsSrv.save({}, {declaration: dec}, function(data){
			dec.id = data.id;

			if(addrFullName !== $scope.address.fullName)
				saveAddress(dec.id);
			else
				showSuccess();
		})
	}

	function saveAddress(decId){
		var addressFull = $scope.address.place.address_components,
			address = {
				fullName : $scope.address.fullName,
				declarationId: decId
			},
			country, location;

		angular.forEach(addressFull, function(val) {
	        
	        if(
	        	(val.types.indexOf('locality') != -1 && val.short_name !== "Yerevan") 
	        	|| val.types.indexOf('sublocality') != -1
	        )
	        	location = val.short_name;

	        if(val.types.indexOf('country') != -1)
	       		country = val.long_name;

	    });

		if(country)
			saveCountry()
		
		if(!location)
			saveAddr();

		function saveCountry(){

			countriesSrv.query({"filter[where][name]": country}, function(data){
				
				if(data[0] && data[0].id)
					saveLocation(data[0].id);
				else
					countriesSrv.save({name: country}, function(data){
						saveLocation(data.id);
					})
			})
		}
		
		function saveLocation(cId){

			locationsSrv.query({
					"filter[where][name]": location,
					"filter[where][countryId]": cId
				}, function(data){
					
					if(data[0] && data[0].id)
						saveAddr(data[0].id)
					else
						locationsSrv.save({name: location, countryId: cId}, function(data){
							saveAddr(data.id);
						})
			})
		}

		function saveAddr(locId){
			address.locationId = locId ? locId : null;

		    addressesSrv.save(address, function(data, e){
				
				showSuccess();
			})
		}

	}

	$scope.enableEdit = function(id){
		var path = "/decDetails/edit/"+id

		$location.path(path);
	}

	function showSuccess(){
		$scope.showSuccess = true;

		
	}

});