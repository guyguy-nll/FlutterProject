//suivi la video https://www.youtube.com/watch?v=aKgEEnVhU1I&t=61s
//positionné les éléments: https://medium.flutterdevs.com/stack-and-positioned-widget-in-flutter-3d1a7b30b09a
//source: https://www.youtube.com/watch?v=4vKiJZNPhss&t=293s
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:projet/pageAccueil.dart';
import 'pageInscription.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                "Bienvenue!",
                style: TextStyle(
                  color: Color(0xFFFFFFff),
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
                  color: Color(0xFFFFFFff),
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
                controller: emailController,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.grey[800],
                  filled: true,
                  hintText: "E-mail",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordController,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: Colors.grey[800],
                  filled: true,
                  hintText: "Mot de passe",
                  hintStyle: TextStyle(color: Colors.white),
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
                  onPressed: () {
                    Connect();
                  },
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pageInscription()),
                    );
                  },
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
          ],
        ),
      ),
    );
  }

  Future Connect() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageAccueil()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
