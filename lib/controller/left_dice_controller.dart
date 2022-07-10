import 'dart:math';

import 'package:dice_app/controller/count_controll.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LeftDiceController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  final countController = CountControll();
  var leftDiceNo;
  num value = 0;
  int count = 5;

  @override
  void onInit() {
    super.onInit();
    leftDiceNo = 1;
  }

  randomNo() {
    leftDiceNo = Random().nextInt(6) + 1;
    value = value + leftDiceNo;

    update();
  }
}
