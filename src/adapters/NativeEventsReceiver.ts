import {
  NativeModules,
  NativeEventEmitter,
  EventEmitter,
  EmitterSubscription,
  NativeModule
} from 'react-native';

interface NativeEmitterModule extends NativeModule {
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

  public characterEntered(callback: (character: string) => void): EmitterSubscription {
    console.log("adding listener for syncInputEvent");
    return this.emitter.addListener('syncInputEvent', callback);
  }
}
