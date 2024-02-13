import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(Mongo_db);
    await db.open();
    inspect(db);
    var collection = db.collection(Collection_name);
  }
}