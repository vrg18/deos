import 'package:bloc/bloc.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/chat/repository/repository.dart';
import 'package:flutter/widgets.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  final ChatRepository _chatRepository;

  GetMessagesCubit(this._chatRepository) : super(const GetMessagesInitial());

  Future<void> getMessages() async {
    try {
      emit(const GetMessagesLoading());
      final List<ChatMessageDto> result = await _chatRepository.messages;
      // final List<ChatMessageDto> result = testMessages; // Моки
      emit(GetMessagesLoaded(result));
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(GetMessagesFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(GetMessagesFirebaseError(e.message));
      } else {
        emit(GetMessagesFirebaseError(e.toString()));
      }
    }
  }
}
