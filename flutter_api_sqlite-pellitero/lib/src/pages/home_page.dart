import 'package:api_to_sqlite/src/pages/edit_page.dart';
import 'package:api_to_sqlite/src/providers/db_provider.dart';
import 'package:api_to_sqlite/src/providers/employee_api_provider.dart';
import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

  const DismissDirection _dismissDirection = DismissDirection.horizontal; //Afegit

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  var isDone = false;
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 129, 64),
        title: const Text('Heroes Information'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: const Icon(Icons.settings_input_antenna),
              onPressed: () async {
                await _loadFromApi();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _deleteData();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditPage()));
                  //SALTA A OTRA PAGE
              },
            ),
          ) ,
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildEmployeeListView(),
          backgroundColor: const Color.fromARGB(255, 204, 204, 204),     
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

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = EmployeeApiProvider();
    await apiProvider.getAllEmployees();

    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllEmployees();

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

  }
  //Se generarn todos los valores 
  _buildEmployeeListView() {
    return FutureBuilder(
      future: DBProvider.db.getAllEmployees(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //getTodosWidget();
        if (!snapshot.
        hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Color.fromARGB(255, 235, 129, 64),
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
             Heroes heroes = snapshot.data![index];

             // getTodosWidget(); //AGREGAR NO VA MIRA PARA QUE FUNCIONE
              return ListTile( 
                leading: 
                Image(image: NetworkImage("${snapshot.data[index].imatge}")),
                title: Text(
                    "Name: ${snapshot.data[index].name}"),
                subtitle: Text(
                  '''Tipus: ${snapshot.data[index].tipus}
'''
                  'Descripció: ${snapshot.data[index].desc}'),
                  key: ObjectKey(heroes),
                  onTap: () async {
                    final now = DateTime.now();
                    const maxDuration = Duration(seconds: 2);
                    final isWarning = lastPressed == null ||
                      now.difference(lastPressed!) > maxDuration;
                    //Reverse the value

                    if (isWarning){
                      lastPressed = DateTime.now();
                      
                      const snackbar = SnackBar(
                        content: Text('Double Tap To Deleted'),
                        duration: maxDuration,
                      );

                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(snackbar);

                        //GUARDAR LOS VALORES 
                    }else{
                    isDone = !isDone;
                    await _deleteDataByID(heroes.id.toString());
                    }
                  },
                  
              );
            },
          );
        }
      },
    );
  }

  _deleteDataByID(String id) async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteById(id);

    // wait for 1 second to simulate loading of data
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      isLoading = false;
    });

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
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
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
                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'Tipus',
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
                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Escriu',
                                  labelText: 'Descripció',
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
                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
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
                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
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
                                onPressed: () { 
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

  Widget getTodosWidget() {
    return StreamBuilder(
      //stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Heroes>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }
//NO USAR
  Widget getTodoCardWidget(AsyncSnapshot<List<Heroes>> snapshot) {
      if (snapshot.hasData) {
        return snapshot.data!.isNotEmpty
            ? ListView.builder(
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
                            "Deleting",
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
                              isDone = !isDone;
                              DBProvider.db.updateTodo(heroes); //ARREGLAR
                            },
                          ),
                          title: Text(
                            heroes.desc.toString(),
                            style: TextStyle(
                                fontSize: 16.5,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.w500,
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        )),
                  );
                  return dismissibleCard;
                },
              )
            : Center(
            child: noTodoMessageWidget(),
              );
      } else {
        return Center(
          child: loadingData(),
        );
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

}
