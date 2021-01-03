import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pymercado_02/chat.dart';
import 'directionsprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pymercado_02/profile.dart';
import 'perfil.dart';
import 'globals.dart' as globals;

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: MyDeliveryScreen(),
    );
  }
}

class MyDeliveryScreen extends StatefulWidget {
  @override
  _MyDeliveryScreenState createState() => _MyDeliveryScreenState();
}

class Tiendas {
  String nombre;
  String descripcion;
  String ubicacion;
  double latitud;
  double longitud;
  LatLng cordenadas;

  Tiendas({
    this.nombre,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.cordenadas,
    this.ubicacion,
  });
}

List<Tiendas> tiendas = [];

marcadores() {
  FirebaseFirestore.instance.collection('tiendas').get().then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      tiendas.add(Tiendas(
        nombre: doc.data()['Nombre'],
        descripcion: doc.data()['Descripcion'],
        latitud: doc.data()['latitud'],
        longitud: doc.data()['longitud'],
        cordenadas: LatLng(doc.data()['latitud'], doc.data()['longitud']),
        ubicacion: doc.data()['ubicacion'],
      ));
      print('ciclo funcionando');
    });
    print(tiendas);
    return tiendas;
  });
}

class _MyDeliveryScreenState extends State<MyDeliveryScreen> {
  List<Marker> allMarkers = [];
  GoogleMapController _mapController;

  @override
  void initState() {
    print('Aqui');
    marcadores();
    getTiendas();
    print('aqui');
    print(tiendas);
    super.initState();
    tiendas.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.nombre),
          draggable: false,
          infoWindow: InfoWindow(
            title: element.nombre,
            snippet: element.ubicacion,
          ),
          position: element.cordenadas));
    });
  }

  getTiendas() async {
    FirebaseFirestore.instance
        .collection('tiendas')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['Nombre']);
        if (!globals.t.contains(doc['Nombre'])) {
          globals.t.add(doc['Nombre']);
          globals.id.add(doc['markerId']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PYMErcado'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      drawer: Menulateral(),
      body: Consumer<DirectionProvider>(
        builder: (BuildContext context, DirectionProvider api, Widget child) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-33.491414, -70.618132),
              zoom: 12,
            ),
            markers: Set.from(allMarkers),
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _centerView();
  }

  _centerView() async {
    await _mapController.getVisibleRegion();
  }
}

class Menulateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              "PYMErcado",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text("pymercado@gmail.com",
                style: TextStyle(color: Colors.black)),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/imagen_pymercado.jpg'))),
          ),
          Ink(
            color: Colors.purple,
            child: new ListTile(
              title: Text("Mi-Tienda"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Perfil()));
              },
            ),
          ),
          Ink(
            color: Colors.purple,
            child: new ListTile(
              title: Text("Chats"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Chat(user: globals.usuario,)));
                //nada
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final tiendasrecientes = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //globals.
    return Profile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? tiendasrecientes
        : globals.t.where((e) => e.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showResults(context);
            print('Funciona');
            globals.indice = globals.t.indexOf(suggestionList[index]);
            print(suggestionList[index]);
            print(globals.indice);
            print(globals.id[globals.indice]);
          },
          leading: Icon(Icons.store),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
