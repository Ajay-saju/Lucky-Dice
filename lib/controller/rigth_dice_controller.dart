
import 'dart:math';

import 'package:get/get.dart';

class RightDiceController extends GetxController{
  var rightDiceNo ;
  num value =0;
  
    @override
  void onInit() {
    super.onInit();
    rightDiceNo=1;
  }
  randomNo(){
    rightDiceNo = Random().nextInt(6) + 1;
    value= value+rightDiceNo;
    update();
  }
}