import Flutter
import UIKit

public class SwiftMyFirstFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_first_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftMyFirstFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    let name = MyPokemons.pokemonName()!
    result("My iOS is and " + UIDevice.current.systemVersion + "\npokemon name = \(name)")
  }
}
