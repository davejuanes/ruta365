import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_book/models/road_model.dart';
import 'package:http/http.dart' as http;

class RoadsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Road> roads = [];
  List<Road> favoriteRoad = [];

  // Android 10.0.2.2
  // IOS 127.0.0.1
  Future<void> fetchRoads() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3001/roads');
    try { 
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        roads = List<Road>.from(data['roads']
        .map((road) => Road.fromJson(road)));
      } else {
        print('Error: ${response.statusCode}');
        roads = [];
      }
    } catch (e) {
      print('Error in request');
      roads = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Road road) async {
    final isFavorite = favoriteRoad.contains(road);
    try {
      final url = Uri.parse('http://localhost:3001/favorites');
      final response = isFavorite
        ? await http.delete(url, body: json.encode({"id": road.id}))
        : await http.post(url, body: json.encode(road.toJson()));
        ;
        if (response.statusCode == 200) {
          if (isFavorite) {
            favoriteRoad.remove(road);
          } else {
            favoriteRoad.add(road);
          }
          notifyListeners();
        } else {
          print('Error: ${response.statusCode}');
          throw Exception('Failed to uodate favorite roads');
        }
    } catch (e) {
      print('Error updating favorite roads $e');
    }
  }
}