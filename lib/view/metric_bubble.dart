import 'package:flutter/material.dart';
import 'package:metrics_bubble_demo/model/body_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MetricBubble extends StatelessWidget {
  static const bubbleDiameter = 272.0;

  static const bubbleBoxDecoration = BoxDecoration(
    color: Color(0xff53a99a),
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        offset: Offset(0, 27),
        blurRadius: 33,
        color: Color(0x3827ae96),
      )
    ],
  );

  static const labelTextStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontWeight: FontWeight.bold,
    fontSize: 19,
    color: Colors.white,
  );

  static const weightTextStyle = TextStyle(
    fontFamily: 'League Gothic',
    fontSize: 127,
    height: 1.1,
    color: Colors.white,
    // backgroundColor: Colors.amber
  );

  static const unitTextStyle = TextStyle(
    fontFamily: 'League Gothic',
    fontSize: 38,
    color: Color(0x80ffffff),
    height: 0.5,
  );

  final BodyWeight bodyWeight;

  const MetricBubble(this.bodyWeight);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {print('dsfsd');},
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: bubbleBoxDecoration,
        height: bubbleDiameter,
        width: bubbleDiameter,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bodyWeight.label,
                      style: labelTextStyle,
                    ),
                    Text(
                      '${bodyWeight.weight}',
                      style: weightTextStyle,
                    ),
                    Text(
                      'lbs',
                      style: unitTextStyle,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(flex: 2,),
                  Center(
                    child: SvgPicture.asset(
                      'images/graph.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
