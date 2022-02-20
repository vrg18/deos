import 'package:device_frame/device_frame.dart';

/// Определения размеров экранных элементов

final DeviceInfo deviceFrameCurrentPhone = Devices.android.samsungS8;

const double basicBorderSize = 8; // основной отступ от краев экрана
const double widthWebWrapper = 400; // ширина WebWrapper (обертки для Web-экранов)
const double halfPerimeterForDesktop = 1500; // ширина+высота больше которой считаем что запущено на десктопе
const double heightOfStatusBar = 30; // высота полоски, иммитирующей StatusBar
const double heightOfStatusBarAdd = heightOfStatusBar - 24; // дополнительная высота для StatusBar
const double heightOfAppBar = 64; // высота AppBar
const double sizeIconsOfStatusBar = 14; // размер иконок и надписей StatusBar

const int durationPopUpMessage = 5; // 5 сек. всплывающее сообщение
