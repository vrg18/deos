part of 'messages_cubit.dart';

@immutable
abstract class MessagesState {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  const MessagesInitial();
}

class GetMessagesLoading extends MessagesState {
  const GetMessagesLoading();
}

class PutMessageSending extends MessagesState {
  const PutMessageSending();
}

class GetMessagesLoaded extends MessagesState {
  final List<ChatMessageDto> messages;

  const GetMessagesLoaded(this.messages);
}

class MessagesFirebaseError extends MessagesState {
  final String errorMessage;

  const MessagesFirebaseError(this.errorMessage);
}
