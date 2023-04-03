import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  getEnableState(): Promise<boolean>;
  getActiveState(): Promise<boolean>;
  getFullAccessState(): Promise<boolean>;
  setBackground(background: string): void;
}

export class NativeCustomKeyboard {
  private readonly nativeCommandsModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeCommandsModule = NativeModules.RNCustomKeyboard;
  }

  public setBackground(background: string) {
    this.nativeCommandsModule.setBackground(background);
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
