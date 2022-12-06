import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_userapp/screens/Vacunas/Vrecomendadas.dart';
import 'package:flutter_userapp/screens/Vacunas/Vurgentes.dart';
import 'package:flutter_userapp/screens/uploadtask.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'Vnecesarias.dart';

class MisVacunas extends StatefulWidget {
  @override
  State<MisVacunas> createState() => _MisVacunasState();
}

final ImagePicker _picker = ImagePicker();

//File _selectedPicture;
// clase de las vacunas registradas
// controladores
class _MisVacunasState extends State<MisVacunas> {
  late PageController _controller;
  int currentPage = 1;
  //manejo de firebase
  late Stream<QuerySnapshot> _query;

  var selectedPage;
  UploadTask? task;
  File? file;

  @override
  void initState() {
    super.initState();

    _query = FirebaseFirestore.instance
        .collection('vacunas')
        .where("Enfermedad", isEqualTo: currentPage + 1)
        .snapshots();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

// data table de vacunas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis vacunas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _buildDialog(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Enfermedad',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Dosis',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Laboratorio',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'ver',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Covid-19')),
                    DataCell(Text('3era dosis')),
                    DataCell(Text('Pfizer')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UpLoad()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Polio')),
                    DataCell(Text('4ta Dosis')),
                    DataCell(Text('-')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
                          // ignore: unused_local_variable
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Hepatitis B')),
                    DataCell(Text('1era Dosis')),
                    DataCell(Text('GSK')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
                          // ignore: unused_local_variable
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Rabia')),
                    DataCell(Text('1era Dosis')),
                    DataCell(Text('-')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
                          // ignore: unused_local_variable
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // navegador inferior con botones
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 2, primary: Colors.redAccent),
              icon: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
              label: Text('Urgentes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vurgentes()),
                );
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 2, primary: Colors.orangeAccent),
              icon: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
              label: Text('Necesarias'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vnecesarias()),
                );
              },
            ),
            ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(elevation: 2, primary: Colors.green),
              icon: Icon(
                Icons.menu_book,
                color: Colors.white,
              ),
              label: Text('Recomendadas'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Vrecomendadas()),
                );
              },
            ),
          ],
        ),
      ),
      // boton para el usuario añadir una vacuna nueva
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'agregar vacuna',
        onPressed: () {},
      ),
      //body: _body(),
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Sin notificaciones'),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"))
      ],
    );
  }
}

/*Widget _bottomAction(IconData icon) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon),
    ),
    onTap: () {},
  );
}*/
