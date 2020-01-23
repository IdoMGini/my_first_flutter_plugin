import 'dart:async';

import 'package:flutter/services.dart';

class MyFirstFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('my_first_flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> getPokemonName() async {
    final String result = await _channel.invokeMethod('getPokemonName');
    return result;
  }

  static Future<bool> isPokemonShiny(String name) async {
    dynamic arguments = {'name': name};

    final bool result = await _channel.invokeMethod('getIsShiny', arguments);
    return result;
  }
}
