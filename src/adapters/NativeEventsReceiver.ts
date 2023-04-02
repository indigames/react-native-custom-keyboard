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
    console.log(this.nativeEmitterModule)
    console.log(this.emitter)
  }

  public syncNativeInput(): void {
    this.nativeEmitterModule.syncNativeInput();
  }

  public characterEntered(callback: (character: string) => void): EmitterSubscription {
    console.log("adding listener for syncInputEvent");
    return this.emitter.addListener('syncInputEvent', (character: any) => {
      console.log("syncInputEvent received: " + character);
      callback(character);
    });
  }
}
