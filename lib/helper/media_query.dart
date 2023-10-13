import 'package:flutter/material.dart' show BuildContext, MediaQuery;

screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
