import 'package:flutter/material.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fullName = 'Trương Việt Hoàng';
    const description =
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.';

    const descriptionStyle = TextStyle(fontSize: 14);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blueGrey,
                child: FlutterLogo(size: 32),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fullName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: descriptionStyle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    OverflowTextAnimated(
                      description,
                      style: descriptionStyle,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      animateDuration: Duration(milliseconds: 1500),
                      delay: Duration(milliseconds: 500),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
