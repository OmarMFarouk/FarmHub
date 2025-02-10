import 'package:farm_hub/logic/chat/chat_states.dart';
import 'package:farm_hub/shared/models/chats_model.dart';
import 'package:farm_hub/shared/network/remote/chat_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);
  TextEditingController msgController = TextEditingController();
  FocusNode msgFocus = FocusNode();
  final ScrollController scrollCont = ScrollController();

  ChatsModel? chatsModel;
  Future<void> fetchChats() async {
    emit(ChatLoading());
    ChatsApi().fetchChats().then((res) async {
      if (res == 'error' || res == null) {
        emit(ChatFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(ChatFailure(msg: res['message']));
      } else {
        chatsModel = ChatsModel.fromJson(res);
        emit(ChatInitial());
      }
    });
  }

  void sendMessage({required participantId, required roomId}) {
    emit(ChatLoading());
    String msg = msgController.text.trim();
    msgController.clear();
    msgFocus.unfocus();
    ChatsApi()
        .sendMessage(
            messageBody: msg, participantId: participantId, roomId: roomId)
        .then((res) async {
      if (res == 'error' || res == null) {
        emit(ChatFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(ChatFailure(msg: res['message']));
      } else {
        await fetchChats();
        scrollToBottom();
      }
    });
  }

  readMessage({required String roomId}) {
    Future.delayed(const Duration(milliseconds: 500), () {
      ChatsApi().readMessage(roomId: roomId);
      scrollToBottom();
      fetchChats();
    });
  }

  void scrollToBottom() {
    if (scrollCont.hasClients) {
      scrollCont.animateTo(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(seconds: 2),
          scrollCont.position.maxScrollExtent);
    }
  }
}
