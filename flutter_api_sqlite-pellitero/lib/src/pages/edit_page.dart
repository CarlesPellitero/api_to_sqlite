import 'package:api_to_sqlite/src/models/employee_model.dart';
import 'package:api_to_sqlite/src/pages/home_page.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:api_to_sqlite/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
class _EditPage extends State<EditPage>{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 129, 64),
        title: const Text('Heroes Information'),
        centerTitle: true,
        // actions: <Widget>[
        //   Container(
        //     padding: const EdgeInsets.only(right: 3.0),
        //     child: IconButton(
        //       icon: const Icon(Icons.edit),
        //       onPressed: () {
        //         Navigator.pop(context);
        //         DBProvider.db.getAllEmployees();
        //         },
        //     ),
        //   ) ,
        // ],
      ),
        resizeToAvoidBottomInset: false,
        body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getTodosWidget(),
          backgroundColor: const Color.fromARGB(255, 204, 204, 204),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.indigoAccent,
                      size: 28,
                    ),
                    onPressed: () {
                      DBProvider.db.getAllEmployees();
                    }),
                // const Expanded( TONTERIA
                //   child: Text(
                //     "Todo",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //         fontFamily: 'RobotoMono',
                //         fontStyle: FontStyle.normal,
                //         fontSize: 19),
                //   ),
                // ),
                Wrap(children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.indigoAccent,
                    ),
                    onPressed: () {
                      _showTodoSearchSheet(context);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ])
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddTodoSheet(context);
            },
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        )
        );
        
  }

//AÑADIR UNO NUEVO
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
//SEARCH
  void _showTodoSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFormController = TextEditingController();
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
                decoration:  const BoxDecoration(
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
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search for todo...',
                                labelText: 'Search *',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500),
                              ),
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
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                  DBProvider.db.getAllEmployees();
                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
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

  Widget getTodosWidget() {

    return StreamBuilder(
      stream: DBProvider.db.controll,
      builder: (BuildContext context, AsyncSnapshot<List<Heroes>> snapshot) 
      {
       return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Heroes>> snapshot) {
    if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty ?
             ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, itemPosition) {
                  Heroes heroes = snapshot.data![itemPosition];
                  final Widget dismissibleCard =  Dismissible(
                    background: Container(
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Esborra..",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      DBProvider.db.deleteTodoById(heroes.id.toString()); //ARREGLAR
                    },
                    direction: _dismissDirection,
                    key: ObjectKey(heroes),
                    child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.white,
                        child: ListTile(
                          leading: InkWell(
                          onTap: () {
                            //Reverse the value
                            isDone = !isDone;
                            DBProvider.db.updateTodo(heroes);
                          },
                        ),
                        title: Text(
                              "Name: ${snapshot.data?[itemPosition].name}",
                        ),
                        subtitle: Text(
                          '''Tipus: ${snapshot.data?[itemPosition].tipus}
'''
                            'Descripció: ${snapshot.data?[itemPosition].desc}'),
//                             title: Text(
//                                 "Name: ${snapshot.data![index].name}"),
//                             subtitle: Text(
//                               '''Tipus: ${snapshot.data![index].tipus}
// '''
//                               'Descripció: ${snapshot.data![index].desc}'),
                            
                          )),
                      );
                  return dismissibleCard;
                })// HE CAMBIADO , por ;
                : Center(
            child: noTodoMessageWidget(),
              );
      } else {
        return Center(
          child: loadingData(),
      );
    }
    }
  }

  Widget noTodoMessageWidget() {
    return const Text(
      "Start adding Todo...",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    );
  }
    Widget loadingData() {
    DBProvider.db.getAllEmployees(); 
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(),
          Text("Loading...",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  // dispose() {
  //   pages.dispose();
  // }
