part of 'put_message_cubit.dart';

@immutable
abstract class PutMessageState {
  const PutMessageState();
}

class PutMessageInitial extends PutMessageState {
  const PutMessageInitial();
}

class PutMessageSending extends PutMessageState {
  const PutMessageSending();
}

class PutMessageSended extends PutMessageState {
  const PutMessageSended();
}

class PutMessageFirebaseError extends PutMessageState {
  final String errorMessage;

  const PutMessageFirebaseError(this.errorMessage);
}
