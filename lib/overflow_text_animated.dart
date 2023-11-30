import 'package:flutter/material.dart';

class OverflowTextAnimated extends StatefulWidget {
  const OverflowTextAnimated(this.text,
      {Key? key,
      this.style,
      this.delay = const Duration(milliseconds: 1500),
      this.animateDuration = const Duration(milliseconds: 4000),
      this.curve = Curves.easeInOut})
      : super(key: key);

  final String text;
  final TextStyle? style;
  final Duration delay;
  final Duration animateDuration;
  final Curve curve;

  @override
  State<OverflowTextAnimated> createState() => _OverflowTextAnimatedState();
}

class _OverflowTextAnimatedState extends State<OverflowTextAnimated> {
  final ScrollController _scrollController = ScrollController();

  bool _exceeded = false;
  final int _maxLines = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_exceeded) {
        while (true) {
          await Future.delayed(widget.delay);
          if (_scrollController.hasClients) {
            await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: widget.animateDuration,
              curve: widget.curve,
            );
            await Future.delayed(widget.delay);
            if (_scrollController.hasClients) {
              await _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: widget.animateDuration,
                curve: widget.curve,
              );
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var span = TextSpan(
        text: widget.text,
        style: widget.style,
      );

      var tp = TextPainter(
          maxLines: _maxLines,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          text: span,
          strutStyle: StrutStyle(
            fontSize: widget.style?.fontSize,
            fontWeight: widget.style?.fontWeight,
            height: widget.style?.fontSize,
            fontStyle: widget.style?.fontStyle,
            fontFamily: widget.style?.fontFamily,
          ));

      tp.layout(maxWidth: size.maxWidth);

      _exceeded = tp.didExceedMaxLines;

      return SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Text.rich(
          span,
          maxLines: _maxLines,
          style: widget.style,
        ),
      );
    });
  }
}
