import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/road_model.dart';
import 'package:recipe_book/providers/roads_provider.dart';
import 'package:recipe_book/screens/road_detail.dart';

class FavoritesRoads extends StatelessWidget {
  const FavoritesRoads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RoadsProvider>(
          builder: (context, roadProvider, child) {
            final favoriteRoads = roadProvider.favoriteRoad;

            return favoriteRoads.isEmpty
                ? Center(child: Text('No favorite roads found'))
                : ListView.builder(
                    itemCount: favoriteRoads.length,
                    itemBuilder: (context, index) {
                      final road = favoriteRoads[index];
                      return favoriteRoadsCard(road: road);
                    });
          },
        ));
  }
}

class favoriteRoadsCard extends StatelessWidget {
  final Road road;
  const favoriteRoadsCard({super.key, required this.road});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RoadDetail(roadsData: road)));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(road.name),
            Text(road.font),
          ],
        ),
      ),
    );
  }
}
