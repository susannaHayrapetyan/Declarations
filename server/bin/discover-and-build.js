var path = require('path');
var app = require(path.resolve(__dirname, '../server'));

var dataSource = app.dataSources.declarationDs;

dataSource.discoverAndBuildModels('Declaration', {schema: 'declarations'},
    function(err, models) {
  if (err) throw err;

  models.Declaration.find(function(err, declarations) {
    if (err) return console.log(err);

    console.log(declarations);

    dataSource.disconnect();
  });
});

dataSource.discoverAndBuildModels('Security', {schema: 'declarations'},
    function(err, models) {
  if (err) throw err;

  models.Security.find(function(err, declarations) {
    if (err) return console.log(err);

    console.log(declarations);

    dataSource.disconnect();
  });
});

