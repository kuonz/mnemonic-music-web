import 'package:flutter/material.dart';

class MusicModel {
  String uuid;
  String name;
  String singer;
  String length;
  String url;

  MusicModel({
    @required this.uuid, 
    @required this.name, 
    @required this.singer, 
    @required this.length, 
    @required this.url
  });

  factory MusicModel.empty() {
    return MusicModel(
      uuid: "",
      name: "",
      singer: "",
      length: "",
      url: ""
    );
  }

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "singer": singer,
    "length": length,
    "url": url
  };

  static MusicModel fromJson(Map<String, dynamic> json) {
    return MusicModel(
      uuid: json["uuid"],
      name: json["name"],
      singer: json["singer"],
      length: json["length"],
      url: json["url"]
    );
  }
}