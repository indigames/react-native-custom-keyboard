package net.indigames.customkeyboard

import android.util.Log
import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import dev.patrickgold.florisboard.BuildConfig
import dev.patrickgold.florisboard.ime.core.PrefHelper


class RNEventEmitter(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {
    private var prefs: PrefHelper
    init {
        prefs = PrefHelper(reactContext)
    }

    override fun getName(): String {
        return NAME
    }

    private fun sendEvent(eventName: String, input: String) {
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "sendEvent::$eventName: $input")
        reactApplicationContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit(eventName, input)
    }

    @ReactMethod
    fun syncNativeInput() {
        val input = prefs.input.text
        if (BuildConfig.DEBUG) Log.i(this::class.simpleName, "syncNativeInput::input: $input")
        if (input == "") return;
        sendEvent("syncInputEvent", input)
    }

    companion object {
        const val NAME = "RNEventEmitter"
    }
}
