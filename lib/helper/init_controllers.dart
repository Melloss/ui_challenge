import 'package:get/get.dart';
import '../controllers/ui_controller.dart';

Future init() async {
  Get.lazyPut(() => UIController());
}
