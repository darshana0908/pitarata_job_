import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'aaana.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 12, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notification" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
      "key" TEXT NOT NULL
     
     
 
 
  


  )
 ''');

    await db.execute('''
  CREATE TABLE "gamelist" (
    "id" INTEGER  NOT NULL PRIMARY KEY  ,
      "thumbnail" TEXT NOT NULL,
       "title" TEXT NOT NULL,
      
      "genre" TEXT NOT NULL,
      "platform" TEXT NOT NULL,
      "developer" TEXT NOT NULL,
      "release_date" TEXT NOT NULL,
      "short_description" TEXT NOT NULL
      
    


  )
 ''');
    await db.execute('''
  CREATE TABLE "notification_list" (
    "id" INTEGER  NOT NULL PRIMARY KEY  ,
      "not" TEXT NOT NULL
    
      
    


  )
 ''');
    await db.execute('''
  CREATE TABLE "profile" (
    "id" INTEGER  NOT NULL PRIMARY KEY  ,
      "m_no" TEXT NOT NULL,
       "m2_no" TEXT NOT NULL,
        "gender" TEXT NOT NULL, 
        "birthday" TEXT NOT NULL,
         "address" TEXT NOT NULL,
          "email" TEXT NOT NULL,
           "name" TEXT NOT NULL,
           "status" TEXT NOT NULL
           

    
      
    


  )
 ''');
    await db.execute('''
  CREATE TABLE "profile_update" (
    "id" INTEGER  NOT NULL PRIMARY KEY  ,
      "m_no" TEXT NOT NULL,
       "m2_no" TEXT NOT NULL,
        "gender" TEXT NOT NULL, 
        "birthday" TEXT NOT NULL,
         "address" TEXT NOT NULL,
          "email" TEXT NOT NULL,
           "name" TEXT NOT NULL,
           "user_name" TEXT NOT NULL
           

    
      
    


  )
 ''');

    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;

    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  rawQuery(String sql, List<String> list) {}

  batch() {}

// SELECT
// DELETE
// UPDATE
// INSERT
}
