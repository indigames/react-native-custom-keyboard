import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  isKeyboardEnable(): Promise<boolean>;
  isKeyboardActive(): Promise<boolean>;
  isKeyboardHasFullAccess(): Promise<boolean>;
}

export class NativeCustomKeyboard {
  private readonly nativeCommandsModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeCommandsModule = NativeModules.RNCustomKeyboard;
  }

  public isKeyboardEnable(): Promise<boolean> {
    return this.nativeCommandsModule.isKeyboardEnable();
  }

  public isKeyboardActive(): Promise<boolean> {
    return this.nativeCommandsModule.isKeyboardActive();
  }

  public isKeyboardHasFullAccess(): Promise<boolean> {
    return this.nativeCommandsModule.isKeyboardHasFullAccess();
  }
}
