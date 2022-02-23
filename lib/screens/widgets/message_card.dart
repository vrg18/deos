import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/screens/res/colors.dart';
import 'package:deos/screens/res/sizes.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final ChatMessageDto _message;

  const MessageCard(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: mainColorTheme.shade50),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(
                      (math.Random(_message.author.name.codeUnits.reduce((a, b) => a + b)).nextDouble() * 0xFFFFFF)
                          .toInt())
                  .withOpacity(1.0),
              child: Text(
                _message.author.name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: basicBorderSize),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  _message.author.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  _message.message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
