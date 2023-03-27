import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet/detailJeu.dart';
import 'package:projet/jeuModele.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'avisModele.dart';

class pageAvis extends StatefulWidget {
  final int jeuId;
  pageAvis({required this.jeuId});

  @override
  State<pageAvis> createState() => _pageAvis();
}

class _pageAvis extends State<pageAvis> {
  //late CollectionReference<Map<String, dynamic>> _userLikesRef;
  List<AvisModel> listAvis = [];
  String _nom = '';
  String _description = '';
  String _image = '';
  String _editeur = '';
  bool _isLoading = true;
  bool like = false;
  bool wish = false;
  User? _user;
  late Map<String, dynamic> likes;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    chargerAvis();
    _fetchGameDetails();
    _checkCurrentUser();
    _checkIfLiked();
    _checkIfWished();
  }

  void _checkCurrentUser() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      setState(() {
        _user = user;
      });
      print("Utilisateur ${_user!.uid} est connecté");
    } else {
      print("Pas d'utilisateur connecté");
    }
  }

  void _checkIfLiked() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(user.uid)
          .get();
      if (userData.exists) {
        Map<String, dynamic> likes = userData.data()!['likes'] ?? {};
        setState(() {
          like = likes.containsKey(widget.jeuId.toString());
        });
      }
    }
  }

  void _checkIfWished() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(user.uid)
          .get();
      if (userData.exists) {
        Map<String, dynamic> wishlist = userData.data()!['wishlist'] ?? {};
        setState(() {
          wish = wishlist.containsKey(widget.jeuId.toString());
        });
      }
    }
  }

  Future<void> chargerAvis() async {
    final responseAvis = await http.get(Uri.parse(
        'https://store.steampowered.com/appreviews/${widget.jeuId}?json=1&&num_per_page=10'));

    if (responseAvis.statusCode == 200 && responseAvis.body.isNotEmpty) {
      final json = jsonDecode(responseAvis.body);
      final avisJson = json['reviews'] as List<dynamic>;
      for (var i = 0; i < avisJson.length; i++) {
        final String avis = avisJson[i]["review"] ?? '';
        print(avis);
        final maxChars = 30;

        final descriptionDimensionne = avis.length <= maxChars
            ? avis
            : '${avis.substring(0, maxChars)}...';

        //final String noteAvis = avisJson[i]["weighted_vote_score"];
        final AvisModel Avis = AvisModel(
            avis_description: descriptionDimensionne,
            //avis_etoile: noteAvis,
            jeu_id: widget.jeuId);

        setState(() {
          listAvis.add(Avis);
        });
      }

      ;
    } else {
      print('Erreur: ${responseAvis.statusCode}.');
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchGameDetails() async {
    final url =
        'https://store.steampowered.com/api/appdetails?appids=${widget.jeuId}&key=543CB15FFA49C7D4EAF4E917BBCC12B9';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final data = jsonResponse['${widget.jeuId}']['data'];

      final nom = data['name'] ?? '';
      final description = data['short_description'] ?? '';
      final image = data['header_image'] ?? '';
      final editeur =
          data['publishers'] != null ? data['publishers'][0] ?? '' : '';

      setState(() {
        _description = description;
        _nom = nom;
        _image = image;
        _editeur = editeur;
        _isLoading = false;
      });
    } else {
      throw Exception('Impossible de charger le jeux');
    }
  }

  void _toggleLike() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {
      return;
    }

    final docRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);

    final userData = await docRef.get();

    final Map<String, dynamic> likes = userData.data()!['likes'] ?? {};

    if (like) {
      setState(() {
        print("le jeu est deja liké on supprime le like");
        like = false;
      });

      docRef.update({
        'likes.${widget.jeuId}': FieldValue.delete(),
      });
    } else {
      setState(() {
        print("le jeu n est pas liké on l ajoute");
        like = true;
      });

      docRef.update({
        'likes.${widget.jeuId}': true,
      });
    }
  }

  void _toggleWish() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {
      return;
    }

    final docRef = FirebaseFirestore.instance.collection('Users').doc(user.uid);

    final userData = await docRef.get();

    final Map<String, dynamic> wishlist = userData.data()!['wishlist'] ?? {};

    if (wish) {
      setState(() {
        print("le jeu est deja wish on supprime le wish");
        wish = false;
      });

      docRef.update({
        'wishlist.${widget.jeuId}': FieldValue.delete(),
      });
    } else {
      setState(() {
        print("le jeu n est pas wish on l ajoute");
        wish = true;
      });

      docRef.update({
        'wishlist.${widget.jeuId}': true,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xff1A2026),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff1E262B),
        elevation: 0.0,
        title: Text(
          "Détail du jeu",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
        actions: [
          IconButton(
            icon: like
                ? SvgPicture.asset(
                    'assets/images/like_full.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.red,
                  )
                : SvgPicture.asset(
                    'assets/images/like.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  ),
            onPressed: _toggleLike,
          ),
          SizedBox(width: 30.0),
          IconButton(
            icon: wish
                ? SvgPicture.asset(
                    'assets/images/whishlist_full.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.yellow,
                  )
                : SvgPicture.asset(
                    'assets/images/whishlist.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  ),
            onPressed: _toggleWish,
          ),
          SizedBox(width: 10.0),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: (MediaQuery.of(context).size.height / 2) - 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 40.23,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.52),
                      border: Border.all(
                        color: Color(0xFF636af6),
                        width: 1,
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RawMaterialButton(
                            elevation: 0.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        pageDetail(jeuId: widget.jeuId)),
                              );
                            },
                            child: Text("DESCRIPTION",
                                style: TextStyle(
                                    color: Color(0xFFFFFFff),
                                    fontFamily: "GoogleSans-Bold",
                                    fontSize: 12.9172535,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: RawMaterialButton(
                            elevation: 0.0,
                            fillColor: Color(0xFF636af6),
                            onPressed: () {},
                            child: Text("AVIS",
                                style: TextStyle(
                                    color: Color(0xFFFFFFff),
                                    fontFamily: "GoogleSans-Bold",
                                    fontSize: 12.9172535,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: listAvis.length,
                    itemBuilder: (context, index) => SizedBox(
                      height: 70,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.17),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                                child: ColoredBox(
                              color: Color(0xFF232C34),
                            )),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(listAvis[index].avis_description!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.265845,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "ProximaNova-Regular",
                                          )),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 340,
                height: 110,
                color: Color.fromARGB(221, 34, 34, 34),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image.network(
                      _image,
                      width: 79.85,
                      height: 79.85,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(_nom,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.265845,
                                fontWeight: FontWeight.w400,
                                fontFamily: "ProximaNova-Regular",
                              )),
                          Text(_editeur,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "ProximaNova-Regular",
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
