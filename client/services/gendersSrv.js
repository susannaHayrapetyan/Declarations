angular
.module('declarations.services')
.factory('gendersSrv', function($resource, URLS) {
	var path = URLS.REST_API_ROOT;
	
	return $resource(path + 'genders', {}, {
      	get: {method:'GET', isArray:true}
    });
    
});