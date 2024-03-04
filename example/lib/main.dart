import 'package:flutter/material.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const overflowText =
        'Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text Overflow text';

    const labelStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue);
    const descriptionStyle = TextStyle(fontSize: 14);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Default overflow text',
              style: labelStyle,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              overflowText,
              overflow: TextOverflow.ellipsis,
              style: descriptionStyle,
            ),
            SizedBox(
              height: 32,
            ),
            OverflowTextAnimated(
              text: 'Scroll opposite loop',
              style: labelStyle,
              animation: OverFlowTextAnimations.scrollOpposite,
              animateDuration: Duration(milliseconds: 500),
            ),
            SizedBox(
              height: 4,
            ),
            OverflowTextAnimated(
              text: overflowText,
              style: descriptionStyle,
              animation: OverFlowTextAnimations.scrollOpposite,
              animateDuration: Duration(milliseconds: 500),
            ),
            SizedBox(
              height: 32,
            ),
            OverflowTextAnimated(
              text: 'Infinite loop',
              style: labelStyle,
              animation: OverFlowTextAnimations.infiniteLoop,
              loopSpace: 30,
            ),
            SizedBox(
              height: 4,
            ),
            OverflowTextAnimated(
              text: overflowText,
              style: descriptionStyle,
              animation: OverFlowTextAnimations.infiniteLoop,
              loopSpace: 30,
            ),
          ],
        ),
      ),
    );
  }
}
