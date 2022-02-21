part of 'get_messages_cubit.dart';

@immutable
abstract class GetMessagesState {
  const GetMessagesState();
}

class GetMessagesInitial extends GetMessagesState {
  const GetMessagesInitial();
}

class GetMessagesLoading extends GetMessagesState {
  const GetMessagesLoading();
}

class GetMessagesLoaded extends GetMessagesState {
  final List<ChatMessageDto> messages;

  const GetMessagesLoaded(this.messages);
}
class GetMessagesFirebaseError extends GetMessagesState {
  final String errorMessage;

  const GetMessagesFirebaseError(this.errorMessage);
}
