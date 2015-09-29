var path = require('path');
var app = require(path.resolve(__dirname, '../server'));

var dataSource = app.dataSources.declarationDs;

dataSource.discoverForeignKeys("declaration", {schema: 'declarations'}, function(err, data){
	console.log(data);
})