import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'directionsprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pymercado_02/profile.dart';

class DeliveryScreen extends StatefulWidget {
  final LatLng fromPoint = LatLng(-33.49127796658118, -70.61806703531481);
  final LatLng toPoint = LatLng(-33.50648316186287, -70.60602013057212);
  final LatLng panaderia = LatLng(-33.499827115576544, -70.61737123904767);
  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  GoogleMapController _mapController;
  Map<MarkerId, Marker> markadores = <MarkerId, Marker>{};

  void initMarker(specify) async {
    var markerIdval = specify['markerId'];
    final MarkerId markerId = MarkerId(markerIdval);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: specify['title']));
    setState(() {
      markadores[markerId] = marker;
    });
  }

  getMarkers() async {
    FirebaseFirestore.instance.collection('tiendas').get().then((e) {
      if (e.docs.isNotEmpty) {
        for (int i = 0; i < e.docs.length; i++) {
          initMarker(e.docs[i].data());
        }
      }
    });
  }

  void iniState() {
    getMarkers();
    super.initState();
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
              target: widget.fromPoint,
              zoom: 12,
            ),
            markers: Set<Marker>.of(markadores.values),
            //polylines: api.currentRoute,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.zoom_out_map),
        onPressed: _centerView,
      ),
    );
  }

  void getData() {
    FirebaseFirestore.instance
        .collection('tiendas')
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((doc) {
                print(doc['markerId']);
              })
            });
  }

  _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(
      Marker(
        markerId: MarkerId("fromPoint"),
        position: widget.fromPoint,
        infoWindow: InfoWindow(title: "USM"),
      ),
    );
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: widget.toPoint,
        infoWindow: InfoWindow(title: "Estadio Colo-Colo"),
      ),
    );
    tmp.add(
      Marker(
        markerId: MarkerId("tiendita"),
        position: widget.panaderia,
        infoWindow: InfoWindow(title: "Panaderia Casera"),
      ),
    );
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _centerView();
  }

  _centerView() async {
    var api = Provider.of<DirectionProvider>(context);

    await _mapController.getVisibleRegion();

    print("buscando direcciones");
    await api.findDirections(widget.fromPoint, widget.toPoint);

    var left = min(widget.fromPoint.latitude, widget.toPoint.latitude);
    var right = max(widget.fromPoint.latitude, widget.toPoint.latitude);
    var top = max(widget.fromPoint.longitude, widget.toPoint.longitude);
    var bottom = min(widget.fromPoint.longitude, widget.toPoint.longitude);

    api.currentRoute.first.points.forEach((point) {
      left = min(left, point.latitude);
      right = max(right, point.latitude);
      top = max(top, point.longitude);
      bottom = min(bottom, point.longitude);
    });

    var bounds = LatLngBounds(
      southwest: LatLng(left, bottom),
      northeast: LatLng(right, top),
    );
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
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
                    image: NetworkImage(
                        "https://i.pinimg.com/736x/33/66/3a/33663afe1341595fef614dad3305d328.jpg"))),
          ),
          Ink(
            color: Colors.purple,
            child: new ListTile(
              title: Text("Mi-Tienda"),
              onTap: () {
                //pantalla de la tienda
              },
            ),
          ),
          Ink(
            color: Colors.purple,
            child: new ListTile(
              title: Text("Chats"),
              onTap: () {
                //pantalla de chats
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final tiendas = ["Pizzas", "Sushi", "Ropa", "Globos", "Botilleria", "Papas"];
  final tiendasrecientes = [
    "Pizzas",
    "Papas",
  ];
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
    return Profile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? tiendasrecientes
        : tiendas.where((e) => e.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
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
      ),
      itemCount: suggestionList.length,
    );
  }
}
