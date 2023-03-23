import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-custom-keyboard' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

const CustomKeyboard = NativeModules.CustomKeyboard
  ? NativeModules.CustomKeyboard
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function multiply(a: number, b: number): Promise<number> {
  return CustomKeyboard.multiply(a, b);
}

export function isEnabled(): Promise<boolean> {
  return CustomKeyboard.isEnabled();
}

export function isActivated(): Promise<boolean> {
  return CustomKeyboard.isActivated();
}
