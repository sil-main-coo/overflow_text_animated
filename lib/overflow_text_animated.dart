import 'dart:async';
import 'package:flutter/material.dart';

/// Include animations of text
enum OverFlowTextAnimations {
  /// scrolls in an infinite loop
  infiniteLoop,

  /// scroll from top to end and vice versa
  scrollOpposite
}

class OverflowTextAnimated extends StatefulWidget {
  const OverflowTextAnimated({
    required this.text,
    Key? key,
    this.animation = OverFlowTextAnimations.infiniteLoop,
    required this.style,
    this.delay = const Duration(milliseconds: 1500),
    this.animateDuration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    this.loopSpace = 0,
    this.scrollSpace = 5,
  }) : super(key: key);

  /// required properties
  final String text;

  /// style of text
  final TextStyle? style;

  /// [delay] is the break time between 2 animations
  final Duration delay;

  /// [animateDuration] is the duration of the animation
  final Duration animateDuration;

  /// motion curves of animation effects
  final Curve curve;

  /// animation type
  final OverFlowTextAnimations animation;

  /// space of 2 loop contents
  final int loopSpace;

  /// space of scroll
  final int scrollSpace;

  @override
  State<OverflowTextAnimated> createState() => _OverflowTextAnimatedState();
}

class _OverflowTextAnimatedState extends State<OverflowTextAnimated> {
  /// Scroll controller of SingleChildScrollView wrap text
  final ScrollController _scrollController = ScrollController();

  /// [_exceeded] save value overflow or not
  bool _exceeded = false;

  /// max lines of text. Now, only support 1 line
  final int _maxLines = 1;

  /// content of text
  late String _text;

  /// [infiniteLoop] - space characters, init based  [loopSpace]
  String _spaces = '';

  /// [infiniteLoop] - save position of scroll
  double _scrollPosition = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _text = widget.text;

    /// initial text

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_exceeded) {
        /// if text is overflow
        switch (widget.animation) {
          case OverFlowTextAnimations.scrollOpposite:
            await _handlerScrollOpposite();
            break;
          default:
            await _handlerInfiniteLoop();
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant OverflowTextAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      _text = widget.text;
    }
  }

  Future _handlerScrollOpposite() async {
    /// scroll to end and wait delay
    /// then scroll to top
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

  Future _handlerInfiniteLoop() async {
    for (int i = 0; i < widget.loopSpace; i++) {
      _spaces += ' ';
    }

    _scrollController.addListener(_scrollListener);

    /// Auto scroll with periodic
    _timer = Timer.periodic(widget.animateDuration, (Timer timer) {
      _autoScroll();
    });
  }

  /// Auto scroll
  void _autoScroll() {
    setState(() {
      _scrollPosition += widget.scrollSpace;
      _scrollController.animateTo(
        _scrollPosition,
        duration: widget.animateDuration,
        curve: Curves.linear,
      );
    });
  }

  /// Function listens for scroll event and checks scroll position
  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      setState(() {
        /// If the scroll position is near the end, add new text
        _text += '$_spaces${widget.text}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(
          text: _text,
          style: widget.style,
        );

        final tp = TextPainter(
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

        /// check overflow
        _exceeded = tp.didExceedMaxLines;

        return SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Text.rich(
            span,
            maxLines: _maxLines,
            style: widget.style,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();

    /// dispose controller
    _scrollController.dispose();
    super.dispose();
  }
}
