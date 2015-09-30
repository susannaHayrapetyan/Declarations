angular
.module('declarations.services')
.factory('countriesSrv', function($resource, usersSrv, URLS) {
	var path = URLS.REST_API_ROOT;
	
	return $resource(path + 'countries/', null, {
      	save: {
      		method:'PUT',
      		headers: {'Access-Token': usersSrv.currAccessToken()}
      	},
      	get: {method:'GET', isArray:true}
    });

});