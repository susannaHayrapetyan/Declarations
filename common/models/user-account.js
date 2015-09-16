module.exports = function(UserAccount) {
	var excludedProperties = [
	  'realm',
	  'emailVerified',
	  'verificationToken',
	  'credentials',
	  'challenges',
	  'lastUpdated',
	  'username',
	  'status',
	  'created',
	  'password'
	];
	
	excludedProperties.forEach(function (p) {
		delete UserAccount.definition.rawProperties[p];
		delete UserAccount.definition.properties[p];
		delete UserAccount.prototype[p];
	});

	delete UserAccount.validations.password;

};
