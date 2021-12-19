import Cocoa
import Vision
import FlutterMacOS

public class OcrEngineBuiltinPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ocr_engine_builtin", binaryMessenger: registrar.messenger)
        let instance = OcrEngineBuiltinPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isSupportedOnCurrentPlatform":
            isSupportedOnCurrentPlatform(call, result: result)
            break
        case "detectText":
            detectText(call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func isSupportedOnCurrentPlatform(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(macOS 10.16, *) {
            result(true)
        } else {
            result(false)
        }
    }
    
    public func detectText(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args:[String: Any] = call.arguments as! [String: Any]
        let base64Image: String =  args["base64Image"] as! String;
        
        let imageData = Data(base64Encoded: base64Image, options: .ignoreUnknownCharacters)
        let image: NSImage = NSImage(data: imageData!)!
        var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        
        let cgImage: CGImage = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
        
        if #available(macOS 10.16, *) {
            let requestHandler: VNImageRequestHandler = VNImageRequestHandler(cgImage: cgImage)
            
            let request = VNRecognizeTextRequest(completionHandler: { request, error in
                DispatchQueue.main.async {
                    let observations: [VNRecognizedTextObservation] = request.results as? [VNRecognizedTextObservation] ?? []
                    
                    var text: String = ""
                    for observation in observations {
                        text.append(observation.topCandidates(1)[0].string)
                        text.append(" ")
                    }
                    result(text)
                }
            })
            request.recognitionLanguages = ["zh-Hans"]
            do {
                try requestHandler.perform([request])
            } catch {
                result(FlutterError(code: "unknown_error", message: error.localizedDescription, details: nil))
            }
        } else {
            result(FlutterError(code: "unsupported_error", message: "", details: nil))
        }
    }
}
