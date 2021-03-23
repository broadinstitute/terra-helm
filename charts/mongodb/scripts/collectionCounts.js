// Source: https://gist.github.com/matteofigus/8843247
var collections = db.getCollectionNames();
for(var i = 0; i < collections.length; i++){
  var col = collections[i];
  if(col.substr(0, 6) != 'system'){
      var count = db.getCollection(col).count() ;
      print(db + '  ' + col + '    ' + count );
  }
}
