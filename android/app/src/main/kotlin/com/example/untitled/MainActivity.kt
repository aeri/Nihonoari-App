package com.LAPARCELA.nihonoari

import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import android.content.Intent.getIntent

import android.os.Bundle

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        if (Build.VERSION.SDK_INT < 20) {
            getIntent().putExtra("enable-software-rendering", true);
        }
        // start Flutter
        super.onCreate(savedInstanceState)
    }

}
