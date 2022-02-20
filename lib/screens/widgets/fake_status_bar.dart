import 'dart:async';

import 'package:deos/screens/res/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Фэйковый StatusBar для Web
class FakeStatusBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;

  const FakeStatusBar({required this.backgroundColor, required this.foregroundColor, Key? key}) : super(key: key);

  @override
  _FakeStatusBarState createState() => _FakeStatusBarState();
}

class _FakeStatusBarState extends State<FakeStatusBar> {
  late String _timeString;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _getTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightOfStatusBar,
      color: widget.backgroundColor,
      child: Row(
        children: [
          const SizedBox(width: sizeIconsOfStatusBar),
          Text(
            _timeString,
            style: TextStyle(
              fontSize: sizeIconsOfStatusBar - 2,
              color: widget.foregroundColor,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.wifi,
            color: widget.foregroundColor,
            size: sizeIconsOfStatusBar,
          ),
          Icon(
            Icons.signal_cellular_alt,
            color: widget.foregroundColor,
            size: sizeIconsOfStatusBar,
          ),
          Icon(
            Icons.battery_full,
            color: widget.foregroundColor,
            size: sizeIconsOfStatusBar,
          ),
          const SizedBox(width: sizeIconsOfStatusBar),
        ],
      ),
    );
  }

  void _getTime() {
    final String formattedDateTime = _formatDateTime(DateTime.now());
    setState(() => _timeString = formattedDateTime);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('H:mm').format(dateTime);
  }
}
