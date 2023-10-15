import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
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
  bool isAddButtonClicked = false;
  String generatedTransactionRef = '';

  addButtonHandler() {
    if (uiController.orderedPlantsId.contains(widget.id)) {
      uiController.numberofOrdered[widget.id] =
          uiController.numberofOrdered[widget.id]! + 1;
    } else {
      uiController.orderedPlantsId.add(widget.id);
      uiController.numberofOrdered[widget.id] = 1;
    }
    setState(() {
      isAddButtonClicked = true;
    });
    Timer(const Duration(milliseconds: 150), () {
      setState(() {
        isAddButtonClicked = false;
      });
    });
  }

  calculateTotal() {
    uiController.totalPrice.value = 0;
    for (int i = 0; i < uiController.orderedPlantsId.length; i++) {
      uiController.totalPrice.value = uiController.totalPrice.value +
          (uiController.plants[uiController.orderedPlantsId[i]].price! *
              uiController.numberofOrdered[uiController.orderedPlantsId[i]]);
    }
  }

  generateTransactionReference() {
    DateTime now = DateTime.now();
    Random random = Random();
    int randomNumber = random.nextInt(10000);
    String transactionReference =
        '${now.year}${now.month}${now.day}-${now.hour}${now.minute}${now.second}-$randomNumber';
    generatedTransactionRef = transactionReference;
  }

  orderButtonHandler() async {
    generateTransactionReference();
    if (uiController.totalPrice.value > 0) {
      var headers = {
        'Authorization': 'Bearer CHASECK_TEST-7wwIlZaztz8Bcbzb84qrbCRQEu1Tbvb1',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://api.chapa.co/v1/transaction/initialize'));
      request.body = json.encode({
        "amount": "${uiController.totalPrice}",
        "email": "mikiyaass@gmail.com",
        "currency": "USD",
        "phone_number": "0900123456",
        "tx_ref": generatedTransactionRef,
        "customization[title]": "Payment for Plant(s)",
        "customization[description]": "I love online payments"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Map res = jsonDecode(await response.stream.bytesToString());
        String urlPayment = res['data']['checkout_url'];
        await launchUrl(Uri.parse(urlPayment));
        print('generatedRef: $generatedTransactionRef');
        Get.back();
        uiController.numberofOrdered = {}.obs;
        uiController.orderedPlantsId = [].obs;
      } else {
        print(response.reasonPhrase);
      }
    }
  }

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
            Expanded(child: Container()),
            _buildBottom(),
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
          GestureDetector(
            onTap: () {
              Get.dialog(_buildOrderedPlantDialog());
            },
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 30.0, left: 10, bottom: 10, top: 10),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: textColor,
                  size: 28,
                ),
              ),
              Visibility(
                visible: uiController.orderedPlantsId.isNotEmpty,
                child: Positioned(
                  bottom: 5,
                  right: 15,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: foregroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                        child: Text(
                      uiController.orderedPlantsId.length.toString(),
                      style: TextStyle(
                        color: white,
                      ),
                    )),
                  ),
                ),
              ),
            ]),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          uiController.plants[widget.id].name!,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 25,
              ),
        ),
        const SizedBox(height: 25),
        Text(
          uiController.plants[widget.id].description!,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 15,
              ),
        )
      ]),
    );
  }

  _buildBottom() {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.27,
      decoration: BoxDecoration(
        color: foregroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPlantProperty(Icons.height, 'height',
                  uiController.plants[widget.id].heightRange!),
              _buildPlantProperty(Bootstrap.thermometer, 'Temprature',
                  uiController.plants[widget.id].tempratureRange!),
              _buildPlantProperty(
                  Icons.crib, 'Pot', uiController.plants[widget.id].pot!),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: white,
                        ),
                  ),
                  Text(
                    '\$${uiController.plants[widget.id].price}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: white,
                        ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: addButtonHandler,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: isAddButtonClicked == false ? 190 : 200,
                  height: isAddButtonClicked == false ? 75 : 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF67864A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text(
                    'Add to Cart',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: white,
                        ),
                  )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildPlantProperty(IconData icon, String titile, String desc) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: white,
        ),
        const SizedBox(height: 5),
        Text(
          titile,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: white,
                fontSize: 16,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          desc,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: white,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  Widget _buildOrderedPlantDialog() {
    calculateTotal();
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        GestureDetector(
          onTap: orderButtonHandler,
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 100,
            decoration: BoxDecoration(
              color: foregroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Order',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: white,
                  ),
            ),
          ),
        ),
      ],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < uiController.numberofOrdered.length; i++)
            Obx(
              () => Visibility(
                visible: uiController
                        .numberofOrdered[uiController.orderedPlantsId[i]] !=
                    0,
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: screenWidth(context),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(uiController
                              .plants[uiController.orderedPlantsId[i]].name!),
                          Text(
                              '\$${uiController.plants[uiController.orderedPlantsId[i]].price}'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              uiController.numberofOrdered[
                                      uiController.orderedPlantsId[i]] =
                                  uiController.numberofOrdered[
                                          uiController.orderedPlantsId[i]]! +
                                      1;
                              calculateTotal();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: foregroundColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              uiController.numberofOrdered[
                                      uiController.orderedPlantsId[i]] =
                                  uiController.numberofOrdered[
                                          uiController.orderedPlantsId[i]]! -
                                      1;
                              calculateTotal();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  '-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Obx(
                            () => Text(
                                'X${uiController.numberofOrdered[uiController.orderedPlantsId[i]]}'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Obx(() => Text(
                    '\$${uiController.totalPrice.value}',
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
        ],
      ),
    );
  }
}
