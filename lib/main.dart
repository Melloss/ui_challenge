import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import './screens/intro.dart';
import './helper/color_pallet.dart';
import './helper/init_controllers.dart' as controllers;
import '../controllers/ui_controller.dart';

class App extends StatelessWidget with ColorPallet {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Intro(),
      theme: _buildThemeData(),
      debugShowCheckedModeBanner: false,
    );
  }

  _buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: backgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 40,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        titleMedium: GoogleFonts.montserrat(
          color: textColor,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.montserrat(
          color: textColor.withOpacity(0.8),
        ),
      ),
      iconTheme: IconThemeData(
        color: textColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(textColor),
        ),
      ),
    );
  }
}

main() {
  controllers.init();
  UIController uiController = Get.find();
  uiController.initPlants();
  runApp(App());
}
