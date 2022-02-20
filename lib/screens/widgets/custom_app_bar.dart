import 'package:deos/data/chat/cubit/message_cubit.dart';
import 'package:deos/data/chat/models/user.dart';
import 'package:deos/data/providers/current_user.dart';
import 'package:deos/screens/res/sizes.dart';
import 'package:deos/screens/res/strings.dart';
import 'package:deos/screens/widgets/fake_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// Кастомизированный AppBar
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDesktop;
  final bool statusBarOnly;

  const CustomAppBar({
    required this.isDesktop,
    this.statusBarOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight((isDesktop ? heightOfStatusBarAdd : 0) + (statusBarOnly ? 0 : heightOfAppBar));
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: context.read<CurrentUser>().getUser == null ? null : context.read<CurrentUser>().getUser!.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));

    return widget.isDesktop && widget.statusBarOnly
        ? const SizedBox.shrink()
        : Column(
            children: [
              if (widget.isDesktop) // Эмулируем StatusBar для Web
                const FakeStatusBar(backgroundColor: Colors.black12, foregroundColor: Colors.black87),
              _buildAppBar(context),
            ],
          );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: heightOfAppBar,
      primary: !widget.isDesktop,
      leading: context.read<CurrentUser>().getUser == null ? null : _userAvatar(context.read<CurrentUser>().getUser!),
      title: _nicknameField(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<MessageCubit>().getMessages(),
        ),
      ],
    );
  }

  Widget _nicknameField(BuildContext context) {
    return TextField(
      controller: _controller,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: nicknameHint,
        hintStyle: TextStyle(color: Colors.white30),
        border: InputBorder.none,
      ),
      onSubmitted: (nick) {
        FocusScope.of(context).unfocus();
        _changeNick(context, nick);
      },
      onChanged: (nick) => _changeNick(context, nick),
    );
  }

  Widget _userAvatar(ChatUserDto currentUser) {
    return Center(
      child: CircleAvatar(
        radius: 16,
//        backgroundColor: avatarBackgroundColor,
        child: Text(currentUser.name.substring(0, 1).toUpperCase()),
      ),
    );
  }

  void _changeNick(BuildContext context, String nick) {
    if (context.read<CurrentUser>().getUser == null && nick.isNotEmpty ||
        context.read<CurrentUser>().getUser != null && context.read<CurrentUser>().getUser!.name != nick) {
      setState(() => context.read<CurrentUser>().setUser = nick);
    }
  }
}
