import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

final _androidAppRetain = MethodChannel("android_app_retain");

class ThemeService {
  BehaviorSubject<List<dynamic>> _colors$;
  BehaviorSubject<List<dynamic>> get colors$ => _colors$;

  ThemeService() {
    _initStreams();
  }

  void _initStreams() {
    _colors$ = BehaviorSubject<List<dynamic>>.seeded([0x000000, 0xffffff]);
  }

  void updateTheme(path) async {
    final colors =
        await _androidAppRetain.invokeMethod("getColor", {"path": path});
    _colors$.add(colors);
  }
}
