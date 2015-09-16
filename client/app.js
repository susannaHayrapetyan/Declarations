'use strict';

// Declare app level module which depends on views, and components
angular.module('declarations', [
  	'ngRoute',
    'ui.select',
    'infinite-scroll',
    'vsGoogleAutocomplete',
  	'declarations.services',
  	'declarations.directives',
  	'declarations.home',
  	'declarations.decDetails'
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/home'});
}])
.controller('mainController', ['$scope', 'usersSrv', function($scope, usersSrv){

	$scope.login = function(){
		usersSrv.isLogged = true;
		usersSrv.username = 'Susanna';
		usersSrv.id = 1;
	}

}]);
