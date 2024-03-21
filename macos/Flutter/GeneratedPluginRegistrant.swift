//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

<<<<<<< HEAD
import location

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
=======
import geolocator_apple
import shared_preferences_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  GeolocatorPlugin.register(with: registry.registrar(forPlugin: "GeolocatorPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
>>>>>>> c2223a6703e1f8bba4d04338b89ef5bd006c00b5
}
