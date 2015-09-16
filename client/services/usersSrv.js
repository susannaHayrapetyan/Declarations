angular
.module('declarations.services')
.factory('usersSrv', function() {

	return{
		isLogged: false,
    	username: '',
    	id: ''
    }
})
