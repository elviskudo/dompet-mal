import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class AnimatedSearchHint extends StatefulWidget {
  final List<String> hintTexts;
  final double fontSize;
  final Color? color;

  const AnimatedSearchHint({
    Key? key,
    required this.hintTexts,
    this.fontSize = 14,
    this.color,
  }) : super(key: key);

  @override
  State<AnimatedSearchHint> createState() => _AnimatedSearchHintState();
}

class _AnimatedSearchHintState extends State<AnimatedSearchHint> {
  int _currentTextIndex = 0;
  String _displayText = "";
  bool _isDeleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    const typing_speed = Duration(milliseconds: 50);
    const deleting_speed = Duration(milliseconds: 25);
    const pause_duration = Duration(milliseconds: 1200);

    _timer = Timer.periodic(typing_speed, (timer) {
      setState(() {
        final targetText = widget.hintTexts[_currentTextIndex];

        if (!_isDeleting) {
          if (_displayText.length < targetText.length) {
            _displayText = targetText.substring(0, _displayText.length + 1);
          } else {
            _timer?.cancel();
            _timer = Timer(pause_duration, () {
              setState(() {
                _isDeleting = true;
                _startAnimation();
              });
            });
          }
        } else {
          if (_displayText.isNotEmpty) {
            _displayText = _displayText.substring(0, _displayText.length - 1);
          } else {
            _isDeleting = false;
            _currentTextIndex =
                (_currentTextIndex + 1) % widget.hintTexts.length;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Cari $_displayText...",
      style: GoogleFonts.poppins(
        color: widget.color ?? Colors.grey[400],
        fontSize: widget.fontSize,
      ),
    );
  }
}
