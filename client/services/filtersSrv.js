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
/*		getOneCountry: function(name){
			var filter='';

			filter += name ? '?filter[where][name]=' + name : '';
			
			return $http({
			    url: path + 'countries/findOne', 
			    method: "GET"
			 });
		},
		getOneRegion: function(name){
			var filter='';

			filter += name ? '?filter[where][name]=' + name : '';
			
			return $http({
			    url: path + 'regions/findOne', 
			    method: "GET"
			 });
		},
		getOneCityVillageDistrict: function(name){
			var filter='';

			filter += name ? '?filter[where][name]=' + name : '';
			
			return $http({
			    url: path + 'cityVillageDistricts/findOne', 
			    method: "GET"
			 });
		},
		getOneStreet: function(name){
			var filter='';

			filter += name ? '?filter[where][name]=' + name : '';
			
			return $http({
			    url: path + 'streets/findOne', 
			    method: "GET"
			 });
		},
		getOneAddress: function(name){
			var filter='';

			filter += name ? '?filter[where][name]=' + name : '';
			
			return $http({
			    url: path + 'addresses/findOne', 
			    method: "GET"
			 });
		},
		addCountry: function(name){
			
			return $http({
			    url: path + 'countries', 
			    method: "POST",
			    data: {
			    	name: name
			    }
			 });
		},
		addRegion: function(name, countryId){
			
			return $http({
			    url: path + 'regions', 
			    method: "POST",
			    data: {
			    	name: name,
			    	countryId: countryId
			    }
			 });
		},
		addCityVillageDistrict: function(name, regionId){
			
			return $http({
			    url: path + 'cityVillageDistricts', 
			    method: "POST",
			    data: {
			    	name: name,
			    	regionId: regionId
			    }
			 });
		},
		addStreet: function(name, cvdId){
			
			return $http({
			    url: path + 'streets', 
			    method: "POST",
			    data: {
			    	name: name,
			    	cvdId: cvdId
			    }
			 });
		},
		addAddress: function(house, streetId, cvdId, regionId, countryId, fullName){
			
			return $http({
			    url: path + 'addresses', 
			    method: "POST",
			    data: {
			    	house: house,
			    	streetId: streetId,
			    	cvdId: cvdId,
			    	regionId: regionId,
			    	countryId: countryId,
			    	fullName: fullName
			    }
			 });
		}*/

	}
});