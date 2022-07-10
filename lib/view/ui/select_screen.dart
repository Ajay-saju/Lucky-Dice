import 'package:dice_app/view/ui/homepage.dart';
import 'package:dice_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool green = true ;
    bool blue = false;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomButton(
              title: 'Odd',
              height: 100,
              fontSize: 18,
              primary: Colors.green,
              onPressed: () {
                Get.to( HomePage(selectItem: green, whoIsTheFirstPlayer: 'Green',));
              }),
          const Text(
            "OR",
            style: TextStyle(fontSize: 100),
          ),
          CustomButton(
              title: 'Even',
              height: 100,
              fontSize: 20,
              primary: Colors.blue,
              onPressed: () {
                Get.to( HomePage(selectItem: blue, whoIsTheFirstPlayer: 'Blue',));
              }),
        ],
      ),
    ));
  }
}
