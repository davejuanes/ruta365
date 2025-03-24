import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/road_model.dart';
import 'package:recipe_book/providers/roads_provider.dart';

class RoadDetail extends StatefulWidget {
  final Road roadsData;
  const RoadDetail({super.key, required this.roadsData});

  @override
  _RoadDetailState createState() => _RoadDetailState();
}

class _RoadDetailState extends State<RoadDetail> {
  bool isFavorite = false;
  @override

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RoadsProvider>(context, listen: false).favoriteRoad.contains(widget.roadsData);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roadsData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white, onPressed: () {Navigator.pop(context);}),
        actions: [
          IconButton(
            onPressed: () async{
              await Provider.of<RoadsProvider>(context, listen: false).toggleFavoriteStatus(widget.roadsData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border))
        ],
      ),
    );
  }
}