var loopback = require('loopback');
module.exports = function enableAuthentication(server) {
  	server.middleware('auth', loopback.token({
  		model: server.models.accessToken,
  		currentUserLiteral: 'me'
	}));
};
