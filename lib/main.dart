import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:pymercado_02/LoginScreen.dart';
import 'directionsprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        body: LoginScreen());
  }
}
