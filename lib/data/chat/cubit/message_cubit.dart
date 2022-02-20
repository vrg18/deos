import 'package:bloc/bloc.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/chat/repository/repository.dart';
import 'package:flutter/widgets.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ChatRepository _chatRepository;

  MessageCubit(this._chatRepository) : super(const MessageInitial());

  Future<void> getMessages() async {
    try {
      emit(const MessagesLoading());
      final List<ChatMessageDto> result = await _chatRepository.messages;
      // final List<ChatMessageDto> result = testMessages; // Моки
      emit(MessagesLoaded(result));
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(MessageFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(MessageFirebaseError(e.message));
      } else {
        emit(MessageFirebaseError(e.toString()));
      }
    }
  }

  Future<void> sendMessage(ChatMessageDto message) async {
    try {
      emit(const MessageSending());
      await _chatRepository.sendMessage(message.author.name, message.message);
      emit(const MessageSended());
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(MessageFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(MessageFirebaseError(e.message));
      } else {
        emit(MessageFirebaseError(e.toString()));
      }
    }
  }
}
