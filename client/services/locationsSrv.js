angular
.module('declarations.services')
.factory('locationsSrv', function($resource, usersSrv, URLS) {
	var path = URLS.REST_API_ROOT;
	
	return $resource(path + 'locations/', null, {
      	save: {
      		method:'PUT',
      		headers: {'Access-token': usersSrv.currAccessToken()}
      	},
      	get: {method:'GET', isArray:true}
    });

});