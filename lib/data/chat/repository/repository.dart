import 'package:deos/data/chat/models/geolocation.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/chat/models/user.dart';

/// Chat data holder.
///
/// The only tool needed to implement the chat.
abstract class ChatRepository {
  static const int maxNameLength = 40;
  static const int maxMessageLength = 80;

  /// Returns messages [ChatMessageDto] from a source.
  ///
  /// Pay your attentions that there are two types of authors: [ChatUserDto]
  /// and [ChatUserLocalDto]. Second one representing message from user with
  /// the same name that you specified in [sendMessage].
  ///
  /// Throws an [Exception] when some error appears.
  Future<List<ChatMessageDto>> get messages;

  /// Sends the message by [nickname] and [message] contents.
  ///
  /// Returns actual messages [ChatMessageDto] from a source (given your sent
  /// [message]).
  ///
  /// Throws an [Exception] when some error appears.
  ///
  /// Author's [nickname] mustn't be empty or longer than [maxNameLength]
  /// symbols. Throws an [InvalidNameException] when [nickname] is invalid.
  ///
  /// [message] mustn't be empty and longer than [maxMessageLength]. Throws an
  /// [InvalidMessageException].
  Future<List<ChatMessageDto>> sendMessage(String nickname, String message);

  /// Sends the message by [nickname] and [location] contents. [message] is
  /// optional.
  ///
  /// Returns actual messages [ChatMessageDto] from a source (given your sent
  /// [message]). Message with location point returns as
  /// [ChatMessageGeolocationDto].
  ///
  /// Throws an [Exception] when some error appears.
  ///
  /// Author's [nickname] mustn't be empty or longer than [maxNameLength]
  /// symbols. Throws an [InvalidNameException] when [nickname] is invalid.
  ///
  /// If [message] is non-null, content mustn't be empty and longer than
  /// [maxMessageLength]. Throws an [InvalidMessageException].
  Future<List<ChatMessageDto>> sendGeolocationMessage({
    required String nickname,
    required ChatGeolocationDto location,
    String? message,
  });
}

class InvalidNameException implements Exception {
  final String message;

  const InvalidNameException(this.message);

  @override
  String toString() => 'InvalidNameException(message: $message)';
}

class InvalidMessageException implements Exception {
  final String message;

  const InvalidMessageException(this.message);

  @override
  String toString() => 'InvalidMessageException(message: $message)';
}
