package com.example.pmpml_application

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Allow screenshots by clearing the FLAG_SECURE
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}
