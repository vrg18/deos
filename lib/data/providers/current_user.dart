import 'package:deos/data/chat/models/user.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Класс, хранящий текущего пользователя
/// Используется Provider
class CurrentUser with ChangeNotifier {
  final SharedPreferences _prefs;
  ChatUserDto? _currentUser;

  CurrentUser(this._prefs) {
    String? nick = _prefs.getString('currentUser');
    _currentUser = nick != null ? ChatUserDto(name: nick) : null;
  }

  ChatUserDto? get getUser {
    return _currentUser;
  }

  set setUser(String nick) {
    if (nick.isNotEmpty) {
      _currentUser = ChatUserDto(name: nick);
      _prefs.setString('currentUser', nick);
    } else {
      _currentUser = null;
      _prefs.clear();
    }
    notifyListeners();
  }
}
