import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_book/screens/road_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> FetchRoads() async {
    // Android 10.0.2.2
    // IOS 127.0.0.1
    final url = Uri.parse('http://localhost:3001/roads');
    try { 
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['roads'];
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error in request');
      return [];
    }
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FetchRoads(),
        builder: (context, snapshot) {
          final roads = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No roads found'));
          } else {
            return ListView.builder(
            itemCount: roads.length,
            itemBuilder: (context, index) {
              return _RecipeCard(context, roads[index]);
            }
          );
          }
        }
      ),
      // Column(children: <Widget>[
      //   _RecipeCard(context),
      //   _RecipeCard(context)
      // ],),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showButton(context);
        },
      ),
    );
  }

  Future<void> _showButton(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (contexto) => Container(
        width: MediaQuery.of(context).size.width,
        height: 600,
        color: Colors.white,
        child: RecipeForm()
      )
    );
  }

  Widget _RecipeCard(BuildContext context, dynamic road) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RoadDetail(roadName: road['name'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 125,
            child: Center(
              child: Card(
                child: Row(children: <Widget>[
                  Container(
                    height: 125,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        road['IMG'],
                        fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 26),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(road['name'], style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),),
                      SizedBox(height: 4),
                      Container(
                        height: 2,
                        width: 75,
                        color: Colors.blue,
                      ),
                      Text(road['font'], style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),),
                      SizedBox(height: 4),
                    ],
                  )
                ],),
              ),
            ),
          ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _roadName = TextEditingController();
    final TextEditingController _roadFont = TextEditingController();
    final TextEditingController _roadIMG = TextEditingController();
    final TextEditingController _roadDescription = TextEditingController();

    return Padding(padding: EdgeInsets.all(8), 
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Road',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 24
              ),
            ),
            SizedBox(height: 16),
            _builderTextField(controller: _roadName, label: 'Road Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the road name';
                }
                return null;
              }
            ),
            SizedBox(height: 16),
            _builderTextField(controller: _roadFont, label: 'Font',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the font';
                }
                return null;
              }
            ),
            SizedBox(height: 16),
            _builderTextField(controller: _roadIMG, label: 'Image URL',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Image';
                }
                return null;
              }
            ),
            SizedBox(height: 16),
            _builderTextField(controller: _roadDescription, label: 'Description',
              maxlines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the description';
                }
                return null;
              }
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                child: Text('Add Road',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _builderTextField({
      required String label,
      required TextEditingController controller,
      required String? Function(String?) validator,
      int maxlines = 1
    }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontFamily: 'Quicksand',
          color: Colors.blue[900]
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(10)
        )
      ),
      validator: validator,
      maxLines: maxlines,
    );
  }
}