import 'dart:convert';

import 'package:ddgj_wallpaper/model/wallpaper_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../widgets/widget.dart';

class Categorie extends StatefulWidget {
  late final String categorieName;

  Categorie({required this.categorieName});

  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {


  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String categoryName) async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$categoryName&per_page=16"),
        headers: {
          "Authorization": apiKey
        }
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      if (kDebugMode) {
        print("element : $element");
      }

      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
      setState(() {

      });
    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16,),
            wallpappersList(wallpapers: wallpapers, context: context),
          ],
        ),
      ),
    );
  }
}
