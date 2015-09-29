angular
.module('declarations.services')
.factory('securitiesSrv', function($resource, URLS) {
	var path = URLS.REST_API_ROOT;

	return $resource(path + 'securities', {}, {
      	get: {method:'GET', isArray:true}
    });
    
});