import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;

class Perfil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PerfilState();
  }
}

class PerfilState extends State<Perfil> {
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
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("tiendas")
        .doc(_uid);
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(6)),
              Column(
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Icon(
                            Icons.location_on_rounded
                        ),
                        Text(
                          _ubicacion ?? '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ]
                  ),
                  Row(
                    children: [
                      Icon(
                          Icons.phone
                      ),
                      Text(
                        _telefono ?? '',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ]),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Center(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child:
                      Text(
                        _descripcion ?? '',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.black,
                              width: 2.5
                          )
                      ),
                    ))
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
                  }),
            ),
          ]),
        ));
  }
}