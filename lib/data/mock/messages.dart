import 'package:deos/data/chat/chat.dart';

/// Моковые данные

final List<ChatMessageDto> testMessages = [
  ChatMessageDto(
    author: const ChatUserDto(
      name: 'Илон Маск',
    ),
    message: 'Все на электромобили',
    createdDateTime: DateTime.now(),
  ),
  ChatMessageDto(
    author: const ChatUserDto(
      name: 'Шариков',
    ),
    message: 'Дай папиросочку, у тебя брюки в полосочку',
    createdDateTime: DateTime.now(),
  ),
];
