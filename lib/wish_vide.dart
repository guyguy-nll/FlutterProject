import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageWishvide extends StatefulWidget {
  const PageWishvide({super.key});

  @override
  State<PageWishvide> createState() => _PageWishvide();
}

class _PageWishvide extends State<PageWishvide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A2026),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Color(0xff1E262B),
        elevation: 0.0,
        title: Text(
          "Ma liste de souhaits",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/empty_whishlist.svg',
              width: 94.0,
              height: 94.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Vous n'avez pas whishé de contenu.\n cliquez sur le coeur pour en ajouter",
              style: TextStyle(
                color: Color(0xFFFFFFff),
                fontFamily: "ProximaNova-Regular",
                fontSize: 15.265845,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
