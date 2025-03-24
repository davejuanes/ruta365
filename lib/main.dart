import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/providers/roads_provider.dart';
import 'package:recipe_book/screens/favorites_roads.dart';
import 'package:recipe_book/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoadsProvider())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ruta 365',
          home: Ruta365()),
    );
  }
}

class Ruta365 extends StatelessWidget {
  const Ruta365({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Ruta365',
            style: TextStyle(color: Colors.blueGrey),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.blueGrey,
            labelColor: Colors.blueGrey,
            unselectedLabelColor: Colors.blueGrey,
            tabs: [
              Tab(icon: Icon(Icons.home),
                text: 'Mapa',
              ),
              Tab(icon: Icon(Icons.favorite),
                text: 'Favoritos',
              ),
          ]),
        ),
        body: const TabBarView(
          children: [HomeScreen(), FavoritesRoads()],
        ),
      ),
    );
  }
}
