package net.indigames.customkeyboard

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.provider.Settings
import android.util.Log
import android.view.inputmethod.InputMethodManager
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
    fun setBackground(backgroundFilePath: String) {
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "setKeyboardBackground::path: $backgroundFilePath")
        prefs.background.path = backgroundFilePath
    }
    
    @ReactMethod
    fun setTheme(theme: String) {
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "setKeyboardTheme::theme: $theme")
        prefs.theme.name = theme
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
    
    @ReactMethod
    fun openKeyboardSettings() {
        val intent = Intent()
        intent.action = Settings.ACTION_INPUT_METHOD_SETTINGS
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        this.currentActivity?.startActivity(intent)
    }
    
    @ReactMethod
    fun openInputSettings() {
        val inputMethodManager = this.currentActivity?.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        inputMethodManager.showInputMethodPicker()
    }

    companion object {
        const val NAME = "RNCustomKeyboard"
    }
}
