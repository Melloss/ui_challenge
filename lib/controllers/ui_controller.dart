import 'package:get/get.dart';
import '../models/plants.dart';

class UIController extends GetxController {
  List<Plant> plants = [];
  initPlants() {
    for (int i = 0; i < plantsList.length; i++) {
      Plant plant = Plant(
        id: i,
        name: plantsList[i]["name"],
        description: plantsList[i]['description'],
        heightRange: plantsList[i]['heightRange'],
        tempratureRange: plantsList[i]['tempratureRange'],
        price: plantsList[i]['price'],
        images: plantsList[i]['images'],
        isFavorite: false.obs,
        pot: plantsList[i].containsKey('pot')
            ? plantsList[i]['pot']
            : 'Ciramic Pot',
        smallDescription: plantsList[i].containsKey('smallDescription')
            ? plantsList[i]['smallDescription']
            : '',
      );
      plants.add(plant);
    }
    print(plants[0].name);
  }
}
