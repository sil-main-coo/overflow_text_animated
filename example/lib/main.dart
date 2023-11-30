import 'dart:async';

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
        body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Row(
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
              InfiniteAutoScrollingText(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfiniteAutoScrollingText extends StatefulWidget {
@override
_InfiniteAutoScrollingTextState createState() => _InfiniteAutoScrollingTextState();
}

class _InfiniteAutoScrollingTextState extends State<InfiniteAutoScrollingText> {
  String text = 'This is a sample text.     '; // Văn bản mẫu
  ScrollController _controller = ScrollController(); // Controller cho việc cuộn
  double scrollPosition = 0.0; // Vị trí cuộn

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);

    // Hàm tự động cuộn văn bản sau mỗi giây
    Timer.periodic(Duration(milliseconds: 150), (Timer timer) {
      _autoScroll();
    });
  }

  // Hàm tự động cuộn văn bản
  void _autoScroll() {
    setState(() {
      scrollPosition += 5.0; // Điều chỉnh tốc độ tự động cuộn ở đây
      _controller.jumpTo(scrollPosition);
      // Nếu vị trí cuộn gần cuối, thêm văn bản mới vào
      if (scrollPosition > _controller.position.maxScrollExtent) {
        text += 'Lorem Ipsum is simply dummy     ';
      }
    });
  }

  // Hàm lắng nghe sự kiện cuộn và kiểm tra vị trí cuộn
  void _scrollListener() {
    if (_controller.position.pixels > _controller.position.maxScrollExtent) {
      setState(() {
        // Nếu vị trí cuộn gần cuối, thêm văn bản mới vào
        text += 'Lorem Ipsum is simply dummy      ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(width: 200), // Dành khoảng trống ở đầu để văn bản không bắt đầu từ đầu màn hình
          RichText(
            text: TextSpan(
              text: text,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}