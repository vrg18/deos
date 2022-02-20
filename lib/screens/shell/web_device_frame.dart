import 'package:deos/screens/res/colors.dart';
import 'package:deos/screens/res/sizes.dart';
import 'package:deos/screens/res/strings.dart';
import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';

/// DeviceFrame - обертка для Web-экранов, своеобразный "закос" под телефон
class WebDeviceFrame extends StatefulWidget {
  final Widget _child;

  const WebDeviceFrame(this._child, {Key? key}) : super(key: key);

  @override
  _WebDeviceFrameState createState() => _WebDeviceFrameState();
}

class _WebDeviceFrameState extends State<WebDeviceFrame> {
  bool _isLandscape = false;
  bool _isKeyboard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: lessDarkColor,
        backgroundColor: wrapperBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(appTitleDemo),
        actions: [
          IconButton(
            onPressed: () => setState(() => _isLandscape = !_isLandscape),
            icon: const Icon(Icons.screen_rotation),
          ),
          IconButton(
            onPressed: () => setState(() => _isKeyboard = !_isKeyboard),
            icon: const Icon(Icons.keyboard),
          ),
        ],
      ),
      body: Container(
        color: wrapperBackgroundColor,
        child: Center(
          child: DeviceFrame(
            device: deviceFrameCurrentPhone,
            orientation: _isLandscape ? Orientation.landscape : Orientation.portrait,
            screen: VirtualKeyboard(
              isEnabled: _isKeyboard,
              child: widget._child,
            ),
          ),
        ),
      ),
    );
  }
}
