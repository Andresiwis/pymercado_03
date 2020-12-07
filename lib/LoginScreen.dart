import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:pymercado_02/RedirectScreen.dart';
import 'package:pymercado_02/SignUpScreen.dart';

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
                        FadeAnimation(1.5, Text("Login", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),)),
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
                                        hintText: "Username",
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
                                    obscureText: true,
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
                          height: 6,
                        ),
                        FadeAnimation(1.8, Center(child: Text("Forgot password?", style: TextStyle(color: Colors.black)),)),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(1.9, RaisedButton(
                          onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RedirectScreen()),
                          );},
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80)
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                                color: Colors.teal[900]
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                          ),
                        ),),
                        SizedBox(
                          height: 6,
                        ),
                      FadeAnimation(2.1, FlatButton(
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );},
                        child: Center(
                        child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                      )
                      ))],
                    ),)
                ]
            )
        ));
  }
}
//decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(70),
//                               color: Colors.teal[900]