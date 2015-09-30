angular
.module('declarations.services', [])
.factory('declarationsSrv', function($resource, $http, URLS, usersSrv) {
	var path = URLS.REST_API_ROOT;

	return $resource(path + 'declarations/:id', {}, 
		{
      		get: {
      			method:'GET', 
      			params:{
					"filter[include][0]": "security",
					"filter[include][1]": "gender",
					"filter[include][2]": "userAccount",
					"filter[include][3]": "address",
					"filter[limit]": 30,
					"filter[skip]": 0
				},
				transformResponse: function (data) {
					data = angular.fromJson(data);
					
					if(data instanceof Array)
						return data;
					else 
						return [data];
	            },
				isArray: true
			},
			save: {
				method: "PUT",
				url: path + 'declarations/updateDeclaration',
				headers: {'Access-Token': usersSrv.currAccessToken()}
			}
    });
    
});