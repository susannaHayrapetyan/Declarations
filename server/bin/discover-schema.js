var path = require('path');
var app = require(path.resolve(__dirname, '../server'));

var dataSource = app.dataSources.declarationDs;
var table = "UserRelation";

dataSource.discoverSchema(table, {schema: 'declarations'},
    function(err, schema) {
  if (err) throw err;

  console.log(JSON.stringify(schema, null, '  '));

  dataSource.disconnect();
});
