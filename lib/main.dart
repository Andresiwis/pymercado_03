import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deliveryscreen.dart';
import 'directionsprovider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => DirectionProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PYMErcado',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: AskScreen(),
      ),
    );
  }
}

class AskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PYMErcado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Iniciar sesión',
            ),
            Text(
              'Regístrate',
            ),

            FloatingActionButton(
              tooltip: 'increment',
              child: Icon(Icons.map),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryScreen())),
            )
          ],
        ),
      ),
    );
  }
}
