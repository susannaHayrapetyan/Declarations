angular
.module('declarations.services', [])
.factory('declarationsSrv', function($http) {
	var path = 'http://localhost:3000/api/v1/';

	return{
		getDeclarations: function(offset, limit, privacyId, genderId){
			var filter='';

			filter += privacyId ? '&filter[where][privacyId]=' + privacyId : '';
			filter += genderId ? '&filter[where][genderId]=' + genderId : '';

			filter += 'filter[limit]=' + limit;
			filter += '&filter[skip]=' + offset;

			filter += '&filter[include]=security';
			filter += '&filter[include]=gender';
			filter += '&filter[include]=userAccount';
			
			return $http({
			    url: path + 'declarations?' + filter, 
			    method: "GET"
			 });
		},
		getDeclaration: function(id){
			var filter='';

			filter += '&filter[include]=security';
			filter += '&filter[include]=gender';
			filter += '&filter[include]=userAccount';

			return $http({
			    url: path + 'declarations/' + id +'?' + filter, 
			    method: "GET"
			 });
		}
	}
});