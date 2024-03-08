
import 'package:hundred_day/day29/personModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DbController {
  static Database? database;
  String tableName = "person";
  Future<Database?> get db async {
    if (database != null) {
      return database;
    }
    database = await initDatabase();
    return database;
  }

  Future<Database> initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "myDb.db");
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String table =
            "create table $tableName(id integer primary key auto increment,name text,template blob,image blob,faceEmbeddings blob)";

        db.execute(table);
      },
    );
    return database;
  }

  Future<bool> insertPerson(Person person) async {
    try {
      var dbClient = await db;
      dbClient!.insert(tableName, person.toJson()).then((value) {
        return true;
      });
    } catch (e) {
      print("e:$e");
    }
    return false;
  }

  Future<List<Person>> getPerson() async {
    var dbClient = await db;
    if (dbClient == null) return [];
    final List<Map<String, Object?>> result = await dbClient.query(tableName);
    return result.map((e) => Person.fromJson(e)).toList();
  }
}
