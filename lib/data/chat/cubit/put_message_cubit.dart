import 'package:bloc/bloc.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/chat/repository/repository.dart';
import 'package:flutter/widgets.dart';

part 'put_message_state.dart';

class PutMessageCubit extends Cubit<PutMessageState> {
  final ChatRepository _chatRepository;

  PutMessageCubit(this._chatRepository) : super(const PutMessageInitial());

  Future<void> sendMessage(ChatMessageDto message) async {
    try {
      emit(const PutMessageSending());
      await _chatRepository.sendMessage(message.author.name, message.message);
      emit(const PutMessageSended());
    } on Exception catch (e) {
      if (e is InvalidMessageException) {
        emit(PutMessageFirebaseError(e.message));
      } else if (e is InvalidNameException) {
        emit(PutMessageFirebaseError(e.message));
      } else {
        emit(PutMessageFirebaseError(e.toString()));
      }
    }
  }

  void putMessageInitial() {
    emit(const PutMessageInitial());
  }
}
