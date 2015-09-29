var loopback = require('loopback');
var fs = require('fs');

module.exports = function(Declaration) {
	/*Declaration.currentUser = function(cb) {
		var ctx1 = loopback.getCurrentContext();
		var currentUser = ctx1 && ctx1.get('currentUser');

		console.log(ctx1);
		
		cb(currentUser);
    }

	Declaration.beforeRemote('**', function(ctx, user, next) {
  		console.log("accessToken", ctx.req.loopbackContext.accessToken);
		console.log(user);

		var cache = [];
		var json = JSON.stringify(ctx, function(key, value) {
		if (typeof value === 'object' && value !== null) {
		        if (cache.indexOf(value) !== -1) {
		            // Circular reference found, discard key
		            return;
		        }
		        // Store value in our collection
		        cache.push(value);
		    }
		    return value;
		});
		cache = null;

		fs.writeFile("C:\\declarations/log.txt", json, function(err) {
		    if(err) {
		        return console.log(err);
		    }

		    console.log("The file was saved!");
		});

  		next();
	});
     
	Declaration.remoteMethod(
        'currentUser', 
        {
			http: { verb: 'get' },
            returns: {arg: 'user', type: 'string'}
        }
    );*/

	Declaration.observe('access', function logQuery(ctx, next) {
	  /*console.log('Accessing %s matching %s', ctx.Model.modelName, ctx.query.where);
	  //console.log(ctx);
	  	fs.writeFile("C:\\declarations/log.txt", JSON.stringify(ctx), function(err) {
		    if(err) {
		        return console.log(err);
		    }

		    console.log("The file was saved!");
		});*/

	  	next();
	});
};
