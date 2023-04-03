package net.indigames.customkeyboard

import android.content.Context
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


    override fun getName(): String {
        return NAME
    }

    @ReactMethod
    fun setBackground(path: String) {
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "setKeyboardBackground::path: $path")
        val preferences = reactApplicationContext.getSharedPreferences(
            "net.indigames.customkeyboard",
            Context.MODE_PRIVATE
        )
        val editor = preferences.edit()
        editor.putString(PrefHelper.Background.NAME, path)
        editor.apply()
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
        promise.resolve(false)
    }

    companion object {
        const val NAME = "RNCustomKeyboard"
    }
}
