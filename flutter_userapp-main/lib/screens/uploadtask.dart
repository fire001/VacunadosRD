// ignore_for_file: unused_import

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_userapp/main.dart';
import 'package:path/path.dart';
import '../servicios/firebase_api.dart';

class UpLoad extends StatefulWidget {
  @override
  _UpLoadState createState() => _UpLoadState();
}

class _UpLoadState extends State<UpLoad> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Seleccione un archivo';

    return Scaffold(
      appBar: AppBar(
        title: Text('Vacunados RD'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Seleccionar imagen'),
                onPressed: selectFile,
              ),
              SizedBox(height: 8),
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 48),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: uploadFile,
              ),
              SizedBox(height: 20),
              task != null ? buildUploadStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-link: $urlDownload');
  }

  /*Future _getImageUrl() async {
      final Future<StorageReference> ref =
          FirebaseStorage.instance.getReferenceFromUrl('https://console.firebase.google.com/project/fluter-userapp/storage/fluter-userapp.appspot.com/files');
      dynamic url = await ref.then((doc) => doc.getDownloadURL());
      print(url);
    }
}
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(pathname + DateTime.now().toString());
    await ref.putFile(File(_image.path)) {
      // TODO: implement putFile
      throw UnimplementedError();
    }
    String imageUrl = await ref.getDownloadURL();
    print(imageUrl);*/

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
