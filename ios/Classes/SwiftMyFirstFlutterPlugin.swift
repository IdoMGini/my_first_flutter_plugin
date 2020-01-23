import Flutter
import UIKit
import Alamofire

public class SwiftMyFirstFlutterPlugin: NSObject, FlutterPlugin
{
    public static func register(with registrar: FlutterPluginRegistrar)
    {
        let channel = FlutterMethodChannel(name: "my_first_flutter_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftMyFirstFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
    {
        
        if call.method == "getPlatformVersion"
        {
            getPlatformVersion(result)
        }
        else if call.method == "getPokemonName"
        {
            getPokemonName(call, result: result)
        }
        else if call.method == "getIsShiny"
        {
            getIsShiny(call, result: result)
        }
        else
        {
            fatalError("unknow selector")
        }
    }
    
    func getPlatformVersion(_ result: @escaping FlutterResult)
    {
        Alamofire.SessionManager.default.request("https://www.google.com").response { (responce) in
            
            print(responce)
            result("My iOS is " + UIDevice.current.systemVersion + "\nstatusCode " + String(describing: responce.response!.statusCode))
        }
    }
    
    func getPokemonName(_ call: FlutterMethodCall, result: @escaping FlutterResult)
    {
        let name = MyPokemons.pokemonName()!
        
        result(name)
    }
    
    func getIsShiny(_ call: FlutterMethodCall, result: @escaping FlutterResult)
    {
        print("call.arguments = \(call.arguments.debugDescription)")
        print("call.arguments = \(String(describing: call.arguments))")
        
        guard  let arguments = call.arguments as? [String : Any] else
        {
            result(false)
            return
        }
        
        guard let name = arguments["name"] as? String, name == MyPokemons.pokemonName()  else
        {
            result(false)
            return
        }
        result(true)
    }
    
}
