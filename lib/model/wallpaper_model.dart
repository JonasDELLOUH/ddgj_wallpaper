class WallpaperModel{

  late String photographer;
  late String photographer_url;
  late int photographer_id;
  late SrcModel src;

  WallpaperModel.simple(){}

  WallpaperModel({required this.src, required this.photographer_url, required this.photographer_id, required this.photographer});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        photographer_url: jsonData["photographer_url"],
        photographer: jsonData["photographer"],
        src: SrcModel.fromMap(jsonData["src"]),
        photographer_id: jsonData["photographer_id"]
    );
  }
}

class SrcModel{

  String original;
  String small;
  String portrait;

  SrcModel({required this.portrait, required this.original, required this.small});

  factory SrcModel.fromMap(Map<String, dynamic> srcJsonData){
    return SrcModel(
        small: srcJsonData["small"],
        portrait: srcJsonData["portrait"],
        original: srcJsonData["original"]
    );
  }
}