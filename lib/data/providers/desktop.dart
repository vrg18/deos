import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:deos/screens/res/sizes.dart';

/// Класс, проверяющий и хранящий сведение, на десктопе ли запущено приложение
/// Используется Provider
class Desktop {
  late bool _isDesktop;

  bool get isDesktop => _isDesktop;

  set setDesktop(double halfPerimeter) {
    _isDesktop = kIsWeb && halfPerimeter > halfPerimeterForDesktop;
  }
}
