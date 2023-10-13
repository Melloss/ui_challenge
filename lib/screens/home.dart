import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../helper/color_pallet.dart';
import '../helper/media_query.dart' show screenWidth;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ColorPallet {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        _buildAppBar(),
        _buildSearchBar(),
      ]),
    );
  }

  _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          'Search Products',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const CircleAvatar(
          radius: 23,
          backgroundImage: AssetImage('assets/avatar_logo.png'),
        ),
      ],
    );
  }

  _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth(context) * 0.7,
            height: 50,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              onChanged: (text) {},
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 16,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Icon(
                      BoxIcons.bx_search,
                      color: textColor.withOpacity(0.5),
                      size: 23,
                    ),
                  )),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              LineAwesome.sliders_h_solid,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
