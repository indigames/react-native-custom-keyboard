import {
  NativeModules,
  NativeEventEmitter,
  EventEmitter,
  EmitterSubscription,
  NativeModule,
} from 'react-native';

interface NativeEmitterModule extends NativeModule {
  updateHasSyncedInput(): Promise<void>;
  syncNativeInput(): void;
}

export class NativeEventsReceiver {
  private readonly nativeEmitterModule: NativeEmitterModule;
  private emitter: EventEmitter;
  constructor() {
    this.nativeEmitterModule = NativeModules.RNEventEmitter;
    this.emitter = new NativeEventEmitter(this.nativeEmitterModule);
  }

  public syncNativeInput(): void {
    this.nativeEmitterModule.syncNativeInput();
  }

  public updateHasSynced(): Promise<void> {
    return this.nativeEmitterModule.updateHasSyncedInput();
  }

  public characterEntered(
    callback: (character: string) => void
  ): EmitterSubscription {
    return this.emitter.addListener('syncInputEvent', (character: any) => {
      callback(character);
    });
  }
}
