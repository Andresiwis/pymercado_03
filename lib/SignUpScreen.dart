import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pymercado_02/LoginScreen.dart';
import 'package:pymercado_02/RedirectScreen.dart';
import 'package:pymercado_02/main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

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
            child: Form(
                key: _formKey,
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
                                  child: TextFormField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "e-mail",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Porfavor, ingrese un email válido';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(
                                          color: Colors.grey
                                      ))
                                  ),
                                  child: TextFormField(
                                    controller: _passwordcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Porfavor, ingrese una contraseña valida';
                                      }
                                      return null;
                                    },
                                    obscureText: true,
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
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _registrarcuenta();
                            }
                          },
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
            )
        ));
  }
  void _registrarcuenta() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    ))
        .user;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RedirectScreen(
            user: user1,
          )));
    }
  }
}


