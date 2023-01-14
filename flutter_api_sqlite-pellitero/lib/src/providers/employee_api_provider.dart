import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:dio/dio.dart';

class EmployeeApiProvider {
  Future<List<Heroes?>> getAllEmployees() async {
    var url = "https://639743e786d04c763390491d.mockapi.io/dades"; 
    Response response = await Dio().get(url);

    return (response.data as List).map((heroes) {
      // ignore: avoid_print
      print('Inserting $heroes');
      DBProvider.db.createEmployee(Heroes.fromJson(heroes));
    }).toList();
  }
  
}
