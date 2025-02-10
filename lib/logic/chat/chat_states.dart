abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatLoading extends ChatStates {}

class ChatSuccess extends ChatStates {
  String msg = '';
  ChatSuccess({required this.msg});
}

class ChatFailure extends ChatStates {
  String msg = '';
  ChatFailure({required this.msg});
}
