part of 'message_cubit.dart';

@immutable
abstract class MessageState {
  const MessageState();
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class MessagesLoading extends MessageState {
  const MessagesLoading();
}

class MessagesLoaded extends MessageState {
  final List<ChatMessageDto> messages;

  const MessagesLoaded(this.messages);
}

class MessageSending extends MessageState {
  const MessageSending();
}

class MessageSended extends MessageState {
  const MessageSended();
}

class MessageFirebaseError extends MessageState {
  final String errorMessage;

  const MessageFirebaseError(this.errorMessage);
}
