import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/color_pallet.dart';
import '../controllers/ui_controller.dart';
import '../helper/media_query.dart';

class PlantDetail extends StatefulWidget {
  final int id;

  const PlantDetail({super.key, required this.id});

  @override
  State<PlantDetail> createState() => _PlantDetailState();
}

class _PlantDetailState extends State<PlantDetail> with ColorPallet {
  int currentIndex = 0;
  UIController uiController = Get.find();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            _buildCarousel(),
            _buildTilte(),
          ],
        ));
  }

  _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: textColor,
              size: 28,
            ),
          )
        ],
      ),
    );
  }

  _buildCarousel() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: screenHeight(context) * 0.45,
          child: PageView(
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            controller: pageController,
            children: [
              _buildSlide(uiController.plants[widget.id].images![0]),
              _buildSlide(uiController.plants[widget.id].images![0]),
              _buildSlide(uiController.plants[widget.id].images![0]),
            ],
          ),
        ),
        _buildCarouselBuillets(),
      ],
    );
  }

  _buildCarouselBuillets() {
    return Positioned(
      bottom: 50,
      right: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildBullet(0),
          _buildBullet(1),
          _buildBullet(2),
        ],
      ),
    );
  }

  _buildBullet(int bulletId) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      width: 8,
      height: currentIndex == bulletId ? 20 : 8,
      decoration: BoxDecoration(
        color: currentIndex == bulletId
            ? foregroundColor
            : textColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  _buildSlide(String path) {
    return Hero(
      tag: 'plant-${widget.id}',
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  _buildTilte() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 10),
      child: Text(
        uiController.plants[widget.id].name!,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 25,
            ),
      ),
    );
  }
}
