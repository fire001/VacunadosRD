// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Vrecomendadas extends StatefulWidget {
  @override
  State<Vrecomendadas> createState() => _VrecomendadasState();
}

class _VrecomendadasState extends State<Vrecomendadas> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacunas recomendadas'),
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
                    DataCell(Text('Tetano')),
                    DataCell(Text('1era dosis')),
                    DataCell(Text('GSK')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Meningcoco')),
                    DataCell(Text('2da Dosis')),
                    DataCell(Text('Sanofi pasteur')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
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
                    DataCell(Text('2da Dosis')),
                    DataCell(Text('GSK')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
                          XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                 ),
                  DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Influenza Estacional')),
                    DataCell(Text('2da Dosis')),
                    DataCell(Text('-')),
                    DataCell(
                      IconButton(
                        icon: Icon(
                          Icons.add_photo_alternate,
                        ),
                        onPressed: () async {
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
