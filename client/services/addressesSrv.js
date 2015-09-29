angular
.module('declarations.services')
.factory('addressesSrv', function($resource, usersSrv, URLS) {
	var path = URLS.REST_API_ROOT;
	
	return $resource(path + 'addresses/', null, {
      	save: {
      		method:'PUT',
      		headers: {'Access-token': usersSrv.currAccessToken()}
      	}
    });

});