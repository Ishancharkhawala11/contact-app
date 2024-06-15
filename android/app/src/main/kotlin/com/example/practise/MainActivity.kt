package com.example.practise

import android.os.Bundle
import com.google.android.gms.security.ProviderInstaller
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.practise/providerinstaller"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "installProvider") {
                installProvider()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun installProvider() {
        try {
            ProviderInstaller.installIfNeeded(applicationContext)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
