import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pymercado_02/main.dart';
import 'package:pymercado_02/deliveryscreen.dart';

class RedirectScreen extends StatefulWidget {
  final User user;

  const RedirectScreen({Key key, this.user}) : super(key: key);
  @override
  _RedirectScreenState createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("PYMErcado"),
      ),
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadeAnimation(1.2, ElevatedButton.icon(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryScreen()),);},
                label: Text("Ir al Mapa"),
                icon: Icon(Icons.map),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  primary: Colors.deepPurple,
                  textStyle: TextStyle(color: Colors.white)
                )
        )),
              FadeAnimation(1.4, ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Crea tu Tienda"),
                  icon: Icon(Icons.person),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                      primary: Colors.deepPurple,
                      textStyle: TextStyle(color: Colors.white))
              )),
              FadeAnimation(1.6, ElevatedButton.icon(
                    onPressed: () {
                      _signOut().whenComplete(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => AskScreen()));
                      });
                    },
                    label: Text("Salir"),
                    icon: Icon(Icons.exit_to_app_outlined),
                    style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    primary: Colors.deepPurple,
                    textStyle: TextStyle(color: Colors.white))
              ))
            ]
        ),
      ),
    );
  }
  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
}
