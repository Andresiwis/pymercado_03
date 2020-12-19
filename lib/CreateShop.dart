import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:geolocator/geolocator.dart';

//CreateShop
class CreateShop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateShopState();
  }
}


class CreateShopState extends State<CreateShop> {
  String _shopname;
  String _direction;
  String _phoneNumber;
  String _description;
  String _category;
  String _latitud;
  String _longitud;

  void _getCurrentLocation() async {

    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _latitud = "${position.latitude}";
      _longitud = "${position.longitude}";
    });

  }


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildShopName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre de la tienda'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _shopname = value;
      },
    );
  }

  Widget _buildDirection() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'dirección'),
      maxLength: 40,
      validator: (String value) {
        if (value.isEmpty) {
          return 'direccion es requerida';
        }

        /*if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }*/

        return null;
      },
      onSaved: (String value) {
        _direction = value;
      },
    );
  }


  Widget _buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Número de teléfono'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Número de teléfono es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Descripción de la tienda'),
      maxLength: 80,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Descripción de la tienda es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _description = value;
      },
    );
  }
  Widget _buildCategory() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Categoría de la tienda'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Categoría de la tienda es requerido';
        }

        return null;
      },
      onSaved: (String value) {
        _category = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PYMErcado"),
      ),
      backgroundColor: Colors.tealAccent,
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Text("Crea tu propia tienda", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 33)),
              SizedBox(
                height: 20,
              ),
              _buildShopName(),
              _buildDirection(),
              _buildPhoneNumber(),
              _buildDescription(),
              _buildCategory(),
              SizedBox(height: 70),
              RaisedButton(
                onPressed: ()  {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }


                  _formKey.currentState.save();

                  _getCurrentLocation();

                  print(_longitud);

                  Map<String,dynamic>ejemplo={"Nombre": _shopname, "Descripcion": _description, "latitud": _latitud, "longitud": _longitud, "markerId": _shopname, "title": _shopname, "numero": _phoneNumber, "categoria": _category};
                  CollectionReference collection=FirebaseFirestore.instance.collection("tiendas");
                  collection.add(ejemplo);

                  print(_shopname);
                  print(_direction);
                  print(_phoneNumber);
                  print(_description);
                  print(_category);

                      },
                  padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80)
                      ),
                child: Container(
                        decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(80),
                           color: Colors.teal[900]
                        ),
                        padding: const EdgeInsets.all(20),
                          child: Center(
                              child: Text("Crear tienda", style: TextStyle(color: Colors.white, fontSize: 18), ),
                         ),
                       ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
