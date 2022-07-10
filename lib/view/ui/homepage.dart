import 'package:dice_app/controller/count_controll.dart';
import 'package:dice_app/controller/left_dice_controller.dart';
import 'package:dice_app/controller/rigth_dice_controller.dart';
import 'package:dice_app/view/ui/confetti.dart';
import 'package:dice_app/view/ui/core/color/colors.dart';
import 'package:dice_app/view/widget/player_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final bool selectItem;
  final String whoIsTheFirstPlayer;
  const HomePage(
      {Key? key, required this.selectItem, required this.whoIsTheFirstPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftDiceController = Get.put(LeftDiceController());
    final rightDiceController = Get.put(RightDiceController());
    final countControll = Get.put(CountControll());
    print(whoIsTheFirstPlayer);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 30, 60),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Lucky Dice',
            style: GoogleFonts.titanOne(
              textStyle: const TextStyle(
                fontSize: 50,
                color: Color.fromARGB(255, 205, 199, 16),
              ),
            )),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetBuilder<CountControll>(
                builder: (controller) {
                  final count =
                      (countControll.count / 2).toString().substring(0, 1);
                  return Text(
                    count.toString(),
                    style: GoogleFonts.cinzel(
                        textStyle: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: white)),
                  );
                },
              ),
              GetBuilder<CountControll>(builder: (controller) {
                return Center(
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: PlayerTextWidget(
                                text: 'Player One',
                                color: selectItem == true ? green : blue,
                              ),
                            ),
                            InkWell(onTap: () {
                              if (countControll.count != 0) {
                                if (countControll.count % 2 == 0) {
                                  leftDiceController.randomNo();
                                  countControll.decrimentCount();
                                  countControll.winner(
                                      leftDiceController.leftDiceNo, 0);
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Turn of player 2')));
                                }
                              } else {
                                //  countControll.finalWinner();
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Only 5 Throw each')));
                              }
                            }, child: GetBuilder<LeftDiceController>(
                              builder: (controller) {
                                return Image.asset(
                                  'asset/images/dice${leftDiceController.leftDiceNo}.png',
                                  color: selectItem == true ? green : blue,
                                );
                              },
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            PlayerTextWidget(
                              text: selectItem ? 'Odd' : 'Even',
                              color: selectItem == true ? green : blue,
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: PlayerTextWidget(
                                text: 'Player Two',
                                color: selectItem == true ? blue : green,
                              ),
                            ),
                            InkWell(onTap: () {
                              // countControll.finalWinner();
                              if (countControll.count != 0) {
                                if (countControll.count % 2 != 0) {
                                  rightDiceController.randomNo();
                                  countControll.decrimentCount();
                                  countControll.winner(
                                      0, rightDiceController.rightDiceNo);
                                  if (countControll.count == 0) {
                                    countControll.finalWinner();
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Turn of player 1')));
                                }
                              } else {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Only 5 Throw each')));
                              }
                            }, child: GetBuilder<RightDiceController>(
                              builder: (controller) {
                                return Image.asset(
                                  'asset/images/dice${rightDiceController.rightDiceNo}.png',
                                  color: selectItem == true ? blue : green,
                                );
                              },
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            PlayerTextWidget(
                              text: selectItem ? 'Even' : 'Odd',
                              color: selectItem == true ? blue : green,
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: GetBuilder<CountControll>(
                  builder: (controller) {
                    return Text(countControll.sum.toString(),
                        style: GoogleFonts.pressStart2p(
                            textStyle: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 228, 228, 9))));
                  },
                ),
              ),
            ],
          ),
          GetBuilder<CountControll>(builder: (controller) {
            final winner =
                whoIsTheWinner(countControll.count, whoIsTheFirstPlayer);
            print("===============$winner");

            return Visibility(
                visible: countControll.pottitheri,
                child: Confetti(
                  winner: winner,
                ));
          })
        ],
      ),
    );
  }

  String whoIsTheWinner(num count, String whoIsTheFirstPlayer) {
    String winner;
    if (count % 2 == 0 && whoIsTheFirstPlayer == 'Green') {
      winner = 'Second Player';
    } 
    else if (count % 2 == 0 && whoIsTheFirstPlayer == 'Blue') {
      winner = 'First Player';
    }
   else if(count % 2 != 0 && whoIsTheFirstPlayer == 'Green'){
      winner = 'First Player';
    }
     else {
      winner = 'Second Player';
    }
    return winner;
  }
}
