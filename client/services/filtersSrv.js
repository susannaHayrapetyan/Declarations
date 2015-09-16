angular
.module('declarations.services')
.factory('filtersSrv', function($http) {
	var path = 'http://localhost:3000/api/v1/';

	return{
		getSecurities: function(){
			
			return $http({
			    url: path + 'securities', 
			    method: "GET"
			 });
		},
		getGenders: function(){
			
			return $http({
			    url: path + 'genders', 
			    method: "GET"
			 });
		},
		saveAddress: function(address){

			return $http({
			    url: path + 'addresses/saveFullAddress', 
			    method: "POST",
			    data: {
			    	address: address
			    }
			 });

		}
	}
});