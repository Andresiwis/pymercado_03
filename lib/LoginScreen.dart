import 'package:pymercado_02/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pymercado_02/RedirectScreen.dart';
import 'package:pymercado_02/SignUpScreen.dart';
import 'globals.dart' as globals;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.tealAccent,
        body: SingleChildScrollView(
            child: Form(
                key: _formkey,
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
                                  child: TextFormField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Porfavor, ingrese un email válido';
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
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Contraseña",
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Por favor, ingrese una contraseña válida';
                                      return null;
                                    },
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
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              _signInWithEmailAndPassword();
                            }
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
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text("Iniciar sesión", style: TextStyle(color: Colors.white),),
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
                            "Crear cuenta",
                            style: TextStyle(color: Colors.black, decoration: TextDecoration.underline)),
                      )
                      ))],
                    ),)
                ]
            ))
        ));
  }
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
      ))
          .user;
      globals.usuario = user;


      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return RedirectScreen(
          user: user,
        );
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }
}

//decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(70),
//                               color: Colors.teal[900]