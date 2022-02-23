import 'package:bloc/bloc.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/chat/repository/repository.dart';
import 'package:flutter/widgets.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final ChatRepository _chatRepository;

  MessagesCubit(this._chatRepository) : super(const MessagesInitial());

  Future<void> getMessages() async {
    try {
      emit(const GetMessagesLoading());
      final List<ChatMessageDto> result = await _chatRepository.messages;
      // final List<ChatMessageDto> result = testMessages; // Моки
      emit(GetMessagesLoaded(result));
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(MessagesFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(MessagesFirebaseError(e.message));
      } else {
        emit(MessagesFirebaseError(e.toString()));
      }
    }
  }

  Future<void> putMessage(ChatMessageDto message) async {
    try {
      emit(const PutMessageSending());
      final List<ChatMessageDto> result = await _chatRepository.sendMessage(message.author.name, message.message);
      emit(GetMessagesLoaded(result));
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(MessagesFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(MessagesFirebaseError(e.message));
      } else {
        emit(MessagesFirebaseError(e.toString()));
      }
    }
  }
}
