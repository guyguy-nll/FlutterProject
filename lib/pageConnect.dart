//suivi la video https://www.youtube.com/watch?v=aKgEEnVhU1I&t=61s
//positionné les éléments: https://medium.flutterdevs.com/stack-and-positioned-widget-in-flutter-3d1a7b30b09a
//source: https://www.youtube.com/watch?v=4vKiJZNPhss&t=293s
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:projet/pageAccueil.dart';
import 'pageInscription.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  //controller pour récuperer les saisie de mot de passe et email
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A2026),
      body: Stack(
        children: [
          //image de fond d'écran
          Opacity(
            opacity: 0.8,
            child: SvgPicture.asset(
              'assets/images/background.svg',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Bienvenue !",
                  style: TextStyle(
                    color: Color(0xFFFFFFff),
                    fontFamily: "GoogleSans-Bold",
                    fontSize: 30.53169,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Veuillez vous connecter ou \n créer un nouveau compte \n pour utiliser l’application",
                  style: TextStyle(
                    color: Color(0xFFFFFFff),
                    fontFamily: "ProximaNova-Regular",
                    fontSize: 15.265845,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: TextField(
                    //la saisie est enregistrée dabs le controller d'email
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "E-Mail",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: TextField(
                    //la saisie est enregistrée dabs le controller de mot de passe
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      fillColor: Color(0xff1E262B),
                      filled: true,
                      hintText: "Mot de passe",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF636af6),
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.52)),
                      onPressed: () {
                        //le bouton active la fonction Connect si on appuie dessus
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pageInscription()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          elevation: 0.0,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.52)),
                          side: BorderSide(color: Color(0xFF636af6)),
                          backgroundColor: Color(0xff1A2025)),
                      child: Text("Créer un nouveau compte",
                          style: TextStyle(
                              color: Color(0xFFFFFFff),
                              fontFamily: "ProximaNova-Regular",
                              fontSize: 15.239016,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Mot de passe oublié",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xAFA9A9A9),
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 15.239016,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //fonction pour tester si l'email et le mot de passe sont enregistrées dans firebase
  Future Connect() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          //si firebase reconnait l'email et le mot de passe saisie on est renvoyé vers l'accueil
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
