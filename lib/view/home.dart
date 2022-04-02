import 'dart:convert';

import 'package:ddgj_wallpaper/data/data.dart';
import 'package:ddgj_wallpaper/model/categories_model.dart';
import 'package:ddgj_wallpaper/model/wallpaper_model.dart';
import 'package:ddgj_wallpaper/view/search.dart';
import 'package:ddgj_wallpaper/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

import 'categorie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{
  final TextEditingController search = TextEditingController();

  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  getTrendingWallpapers() async{
    var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=16&page=1"),
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
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
            child: brandName(),
          margin: EdgeInsets.symmetric(horizontal: 100),
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        //controller: search,
                      )
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(searchQuery: '',)
                          )
                      );
                    },
                    child: Container(
                        child: Icon(Icons.search)
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              height: 80,
              child: ListView.builder(
                itemCount: categories.length,
                //shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoriesTile(
                      title: categories[index].categorieName,
                      imgUrl: categories[index].imgUrl
                  );
                },
              ),
            ),
            wallpappersList(wallpapers: wallpapers, context: context),
            Container(
              color: Colors.red, height: 40,
              child: Text("Pour plus d'info, contactez le 96 13 35 25", style: TextStyle(color: Colors.white,fontSize: 19),),
              //margin: EdgeInsets.symmetric(horizontal: 50),
            )
          ],
        ),
      ),
    );
  }

}

class CategoriesTile extends StatelessWidget {
  
  late String imgUrl, title;

  CategoriesTile({Key? key, required this.title, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                  categorieName: title.toLowerCase(),
                )
            )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover,),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                borderRadius: BorderRadius.circular(8)
              ),
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),),
            )
          ],
        ),
      ),
    );
  }

}