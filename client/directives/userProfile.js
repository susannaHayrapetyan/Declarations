angular
.module('declarations.directives')
.directive('userProfile', function (){ 
  return {
		restrict: 'E',
    scope: {},
    templateUrl: 'templates/userProfile.html',
  	link: function($scope, elem, attr) {
      
        $scope.user = angular.fromJson(attr.user);
        $scope.pic = attr.pic;
        $scope.age = attr.age;
    }
  }
})
