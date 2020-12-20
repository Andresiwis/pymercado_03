import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'CreateShop.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;
  Map data;
  String _nombre;
  String _categoria;
  String _ubicacion;
  String _telefono;
  String _descripcion;

  void getCurrentUser() async {
    User user = _auth.currentUser;
    final uid = user.uid;
    print(uid);
    setState(() {
      _uid = uid;
    });
  }

  getData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("tiendas").doc(_uid);
    documentReference.snapshots().listen((event) {
      setState(() {
        data = event.data();
        _nombre = data['Nombre'];
        _categoria = data['categoria'];
        _ubicacion = data['ubicacion'];
        _telefono = data['numero'];
        _descripcion = data['Descripcion'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.store,
                  size: 75,
                ),
                Text(
                  _nombre ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                Widget>[
              Text(
                "Categoria:\n $_categoria",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
                  Text(
                    _ubicacion ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _telefono ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ]),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                    child: Text(
                  _descripcion ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ))),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RaisedButton(
                  child: Center(
                    child: Text(
                      "Chatea aquí",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: RaisedButton(
                  child: Center(
                    child: Text(
                      "Actualizar datos",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    getCurrentUser();
                    getData();
                    print(data['Nombre']);
                  }),
            ),
          ]),
        ));
  }
}
