package net.indigames.customkeyboard

import android.content.Context
import android.graphics.Color
import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import dev.patrickgold.florisboard.BuildConfig
import dev.patrickgold.florisboard.ime.core.FlorisBoard
import dev.patrickgold.florisboard.ime.core.PrefHelper

class CustomKeyboardModule(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

    private var prefs: PrefHelper

    init {
        prefs = PrefHelper(reactContext)
    }



    override fun getName(): String {
        return NAME
    }

    @ReactMethod
    fun setBackground(backgroundFilePath: String, keyTextColor: String) {
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "setKeyboardBackground::path: $backgroundFilePath")
        prefs.background.path = backgroundFilePath
        prefs.background.textColor = Color.parseColor(keyTextColor)
    }

    @ReactMethod
    fun getActiveState(promise: Promise) {
        promise.resolve(FlorisBoard.checkIfImeIsSelected(reactApplicationContext))
    }

    @ReactMethod
    fun getEnableState(promise: Promise) {
        promise.resolve(FlorisBoard.checkIfImeIsEnabled(reactApplicationContext))
    }

    @ReactMethod
    fun getFullAccessState(promise: Promise) {
        promise.resolve(true)
    }

    companion object {
        const val NAME = "RNCustomKeyboard"
    }
}
