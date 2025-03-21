import 'package:flutter/material.dart';
import 'package:recipe_book/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola Mundo',
        home: RecipeBook());
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Ruta365',
            style: TextStyle(color: Colors.blue[900]),
          ),
          bottom: TabBar(
            indicatorColor: Colors.blue[900],
            labelColor: Colors.blue[900],
            unselectedLabelColor: Colors.blue[900],
            tabs: [
              Tab(icon: Icon(Icons.home),
                text: 'Mapa',
              ),
          ]),
        ),
        body: TabBarView(
          children: [HomeScreen()]
        ),
      ),
    );
  }
}
