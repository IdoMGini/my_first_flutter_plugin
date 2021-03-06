import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_first_flutter_plugin/my_first_flutter_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _pokemonName = 'Unknown';
  bool _pokemonState = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initPokemon();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MyFirstFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initPokemon() async {
    String pokemonName;
    bool pokemonState;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      pokemonName = await MyFirstFlutterPlugin.getPokemonName();
      pokemonState = await MyFirstFlutterPlugin.isPokemonShiny(pokemonName);
    } on PlatformException {
      pokemonName = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _pokemonName = pokemonName;
      _pokemonState = pokemonState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: <Widget>[
          Text('Running on: $_platformVersion\n'),
          Text('Pokemon name: $_pokemonName\n'),
          Text('Pokemon state: $_pokemonState\n'),
        ],)
      ),
    );
  }
}
