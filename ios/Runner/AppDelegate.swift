import Flutter
import UIKit
import GoogleMaps
import GooglePlaces

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      // Use Google Maps services
      GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
      GMSPlacesClient.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY")
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
