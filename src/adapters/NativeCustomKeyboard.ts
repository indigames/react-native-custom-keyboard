import { Platform } from 'react-native';
import { NativeModules } from 'react-native';

interface NativeCustomeKeyboardModule {
  getPathForAppGroup(): string;
  setTheme(selectedItem: string): void;
  getEnableState(): Promise<boolean>;
  getActiveState(): Promise<boolean>;
  getFullAccessState(): Promise<boolean>;
  setBackground(backgroundFilePath: string): void;

  openKeyboardSettings(): void;
  openInputSettings(): void;
}

export class NativeCustomKeyboard {
  private readonly nativeModule: NativeCustomeKeyboardModule;
  constructor() {
    this.nativeModule = NativeModules.RNCustomKeyboard;
  }

  public setBackground(backgroundFilePath: string) {
    this.nativeModule.setBackground(backgroundFilePath);
  }

  /**
   * to get the path container for app group on iOS
   *
   * @return {string}  {app group shared container path}
   * @memberof NativeCustomKeyboard
   */
  public getPathForAppGroup(): string {
    if (Platform.OS === 'ios')
      return this.nativeModule.getPathForAppGroup();
    return '';
  }

  public openKeyboardSettings() {
    this.nativeModule.openKeyboardSettings();
  }

  public openInputSettings(): void {
    if (Platform.OS === 'ios') {
      console.warn('openInputSettings is not supported on iOS');
      return;
    }
    this.nativeModule.openInputSettings();
  }

  public getEnableState(): Promise<boolean> {
    return this.nativeModule.getEnableState();
  }

  public getActiveState(): Promise<boolean> {
    return this.nativeModule.getActiveState();
  }

  public getFullAccessState(): Promise<boolean> {
    return this.nativeModule.getFullAccessState();
  }
}
