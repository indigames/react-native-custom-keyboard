import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  getEnableState(): Promise<boolean>;
  getActiveState(): Promise<boolean>;
  getFullAccessState(): Promise<boolean>;
  setBackground(backgroundFilePath: string, textColor: string): void;
}

export class NativeCustomKeyboard {
  private readonly nativeCommandsModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeCommandsModule = NativeModules.RNCustomKeyboard;
  }

  public setBackground(backgroundFilePath: string, textColor: string = "#000000") {
    this.nativeCommandsModule.setBackground(backgroundFilePath, textColor);
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
