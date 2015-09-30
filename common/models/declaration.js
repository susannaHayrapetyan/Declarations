module.exports = function(Declaration) {

	Declaration.disableRemoteMethod("exists", true);
	Declaration.disableRemoteMethod("findOne", true);
	Declaration.disableRemoteMethod("count", true);

	Declaration.updateDeclaration = function(declaration, req, cb){
	
		declaration.userId = req.currentUserId;

	    Declaration.upsert(declaration, cb)
		
	}
     
	Declaration.remoteMethod(
        'updateDeclaration', 
        {
			http: {path: '/updateDeclaration', verb: 'put'},
            accepts: [
				{arg: 'declaration', type: 'object'},
				{arg: 'req', type: 'object', http: { source: 'req' }}
				],
            returns: {arg: 'declaration', type: 'object'}

        }
    );
};
