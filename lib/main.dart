// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//source:
//https://www.youtube.com/watch?v=4vKiJZNPhss&t=293s
//suivi la video https://www.youtube.com/watch?v=aKgEEnVhU1I&t=61s
//positionné les éléments: https://medium.flutterdevs.com/stack-and-positioned-widget-in-flutter-3d1a7b30b09a
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/like_vide.dart';
import 'package:projet/pageAccueil.dart';
import 'package:projet/pageConnect.dart';
import 'package:projet/home.dart';
import 'package:projet/searchPage.dart';
import 'package:projet/wish_vide.dart';
import 'firebase_options.dart';
import 'pageInscription.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Acc(),
    );
  }
}

class Acc extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return pageAccueil();
            } else {
              return ConnectPage();
            }
          }));
}
