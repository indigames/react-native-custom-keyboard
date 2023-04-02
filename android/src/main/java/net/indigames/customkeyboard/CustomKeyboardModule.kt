package net.indigames.customkeyboard

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import dev.patrickgold.florisboard.ime.core.FlorisBoard

class CustomKeyboardModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  override fun getName(): String {
    return NAME
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  fun multiply(a: Double, b: Double, promise: Promise) {
    promise.resolve(a * b)
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
