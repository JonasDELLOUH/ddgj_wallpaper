import 'dart:convert';

import 'package:ddgj_wallpaper/widgets/widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../model/wallpaper_model.dart';

import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  late final String searchQuery;
 Search({required this.searchQuery});


  @override
  _SearchState createState() => _SearchState();

}

class _SearchState extends State<Search> {

  List<WallpaperModel> wallpapers = [];

  TextEditingController? searchController = TextEditingController();

  getSearchWallpapers(String searchQry) async{
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$searchQry&per_page=16"),
        headers: {
          "Authorization" : apiKey
        }
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element){
      if (kDebugMode) {
        print("element : $element");
      }

      WallpaperModel wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController!.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search wallpaper",
                              border: InputBorder.none
                          ),
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        getSearchWallpapers(searchController!.text);
                      },
                      child: Container(
                          child: const Icon(Icons.search)
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              wallpappersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }

}