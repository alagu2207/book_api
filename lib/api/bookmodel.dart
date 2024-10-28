// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) =>
    List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  String name;
  String author;
  String description;
  int datepublished;
  String publisher;
  String welcomeDescription;
  String id;

  Welcome({
    required this.name,
    required this.author,
    required this.description,
    required this.datepublished,
    required this.publisher,
    required this.welcomeDescription,
    required this.id,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        name: json["name"],
        author: json["author"],
        description: json["Description"],
        datepublished: json["datepublished"],
        publisher: json["publisher"],
        welcomeDescription: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "Description": description,
        "datepublished": datepublished,
        "publisher": publisher,
        "description": welcomeDescription,
        "id": id,
      };
}
