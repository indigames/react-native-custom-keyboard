import { Platform } from 'react-native';
import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  getPathForAppGroup(): string;
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

  /**
   * to get the path container for app group on iOS
   *
   * @return {string}  {app group shared container path}
   * @memberof NativeCustomKeyboard
   */
  getPathForAppGroup(): string {
    if (Platform.OS === 'ios')
      return this.nativeCommandsModule.getPathForAppGroup();
    return '';
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
