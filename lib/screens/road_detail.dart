import 'package:flutter/material.dart';

class RoadDetail extends StatelessWidget {
  final String roadName;
  const RoadDetail({super.key, required this.roadName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roadName,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white, onPressed: () {Navigator.pop(context);}),
      ),
    );
  }
}