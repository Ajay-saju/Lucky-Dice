import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Confetti extends StatefulWidget {
  final String winner;
  const Confetti({Key? key, required this.winner}) : super(key: key);

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  late ConfettiController _confettiControllerCenter;

  @override
  void initState() {
    super.initState();
    _confettiControllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiControllerCenter.play();
  }

  @override
  void dispose() {
    super.dispose();
    _confettiControllerCenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String won = widget.winner;
    return SafeArea(
        child: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiControllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
        Center(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "The winner is\n$won",
              style: GoogleFonts.rubikMoonrocks(
                  textStyle: const TextStyle(
                      fontSize: 40,
                      color: Colors.lime,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
      ],
    ));
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
