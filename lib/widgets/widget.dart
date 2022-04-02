import 'package:ddgj_wallpaper/view/image_view.dart';
import 'package:flutter/material.dart';

import '../model/wallpaper_model.dart';

Widget brandName() {
  return RichText(
    textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(text: 'DDGJ', style: TextStyle(color: Colors.white)),
          TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black),)
        ]
      )
  );
}

Widget wallpappersList({required List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context, 
                    MaterialPageRoute(
                        builder: (context) =>
                            ImageView(imgUrl: wallpaper.src.portrait)
                    )
                );
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                      child: Image.network(wallpaper.src.portrait, fit: BoxFit.cover,)
                  )
                ),
              ),
            )
        );
      }).toList(),
    ),
  );
}