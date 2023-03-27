import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  getEnableState(): Promise<boolean>;
  getActiveState(): Promise<boolean>;
  getFullAccessState(): Promise<boolean>;
}

export class NativeCustomKeyboard {
  private readonly nativeCommandsModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeCommandsModule = NativeModules.RNCustomKeyboard;
  }

  public getEnableState(): Promise<boolean> {
    return this.nativeCommandsModule.getEnableState();
  }

  public getActiveState(): Promise<boolean> {
    return this.nativeCommandsModule.getActiveState();
  }

  public getFullAccessState(): Promise<boolean> {
    return this.nativeCommandsModule.getFullAccessState();
  }
}
