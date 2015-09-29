var uuid = require('node-uuid').v4();
var loopback = require('loopback');

module.exports = function(UserAccount) {
	UserAccount.login = function(user, cb) {
		var accessToken = {};

		UserAccount.findOrCreate(
			{where: {fbId: user.fbId}}, 
			user, 
			function(error, userAcc){
				accessToken.token = uuid;
				accessToken.userId = userAcc.id;

				addUserFriends(user.friends.data, userAcc.id, cb);
				addUserEmails(user.emails, userAcc.id, cb);

				UserAccount.app.models.Token.findOrCreate(
					{where: {userId: accessToken.userId}},
					accessToken, function(err, token){

					cb(err, {accessToken: token.token, id: token.userId});

				})
				
		})

    }

	UserAccount.logout = function(userId, req, cb){
	
	    req.app.models.AccessToken.findForRequest(req, function(err, data){
	    	var token;

	    	if(err)
	    		cb(err);
	    	else if(data && data.id){
	    		token = new req.app.models.AccessToken({id: data.id});
	      		
	      		token.destroy();
	      	}
	    });

	    req.app.models.token.destroyAll({userId: parseInt(userId)}, function(err, data){
	    	cb(err, data);
	    })
		
	}
     
	UserAccount.remoteMethod(
        'login', 
        {
			http: {path: '/login', verb: 'post'},
            accepts: {arg: 'user', type: 'object'},
            returns: {arg: 'data', type: 'object'}
        }
    );

	UserAccount.remoteMethod(
        'logout', 
        {
			http: {path: '/logout', verb: 'get'},
            accepts: [
				{arg: 'userId', type: 'number'},
				{arg: 'req', type: 'object', http: { source: 'req' }}
				],
            returns: {arg: 'status', type: 'string'}

        }
    );

	function addUserFriends(friends, userId, cb){
		var i, relationship, friend;

		if(friends.length){
			for (i = friends.length - 1; i >= 0; i--) {
				
				UserAccount.app.models.UserAccount.find({where: {fbId: friends[i].id}}, 
					function(err, data){
				
					if(err)
						console.log(err);
					
					friend = data ? data[0] : null;
					
					if(friend){

						relationship = {relatingUserId: userId, relatedUserId: friend.id};
					
						UserAccount.app.models.UserRelationship.findOrCreate(
							{where: relationship}, 
							relationship, 
							function(err, data){
								
								if(err)
									console.log(err);
							})
					}
				}) 

			};
		}
	}

	function addUserEmails(emails, userId, cb){
		var i, email={};
			
		if(emails.length){

			UserAccount.app.models.Email.find({where: {userId: userId}}, 
				function(err, data){
					if(!err && data.length == 0){

						for (i = emails.length - 1; i >= 0; i--) {
							
							email.name = emails[i].value;
							email.userId = userId;

							UserAccount.app.models.Email.findOrCreate(
								{where: email}, 
								email, 
								function(err, data){
									
									if(err)
										console.log(err);
							})
						
						};
					}
			})

		}
	}
};
