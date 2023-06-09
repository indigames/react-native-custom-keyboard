import { EmitterSubscription } from 'react-native';
import { NativeEventsReceiver } from '../adapters/NativeEventsReceiver';

export class EventsRegistry {
  constructor(private nativeEventsReceiver: NativeEventsReceiver) {}

  public syncNativeInput(): void {
    this.nativeEventsReceiver.syncNativeInput();
  }

  public updateHasSynced(): Promise<void> {
    return this.nativeEventsReceiver.updateHasSynced();
  }

  public characterEntered(
    callback: (event: String) => void
  ): EmitterSubscription {
    return this.nativeEventsReceiver.characterEntered(callback);
  }
}
