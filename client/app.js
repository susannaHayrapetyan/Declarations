'use strict';

angular.module('declarations', [
  	'ngRoute',
    'ngCookies',
    'ngAnimate',
    'ngResource',
    'ui.select',
    'infinite-scroll',
    'vsGoogleAutocomplete',
  	'declarations.services',
  	'declarations.directives',
  	'declarations.home',
  	'declarations.decDetails',
    'declarations.userProfile',
    'declarations.myDeclarations'
])
.constant("URLS", {
    "REST_API_ROOT": "/api/v1/"
})
.config(function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/home'});
})
.controller('mainController', function($rootScope, $location, usersSrv){

  $rootScope.isLoggedIn = usersSrv.isLoggedIn();
  $rootScope.currentUser = usersSrv.currentUser();

  $rootScope.$on("$routeChangeStart", function(event, next, current){

    if (next && next.secure) {
      if(!$rootScope.isLoggedIn){
       
        event.preventDefault();
       
        $rootScope.$evalAsync(function() {
          $location.path('/home');
        });
      }
    }

  })

});
