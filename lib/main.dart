// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
/*
import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'tabs_page.dart';
*/
//source:
//suivi la video https://www.youtube.com/watch?v=aKgEEnVhU1I&t=61s
//positionné les éléments: https://medium.flutterdevs.com/stack-and-positioned-widget-in-flutter-3d1a7b30b09a
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectPage(),
    );
  }
}

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(
              "Bienvenue !",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "GoogleSans-Bold",
                fontSize: 30.53169,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Veuillez vous connecter ou \n créer un nouveau compte \n pour utiliser l’application",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "ProximaNova-Regular",
                fontSize: 15.265845,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "E-mail",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Mot de passe",
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Color(0xFF636af6),
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.52)),
                onPressed: () {},
                child: Text("Se connecter",
                    style: TextStyle(
                        color: Color(0xFFFFFFff),
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 15.239016,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Color(0xFF636af6),
                elevation: 0.0,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.52)),
                onPressed: () {},
                child: Text("Créer un compte",
                    style: TextStyle(
                        color: Color(0xFFFFFFff),
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 15.239016,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Mot de passe oublié",
              style: TextStyle(
                color: Color(0xAFA9A9A9),
                fontFamily: "ProximaNova-Regular",
                fontSize: 15.239016,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          /*RawMaterialButton(
              fillColor: Color(0xFF636af6),
              elevation: 0.0,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.52)),
              onPressed: () {},
              child: Text("Se connecter",
                  style: TextStyle(
                    height: 0.2,
                    color: Colors.white,
                    fontSize: 15.0,
                  ))),
        */
        ],
      ),
    );
  }
}
