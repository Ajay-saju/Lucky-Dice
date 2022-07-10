import 'package:get/get.dart';

class CountControll extends GetxController {
  var count;
  num sum = 0;

  bool pottitheri = false;

  @override
  void onInit() {
    super.onInit();
    count = 10;
  }

  decrimentCount() {
    if (count != 0) {
      count = --count;
      update();
    }

    print(count);
  }

  winner(num value1, num value2) {
    if (count != 0) {
      sum += value1 + value2;
      update();
      print("________________________$sum");
    }
  }

  finalWinner() {
    pottitheri = true;

    if (sum % 2 == 0) {
      print('even');
    } else {
      print('odd');
    }

    update();
  }
}
