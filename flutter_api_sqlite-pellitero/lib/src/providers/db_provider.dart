import 'dart:async';
import 'dart:io';
import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Heroes table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'heroes.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Heroes(' 
          'name TEXT,'
          'desc TEXT,'
          'tipus TEXT,'
          'imatge TEXT,'
          'id TEXT'
          ')');
    });
  }

  // Insert employee on database
  createEmployee(Heroes newEmployee) async {
    await deleteAllEmployees();
    final db = await database;
    final res = await db?.insert('Heroes', newEmployee.toJson()); 
    return res;
  }

  // Delete all employees
  Future<int?> deleteAllEmployees() async {
    final db = await database;
    final res = await db?.rawDelete('DELETE FROM Heroes');

    return res;
  }

  Future<List<Heroes?>> getAllEmployees() async {
    final db = await database;
    final res = await db?.rawQuery("SELECT * FROM Heroes");

    List<Heroes> list = res!.isNotEmpty ? res.map((c) => Heroes.fromJson(c)).toList() : [];

    return list;
  }

  //AFEGIR
    addTodo(name,tipus,desc,imatge,id) async {
    await insertTodo(name,tipus,desc,imatge,id); 
    getAllEmployees();
  }

  Future insertTodo(name,tipus,desc,imatge,id) => insertNewHeroe(name,tipus,desc,imatge,id); 

  insertNewHeroe(String name, String tipus, String desc, String imatge, String id) async { 
    final db = await database;
    db?.rawInsert('INSERT INTO Heroes(name, desc, tipus,imatge,id) VALUES("' + name + '", "' + desc + '", "' + tipus + '","'+ imatge +'","'+ id +'")');
  }

  deleteById(String id) async {
    await deleteTodoById(id);
    getAllEmployees();
  }

  //Borrar un camp VERIFICAR
  Future deleteTodoById(id) => deleteTodo(id);

  deleteTodo(String id) async {
    final db = await database;
    db?.rawDelete('DELETE FROM Heroes where id = ?',[id]); 
    
  }
}