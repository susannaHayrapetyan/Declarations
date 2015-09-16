module.exports = function(Address) {
	Address.saveFullAddress = function(address, cb) {
		var sql = 'SELECT save_full_address(';
console.log(address)
		sql += address.house ? "'" + address.house + "', " : 'NULL, '
		sql += address.street ? "'" + address.street + "', " : 'NULL, '
		sql += address.cityVillageDistrict ? "'" + address.cityVillageDistrict + "', " : 'NULL, '
		sql += address.region ? "'" + address.region + "', " : 'NULL, '
		sql += address.country ? "'" + address.country + "', " : 'NULL, '
		sql += address.fullName ? "'" + address.fullName + "'" : 'NULL';
		sql += ') AS id';

		Address.dataSource.connector.query(sql, function(err, rows){
		
			if (err) console.error(err);
	        
			cb(err, rows[0].id);
		});
    }
     
	Address.remoteMethod(
        'saveFullAddress', 
        {
			http: { verb: 'post' },
            accepts: {arg: 'address', type: 'object'},
            returns: {arg: 'id', type: 'number'}
        }
    );
};
