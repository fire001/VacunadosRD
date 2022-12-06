import 'package:flutter/material.dart';
import 'package:flutter_userapp/screens/cvacunacion.dart';
import 'package:flutter_userapp/screens/Vacunas/historial.dart';
import 'package:flutter_userapp/servicios/authentication_services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Qrscreen extends StatefulWidget {
  @override
  State<Qrscreen> createState() => _QrscreenState();
}

class _QrscreenState extends State<Qrscreen> {
  CollectionReference data = FirebaseFirestore.instance.collection('data');

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("VacunadosRD"),
        //campana de notificacion
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            tooltip: 'Ver notificaciones',
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _buildDialog(context),
            ),
          ),
          //menu
          PopupMenuButton(
            icon: Icon(Icons.menu_outlined),
            tooltip: 'ver menu',
            onSelected: (result) {
              if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MisVacunas()),
                );
              } else if (result == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Mis Vacunas"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("Centros de vacunacion cercanos"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Sign Out"),
                onTap: () async => await loginProvider.logout(),
                value: 2,
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: QrImage(
          data:
              'https://firebasestorage.googleapis.com/v0/b/fluter-userapp.appspot.com/o/files%2FScreenshot_20211202-125431_Gallery.jpg?alt=media&token=280ab9a7-445e-434a-97a3-cc95d68e727d',
          version: QrVersions.auto,
          size: 320,
          gapless: true,
        ),
      ),
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
            child: const Text("Okay"))
      ],
    );
  }

  /* void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOutCirc.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _buildDialog(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }*/
}
