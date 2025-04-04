package com.example.password_manager

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity(){
    override fun configureFlutterEngine(FlutterEngine: FlutterEngine){
        GeneratedPluginRegistrant.registerWith(FlutterEngine)
    }
}
