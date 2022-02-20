import 'package:auto_size_text/auto_size_text.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final ChatMessageDto _message;

  const MessageCard(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.deepPurple,
            child: Text(
              _message.author.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                _message.author.name,
                style: const TextStyle(fontSize: 20),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              AutoSizeText(
                _message.message,
                style: const TextStyle(fontSize: 14),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        ],
      ),
    );
  }
}
