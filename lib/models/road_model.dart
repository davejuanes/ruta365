import 'package:flutter/material.dart';

class Road {
  int id;
  String name;
  String font;
  String img;
  List<String> roadSteps;
  Road({
    required this.id,
    required this.name,
    required this.font,
    required this.img,
    required this.roadSteps
  });

  factory Road.fromJson(Map<String, dynamic> json) {
    return Road(
      id: json['id'],
      name: json['name'],
      font: json['font'],
      img: json['IMG'],
      roadSteps: List<String>.from(json['description'])
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'font': font,
      'IMG': img,
      'description': roadSteps
    };
  }

  @override
  String toString() {
    return 'Road{id: $id, name: $name, font: $font, img: $img, roadSteps: $roadSteps}';
  }
}