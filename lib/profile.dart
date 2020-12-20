import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const <Widget>[
                    Icon(
                      Icons.store,
                      size: 75,
                    ),
                    Text("NOMBRE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("categoria"),
                      Column(
                        children: <Widget>[
                          Text("dirección"),
                          Text("numero de telefono")
                        ],
                      )
                    ]
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: Text("Descripcion")
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: RaisedButton(
                        child: Center(
                          child: Text("Chatea aquí"),
                        ),
                      onPressed: () {}
                      ),
                      ),
              ]
          ),
        )
    );
  }
}
