import 'package:another_flushbar/flushbar.dart';
import 'package:deos/data/chat/cubit/messages_cubit.dart';
import 'package:deos/data/chat/models/message.dart';
import 'package:deos/data/providers/current_user.dart';
import 'package:deos/data/providers/desktop.dart';
import 'package:deos/screens/res/sizes.dart';
import 'package:deos/screens/res/strings.dart';
import 'package:deos/screens/widgets/custom_app_bar.dart';
import 'package:deos/screens/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Chat screen templete. This is your starting point.
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isPutMessage = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isDesktop: context.read<Desktop>().isDesktop,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MessagesCubit, MessagesState>(
              listener: (context, state) {
                if (state is MessagesFirebaseError) {
                  _showFlushBar(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                if (state is GetMessagesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetMessagesLoaded) {
                  return _buildMessagesList(state.messages);
                } else {
                  return const SizedBox.expand();
                }
              },
            ),
          ),
          if (context.watch<CurrentUser>().getUser != null) _sendMessageField(),
        ],
      ),
    );
  }

  Widget _buildMessagesList(List<ChatMessageDto> messages) {
    return Padding(
      padding: const EdgeInsets.only(top: basicBorderSize, left: basicBorderSize, right: basicBorderSize),
      child: StaggeredGridView.countBuilder(
        itemCount: messages.length,
        crossAxisCount: 1,
        mainAxisSpacing: basicBorderSize,
        itemBuilder: (context, index) => MessageCard(messages[index]),
        staggeredTileBuilder: (_) => StaggeredTile.fit(messages.length),
      ),
    );
  }

  Widget _sendMessageField() {
    return Material(
      elevation: basicBorderSize,
      child: BlocConsumer<MessagesCubit, MessagesState>(
        listener: (context, state) {
          if (state is MessagesFirebaseError) {
            _showFlushBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (_isPutMessage && state is GetMessagesLoaded) {
            _isPutMessage = false;
            _textController.clear();
          }
          return TextField(
            controller: _textController,
            style: const TextStyle(color: Colors.black),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: messageHint,
              hintStyle: const TextStyle(color: Colors.black45),
              contentPadding: const EdgeInsets.only(left: 10),
              suffixIcon: state is PutMessageSending
                  ? const Padding(
                      padding: EdgeInsets.all(basicBorderSize),
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ),
                      onPressed: () => _sendMessage(context),
                    ),
            ),
            onSubmitted: (_) => _sendMessage(context),
          );
        },
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    if (_textController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      _isPutMessage = true;
      context.read<MessagesCubit>().putMessage(
            ChatMessageDto(
              author: context.read<CurrentUser>().getUser!,
              message: _textController.text,
              createdDateTime: DateTime.now(),
            ),
          );
    }
  }

  void _showFlushBar(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: durationPopUpMessage),
      maxWidth: context.read<Desktop>().isDesktop ? widthWebWrapper * 0.9 : null,
      margin: context.read<Desktop>().isDesktop ? const EdgeInsets.only(bottom: 50) : const EdgeInsets.all(0),
    ).show(context);
  }
}
