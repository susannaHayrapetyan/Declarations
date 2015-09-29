var path = require('path');
var app = require(path.resolve(__dirname, '../server'));

var dataSource = app.dataSources.declarationDs;

dataSource.autoupdate('User', function(err) {
    console.log(err);
});
