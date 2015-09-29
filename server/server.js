var loopback = require('loopback');
var boot = require('loopback-boot');
var PassportConfigurator = require('loopback-component-passport').PassportConfigurator;
var app = module.exports = loopback();
var url = require("url");

var passportConfigurator = new PassportConfigurator(app);

app.start = function() {
  return app.listen(function() {
    app.emit('started');
    console.log('Web server listening at: %s', app.get('url'));
  });
};

app.all('/api/v1/*', function(req, res, next){
  var pathname = url.parse(req.url).pathname,
      accessToken = req.headers["access-token"],
      userId,
      now = new Date(),
      created;

  if(pathname == "/api/v1/userAccounts/login" && req.method == "POST")
    next();
  else if(req.method == "PUT" || req.method == "POST" || req.method == "DELETE")
  { 

    if(accessToken){
      
      app.models.Token.find({where: {"token" : accessToken}}, function(err, data){

        userId = data ? data[0].userId : null;
        created = new Date(data[0].created);

        if(err){
          res.statusCode = 500;
          res.statusMessage = "Internal error.";
          res.send();
        }
        else if(data.length > 1){
          res.statusCode = 500;
          res.statusMessage = "Something went wrong. Please try to logout and login again.";
          res.send();
        }
        else if(now - created > 8640000000) /*100days*/
        {
          res.statusCode = 401;
          res.statusMessage = "Access token expired";
          res.send();
        }
        else{

          if(userId){
            req.currentUserId = userId;
            next();

          }
          else{
            res.statusCode = 403;
            res.statusMessage = 'Incorrect token.';
            res.send();
          }

        }

      })

    }
    else{
        res.statusCode = 401;
        res.statusMessage = 'No token provided.';
        res.send();
    }
  }
  else{
    next();
  }

});

// Bootstrap the application, configure models, datasources and middleware.
// Sub-apps like REST API are mounted via boot scripts.
boot(app, __dirname, function(err) {
  if (err) throw err;

  // start the server if `$ node server.js`
  if (require.main === module) {
    app.start();
  }
});
 
passportConfigurator.init();
passportConfigurator.setupModels({
  userModel: app.models.User,
  userIdentityModel: app.models.UserIdentity,
  userCredentialModel: app.models.UserCredential
});
passportConfigurator.configureProvider('facebook-login',
  require('../providers.json')['facebook-login']);
