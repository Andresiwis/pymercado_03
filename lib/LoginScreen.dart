import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        backgroundColor: Colors.tealAccent,
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 400,
                      child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -25,
                              height: 300,
                              width: width,
                              child: FadeAnimation(1, Container(
                                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3
                                    ),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/imagen_pymercado02.jpg'),
                                        fit: BoxFit.fill,
                                    )
                                ),
                              )),
                            ),
                          ]
                      )
                  )
                ]
            )
        ));
  }
}