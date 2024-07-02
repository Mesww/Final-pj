import UIKit
import Flutter
import GoogleMaps 

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Google Maps API key
    GMSServices.provideAPIKey("AIzaSyDnQobxF8kCqNHq_ZUSscixCLkVoKd00Dk")  

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  
  }
}
