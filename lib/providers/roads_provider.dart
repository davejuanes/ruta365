import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_book/models/road_model.dart';
import 'package:http/http.dart' as http;

class RoadsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Road> roads = [];

  Future<void> fetchRoads() async {
    // Android 10.0.2.2
    // IOS 127.0.0.1
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('http://localhost:3001/roads');
    try { 
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        roads = List<Road>.from(data.map((road) => Road.fromJson(road)));
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
}