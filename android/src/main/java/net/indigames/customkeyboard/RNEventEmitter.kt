package net.indigames.customkeyboard

import android.content.Context
import android.util.Log
import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import dev.patrickgold.florisboard.BuildConfig


class RNEventEmitter(reactContext: ReactApplicationContext) :
    ReactContextBaseJavaModule(reactContext) {

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
        val preferences = reactApplicationContext.getSharedPreferences(
            "net.indigames.customkeyboard",
            Context.MODE_PRIVATE
        )
        val input = preferences.getString("input", "") ?: return
        if (input == "") return;
        val editor = preferences.edit()
        editor.putString("input", "")
        editor.apply()
        sendEvent("syncInputEvent", input)
    }

    companion object {
        const val NAME = "RNEventEmitter"
    }
}
