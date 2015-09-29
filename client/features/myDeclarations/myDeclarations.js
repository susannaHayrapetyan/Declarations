'use strict';

angular.module('declarations.myDeclarations', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/myDeclarations', {
    templateUrl: 'features/myDeclarations/myDeclarations.html',
    controller: 'myDeclarationsCtrl',
    secure: true
  });
}])

.controller('myDeclarationsCtrl',
	function($scope, $rootScope, declarationsSrv) {
		var userId = $rootScope.currentUser.id;

		declarationsSrv
		.get({"filter[where][userId]": userId}, function(data){
			$scope.declarationsList = data;
		})
	
});