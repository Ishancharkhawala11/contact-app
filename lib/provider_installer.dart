import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise/main.dart';

class ProviderInstaller {
  static const MethodChannel _channel = MethodChannel('com.example.practise/providerinstaller');

  static Future<void> installProvider() async {
    try {
      await _channel.invokeMethod('installProvider');
    } on PlatformException catch (e) {
      print("Failed to install provider: '${e.message}'.");
    }
  }
}

// Call this method somewhere in your app, e.g., during initialization
// Example:
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProviderInstaller.installProvider();
  runApp(MyApp());
}
