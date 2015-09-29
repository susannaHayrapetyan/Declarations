angular
.module('declarations.directives', [])
.directive('singleDeclaration', function (){ 
  return {
		restrict: 'E',
    templateUrl: 'templates/singleDeclaration.html',
  	link: function($scope, elem, attr) {
      
      $scope.$watch('dataShowType', function(){
        var declaration = {},
            desc;

        declaration = angular.fromJson(attr.singleDeclaration);
        desc = declaration.description;
        user = declaration.userAccount;
        
        if($scope.dataShowType == "list"){
          
          if(desc.length > 150)
            declaration.description = desc.substring(0, 150) + "...";

          declaration.userName = user.firstName + " " + user.lastName + ", " + user.age;
        
        }
        else{
          
          if(desc.length > 50)
            declaration.description = desc.substring(0, 50) + "..."
        
          declaration.userName = user.firstName + " " + user.lastName;
        } 

        $scope.declaration = declaration;

      })

    }
  }
})
