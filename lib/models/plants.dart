import 'package:get/get.dart';

class Plant {
  int? id;
  String? name;
  String? smallDescription;
  String? description;
  String? heightRange;
  String? tempratureRange;
  String? pot;
  double? price;
  RxBool? isFavorite;
  List? images;
  Plant({
    required this.id,
    required this.name,
    required this.smallDescription,
    required this.description,
    required this.heightRange,
    required this.tempratureRange,
    required this.pot,
    required this.isFavorite,
    required this.price,
    required this.images,
  });
}

List<Map<String, dynamic>> plantsList = [
  {
    "name": "Snake Plants",
    "price": 10.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_1.png',
      'assets/plants/plant_7.png',
      'assets/plants/plant_8.png',
    ]
  },
  {
    "name": "Lucky Jade Plant",
    "price": 12.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_2.png',
    ]
  },
  {
    "name": "Small Plant",
    "price": 12.99,
    "smallDescription": "Super green",
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": ['assets/plants/plant_3.png']
  },
  {
    "name": "Peperomia Plant",
    "price": 12.99,
    "smallDescription": "Super green",
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_4.png',
    ]
  },
  {
    "name": "Lucky Jade Plant",
    "price": 12.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_5.png',
    ]
  },
  {
    "name": "Lucky Jade Plant",
    "price": 12.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_6.png',
    ]
  },
  {
    "name": "Lucky Jade Plant",
    "price": 12.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_7.png',
    ]
  },
  {
    "name": "Lucky Jade Plant",
    "price": 12.99,
    "description":
        "Plants make your life with minimal and happy love the plants more and enjoy life.",
    "heightRange": "30cm - 40cm",
    "tempratureRange": "20`C to 25`c",
    "images": [
      'assets/plants/plant_8.png',
    ]
  },
];
