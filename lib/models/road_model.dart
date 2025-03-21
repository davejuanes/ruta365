import 'package:flutter/material.dart';

class Road {
  String name;
  String font;
  String img;
  List<String> roadSteps;
  Road({
    required this.name,
    required this.font,
    required this.img,
    required this.roadSteps
  });

  factory Road.fromJson(Map<String, dynamic> json) {
    return Road(
      name: json['name'],
      font: json['font'],
      img: json['IMG'],
      roadSteps: List<String>.from(json['description'])
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'font': font,
      'IMG': img,
      'description': roadSteps
    };
  }

  @override
  String toString() {
    return 'Road{name: $name, font: $font, img: $img, roadSteps: $roadSteps}';
  }
}