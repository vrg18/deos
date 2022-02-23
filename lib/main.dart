import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deos/data/chat/cubit/get_messages_cubit.dart';
import 'package:deos/data/chat/cubit/put_message_cubit.dart';
import 'package:deos/data/chat/repository/firebase.dart';
import 'package:deos/data/providers/current_user.dart';
import 'package:deos/data/providers/desktop.dart';
import 'package:deos/firebase_options.dart';
import 'package:deos/screens/chat.dart';
import 'package:deos/screens/res/colors.dart';
import 'package:deos/screens/shell/web_device_frame.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform(
      androidKey: 'AIzaSyD5bCOfO29kCv2mIdmYa6CEKhud4Gs1YIU',
      iosKey: 'AIzaSyBZo6-selWq9F-oQqwjr9eB2VpSvFc9DYE',
      webKey: 'AIzaSyAtMxD7Nb6Z06IL2yg8DbI56xoneVhXSNQ',
    ),
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatRepository = ChatRepositoryFirebase(FirebaseFirestore.instance);

    return MultiProvider(
      providers: [
        Provider<Desktop>(create: (_) => Desktop()),
        ChangeNotifierProvider<CurrentUser>(create: (_) => CurrentUser(prefs)),
        BlocProvider(create: (_) => GetMessagesCubit(chatRepository)),
        BlocProvider(create: (_) => PutMessageCubit(chatRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: mainColorTheme,
          useMaterial3: true,
        ),
        home: Builder(
          builder: (BuildContext context) {
            context.read<Desktop>().setDesktop = MediaQuery.of(context).size.width + MediaQuery.of(context).size.height;
            return context.read<Desktop>().isDesktop ? const WebDeviceFrame(ChatScreen()) : const ChatScreen();
          },
        ),
      ),
    );
  }
}
