// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//source:
//suivi la video https://www.youtube.com/watch?v=aKgEEnVhU1I&t=61s
//positionné les éléments: https://medium.flutterdevs.com/stack-and-positioned-widget-in-flutter-3d1a7b30b09a
//source: https://firebase.google.com/docs/auth/flutter/start?hl=fr
//https://firebase.google.com/docs/firestore/quickstart?hl=fr
//https://docs.flutter.dev/
//pour effectuer l'inscription dans firebase:
//https://www.freecodespot.com/blog/flutter-login-and-registration-using-firebase/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/pageAccueil.dart';
import 'package:projet/searchPage.dart';

class pageInscription extends StatefulWidget {
  const pageInscription({super.key});

  @override
  State<pageInscription> createState() => _pageInscription();
}

class _pageInscription extends State<pageInscription> {
  final FirebaseAuth Auth = FirebaseAuth.instance;
  final TextEditingController nomControl = TextEditingController();
  final TextEditingController mailControl = TextEditingController();
  final TextEditingController mdpControl = TextEditingController();
  final TextEditingController mdpverifControl = TextEditingController();
  bool testmdp = true;
  bool charge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A2025),
      body: charge
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Inscription",
                    style: TextStyle(
                      color: Color(0xFFFFFFff),
                      fontFamily: "GoogleSans-Bold",
                      fontSize: 30.53169,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Veuillez saisir ces différentes informations, \nafin que vos listes soient sauvegardées.",
                    style: TextStyle(
                      color: Color(0xFFFFFFff),
                      fontFamily: "ProximaNova-Regular",
                      fontSize: 15.265845,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: TextFormField(
                    controller: nomControl,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "Nom d’utilisateur",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: TextFormField(
                    controller: mailControl,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: TextFormField(
                    controller: mdpControl,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "Mot de passe",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: testmdp
                          ? SizedBox()
                          : Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: TextFormField(
                    controller: mdpverifControl,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "Vérification de mot de passe",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF636af6),
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.52)),
                      onPressed: () {
                        Inscript();
                      },
                      child: Text("S'inscrire",
                          style: TextStyle(
                              color: Color(0xFFFFFFff),
                              fontFamily: "ProximaNova-Regular",
                              fontSize: 17.61,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> Inscript() async {
    setState(() {
      charge = true;
    });
    if (mdpControl.text.trim() != mdpverifControl.text.trim()) {
      setState(() {
        testmdp = false;
        charge = false;
      });
      return;
    }
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: mailControl.text.trim(), password: mdpControl.text.trim());
      // Créer le document de l'utilisateur dans Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(result.user?.uid)
          .set({
        'likes': <String, String>{},
        'wishlist': <String, String>{},
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageAccueil()),
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      charge = false;
    });
  }
}
