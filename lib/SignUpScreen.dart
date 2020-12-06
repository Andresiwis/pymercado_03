import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:pymercado_02/LoginScreen.dart';
import 'package:pymercado_02/main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: Text("PYMErcado"),
      ),
        backgroundColor: Colors.deepPurple[200],
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 220,
                      child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: -25,
                              height: 275,
                              width: width,
                              child: FadeAnimation(1, Container(
                                margin: EdgeInsets.symmetric(vertical: 35, horizontal: 40),
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
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        FadeAnimation(1.5, Text("Sign up", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),)),
                        SizedBox(height: 7,),
                        FadeAnimation(1.7, Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey
                                      ))
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "e-mail",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey
                                      ))
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                  ),
                                )
                              ],
                            )
                        )),
                        SizedBox(
                          height: 0.5,
                        ),
                        FadeAnimation(1.7, FlatButton(
                            onPressed: () {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AskScreen()),
                            );},
                            child: Center(
                              child: Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                            )
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        FadeAnimation(1.9, RaisedButton(
                          onPressed: () {},
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: Colors.tealAccent
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text("Sign Up", style: TextStyle(color: Colors.black),),
                            ),
                          ),
                        ),),
                      ],
                    ),)
                ]
            )
        ));
  }
}