import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Vnecesarias extends StatefulWidget {
  @override
  State<Vnecesarias> createState() => _VnecesariasState();
}

class _VnecesariasState extends State<Vnecesarias> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacunas necesarias'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(
                Icons.add,
              ),
              tooltip: 'agregar vacuna',
              onPressed: () {}
              ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Enfermedad',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Dosis',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Laboratorio',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ver',
                    style: TextStyle(fontStyle: FontStyle.italic),
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
                    DataCell(Text('Sarampion')),
                    DataCell(Text('1da Dosis')),
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
    );
  }
}

//File _selectedPicture;

