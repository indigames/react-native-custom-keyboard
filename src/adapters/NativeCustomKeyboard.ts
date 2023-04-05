import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  setTheme(selectedItem: string): void;
  getEnableState(): Promise<boolean>;
  getActiveState(): Promise<boolean>;
  getFullAccessState(): Promise<boolean>;
  setBackground(backgroundFilePath: string): void;
}

export class NativeCustomKeyboard {
  private readonly nativeCommandsModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeCommandsModule = NativeModules.RNCustomKeyboard;
  }

  public setBackground(backgroundFilePath: string) {
    this.nativeCommandsModule.setBackground(backgroundFilePath);
  }

  setTheme(selectedItem: string) {
    this.nativeCommandsModule.setTheme(selectedItem);
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
