import 'package:flutter/material.dart';

class PlantDetail extends StatefulWidget {
  final int id;
  const PlantDetail({super.key, required this.id});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('plant Detail'),
    );
  }
}
