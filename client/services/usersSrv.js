angular
.module('declarations.services')
.factory('usersSrv', function($resource, $cookies, URLS) {
	var path = URLS.REST_API_ROOT;
	var usersSrv = $resource(path + 'userAccounts/:id', {}, 
		{
			loginUser: {method:'POST', url: path + 'userAccounts/login/:user'},
			logoutUser: {method:'GET', url: path + 'userAccounts/logout'},
			get: {
      			method:'GET', 
      			params:{
					"filter[include][0]": "email",
					"filter[include][1]": "phoneNumber"
				}
			}

		}),
		userIdentities = $resource(path + 'userIdentities/:id'),
		userRelationship = $resource(path + 'userRelationships', {}, 
		{
			get: {
      			method:'GET', 
      			isArray: true
			}

		});

	usersSrv.login = function() {
		userIdentities.get({id: "me"}, function(data){
			var user = {};

			if(data.profile)
			{
				user.fbId = data.profile.id;
				user.userIdentityId = data.userId;
				user.firstName = data.profile.name.givenName;
				user.lastName = data.profile.name.familyName;
				user.emails = data.profile.emails;
				user.gender = data.profile.gender;
				user.profilePicture = data.profile.photos[0].value;
				user.friends = data.profile._json.friends;

				usersSrv.loginUser({user: user}, function(data){
					user.id = data.data.id;
					
					$cookies.put('decAccessToken', data.data.accessToken);
					$cookies.put('decUser', JSON.stringify(user));
	
				})

			}
		})
	};

	usersSrv.logout = function() {
		userId = usersSrv.currentUser().userIdentityId;

		$cookies.remove('decAccessToken');
		$cookies.remove('decUser');
	
		usersSrv.logoutUser({userId: userId}, function(data){
			console.log(data);
		});
	};

	usersSrv.isLoggedIn = function(){
		var accessToken = $cookies.get('decAccessToken')
	
		if(accessToken)
			return true;

		return false;
	}

	usersSrv.currAccessToken = function(){

		return $cookies.get('decAccessToken');
	
	}

	usersSrv.currentUser = function(){
		var user = $cookies.get('decUser')
		
		if(user)
			return JSON.parse(user);

		return {};
	}

	usersSrv.getFriends = function(userId){
		var i, friends = [];

		userRelationship.get({"filter[where][relatingUserId]": userId}, 
			function(data){

				for (i = data.length - 1; i >= 0; i--) {
					friends.push(data[i].relatedUserId);
				};
			})

		return friends;
	}

	return usersSrv;
})
