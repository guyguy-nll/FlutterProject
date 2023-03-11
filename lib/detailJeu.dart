import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projet/jeuModele.dart';
import 'package:flutter_svg/flutter_svg.dart';

class pageDetail extends StatefulWidget {
  //const pageDetail({Key? key}) : super(key: key);
  final int jeuId;
  pageDetail({required this.jeuId});

  @override
  State<pageDetail> createState() => _pageDetail();
}

class _pageDetail extends State<pageDetail> {
  /*

  late String _description = '';
  late String _image1 = '';
  late String _nom = '';
  late String _editeur = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    print(widget.jeuId);
    _fetchGameDetails();
  }

Future<void> _fetchGameDetails() async {
    setState(() {
      _isLoading = true;
    });
    final url =
        'https://store.steampowered.com/api/appdetails?appids=${widget.jeuId}&key=543CB15FFA49C7D4EAF4E917BBCC12B9';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final description = data['short_description'];
      //final nom = data['name'];
      //final image1 = data['header_image'];
      //final editeur = data['publishers'][0];
      setState(() {
        _description = description;
        _nom = nom;
       _image1 = image1;
       _editeur = editeur;
        _isLoading = false;
      });
      print(_nom);
      print(_description);

    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Erreur requete');
    }
  }
  */

  String _nom = '';
  String _description = '';
  String _image = '';
  String _editeur = '';
  bool _isLoading = true;
  bool like = false;
  bool wish = false;

  @override
  void initState() {
    super.initState();
    _fetchGameDetails();
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
      throw Exception('Failed to load game details');
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                    color: Colors.white,
                  )
                : SvgPicture.asset(
                    'assets/images/like.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                like = !like;
              });
            },
          ),
          SizedBox(width: 30.0),
          IconButton(
            icon: wish
                ? SvgPicture.asset(
                    'assets/images/whishlist_full.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  )
                : SvgPicture.asset(
                    'assets/images/whishlist.svg',
                    width: 20.0,
                    height: 20.0,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                wish = !wish;
              });
            },
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
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 40.23,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3.52)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RawMaterialButton(
                            fillColor: Color(0xFF636af6),
                            elevation: 0.0,
                            onPressed: () {},
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(_description ?? "Aucune description disponible",
                    style: TextStyle(
                        color: Color(0xFFFFFFff),
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 15.265845,
                        fontWeight: FontWeight.w400)),
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
                    Image.asset("assets/images/jeu.jpg",
                        width: 79.85, height: 79.85),
                    Column(
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
