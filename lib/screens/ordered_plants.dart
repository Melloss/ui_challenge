import 'package:flutter/material.dart';

class OrderedPlants extends StatefulWidget {
  const OrderedPlants({super.key});

  @override
  State<OrderedPlants> createState() => _OrderedPlantsState();
}

class _OrderedPlantsState extends State<OrderedPlants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              'Ordered Plants',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )
        ],
      ),
    );
  }
}
