import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';

import 'package:pymercado_02/main.dart';
import 'package:pymercado_02/deliveryscreen.dart';

class RedirectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ))
            ]
        ),
      ),
    );
  }
}
