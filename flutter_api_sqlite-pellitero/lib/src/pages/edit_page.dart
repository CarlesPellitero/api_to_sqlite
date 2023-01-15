import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:api_to_sqlite/src/pages/home_page.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:api_to_sqlite/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';

import 'package:api_to_sqlite/src/pages/edit_page.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:api_to_sqlite/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPage createState() => _EditPage();
}

  //We load our Todo BLoC that is used to get
  //the stream of Todo for StreamBuilder
  var isDone = false;
  var now=false;
  var isLoading = false;

  //Allows Todo card to be dismissable horizontally
  const DismissDirection _dismissDirection = DismissDirection.horizontal;

class _EditPage extends State<HomePage> {
  var isLoading = false;
  var isDone = false;

  @override
  Widget build(BuildContext context) {
    final _Descripcion = TextEditingController();
    final _nom = TextEditingController();
    final _tipus = TextEditingController();
    final _imatge = TextEditingController();
    final _id = TextEditingController();
    // _loadFromApi(); //REVISAR
    return Scaffold(
      //backgroundColor: const Color.fromARGB(249, 151, 151, 151),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 129, 64),
        title: const Text('Heroes Edit'),
        centerTitle: true,
      ),
      // body: isLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : _buildEmployeeListView(),
          //backgroundColor: const Color.fromARGB(255, 204, 204, 204), HACER QUE SE VEA
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              DBProvider.db.insertNewHeroe("new","new","new","new","new");
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        )
      // SafeArea(
      //   child: GestureDetector(
      //     onTap: () => FocusScope.of(context).unfocus(),
      //     child: Column(
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         Container(
      //           width: 399,
      //           height: 788.9,
      //           decoration: const BoxDecoration(
      //             color: Color.fromARGB(2, 2, 2, 2), //REVISAR
      //           ),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.max,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsetsDirectional.fromSTEB(25, 25, 0, 0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   children: const [
      //                     Text(
      //                       'Name:',
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                       child: TextFormField(
      //                         controller: _Descripcion,
      //                         autofocus: true,
      //                         obscureText: false,
      //                         decoration: const InputDecoration(
      //                           hintText: '[Some hint text...]',
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           errorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedErrorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                         ),
      //                         style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),                            ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                 padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   children: const [
      //                     Text(
      //                       'Tipus:',
      //                       // style: FlutterFlowTheme.of(context).bodyText1,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding:
      //                           EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                       child: TextFormField(
      //                         controller: _nom,
      //                         autofocus: true,
      //                         obscureText: false,
      //                         decoration: const InputDecoration(
      //                           hintText: '[Some hint text...]',
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           errorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedErrorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                         ),
      //                         style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400)
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                 padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   children: const [
      //                     Text(
      //                       'Descripció:',
      //                       // style: FlutterFlowTheme.of(context).bodyText1,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                       child: TextFormField(
      //                         controller: _tipus,
      //                         autofocus: true,
      //                         obscureText: false,
      //                         decoration: const InputDecoration(
      //                           hintText: '[Some hint text...]',
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           errorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedErrorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                         ),
      //                         //
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                 padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                 child: Row(
      //                   mainAxisSize: MainAxisSize.max,
      //                   children: const [
      //                     Text(
      //                       'Imatge:',
      //                       // style: FlutterFlowTheme.of(context).bodyText1,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding:
      //                           const EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
      //                       child: TextFormField(
      //                         controller: _imatge,
      //                         autofocus: true,
      //                         obscureText: false,
      //                         decoration: const InputDecoration(
      //                           hintText: '[Some hint text...]',
      //                           enabledBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           errorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                           focusedErrorBorder: UnderlineInputBorder(
      //                             borderSide: BorderSide(
      //                               color: Color(0x00000000),
      //                               width: 1,
      //                             ),
      //                             borderRadius: BorderRadius.only(
      //                               topLeft: Radius.circular(4.0),
      //                               topRight: Radius.circular(4.0),
      //                             ),
      //                           ),
      //                         ),
      //                         style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400)
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

  // _loadFromApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   var apiProvider = EmployeeApiProvider();
  //   await apiProvider.getAllEmployees();

  //   // wait for 2 seconds to simulate loading of data
  //   await Future.delayed(const Duration(seconds: 2));

  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  


  _buildEmployeeListView() { //HACER QUE PILLE SOLO UN VALOR CON UNA ID
return FutureBuilder(
      //future: DBProvider.db.getOnlyOne(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //getTodosWidget();
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
          prototypeItem: ListTile( 
                title: Text(
                    "Name: ${snapshot.data.name}"), //REVISAR 
                subtitle: Text(
                  '''Tipus: ${snapshot.data.tipus}
'''
                  'Descripció: ${snapshot.data.desc}'),
              )
          );
        }
      },
    );
  }

    void _showAddTodoSheet(BuildContext context) {
      final _Descripcion = TextEditingController();
    final _nom = TextEditingController();
    final _tipus = TextEditingController();
    final _imatge = TextEditingController();
    final _id = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return  Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child:  Container(
              color: Colors.transparent,
              child:  Container(
                height: 230,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft:  Radius.circular(10.0),
                        topRight:  Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _nom,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'Nom Heroe',
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 237, 141, 57),
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value == "") {
                                  return 'Descripció buida!';
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _tipus,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'Tipus de Heroe',
                                  labelStyle: TextStyle(
                                      color:  Color.fromARGB(255, 237, 141, 57),
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value == "") {
                                  return 'Descripció buida!';
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField( 
                              controller: _Descripcion,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'Descripció del heroe',
                                  labelStyle: TextStyle(
                                      color:  Color.fromARGB(255, 237, 141, 57),
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value == "") {
                                  return 'Descripció buida!';
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField( 
                              controller: _imatge,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'URL imatge',
                                  labelStyle: TextStyle(
                                      color:  Color.fromARGB(255, 237, 141, 57),
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value == "") {
                                  return 'Descripció buida!';
                                }
                              },
                            ),
                          ),
                          Expanded(
                            child: TextFormField( 
                              controller: _id,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'ID',
                                  labelStyle: TextStyle(
                                      color:  Color.fromARGB(255, 237, 141, 57),
                                      fontWeight: FontWeight.w500)),
                              validator: (value) {
                                if (value == "") {
                                  return 'Descripció buida!';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: const Color.fromARGB(255, 237, 141, 57),
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.save_as_rounded,
                                  size: 22,
                                  color: Color.fromARGB(255, 188, 187, 187),
                                ),
                                onPressed: () { //HACER UN INSERT CON TODOS LOS VALORES
                                  final newHeroes = Heroes(
                                      desc: _Descripcion.value.text, //CAMBIAR
                                      name: _nom.value.text,
                                      tipus: _tipus.value.text,
                                      imatge: _imatge.value.text,
                                      id: _id.value.text);
                                  if (newHeroes.name != "" || newHeroes.desc != "" || newHeroes.tipus != "" || newHeroes.imatge != "" || newHeroes.id != "") {
                                    DBProvider.db.addTodo (newHeroes.name, newHeroes.tipus, newHeroes.desc, newHeroes.imatge, newHeroes.id); //MIRAR
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    }