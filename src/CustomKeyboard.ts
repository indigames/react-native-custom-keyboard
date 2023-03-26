import { NativeEventsReceiver } from './adapters/NativeEventsReceiver';
import { EventsRegistry } from './events/EventsRegistry';

export class CustomKeyboardRoot {
  private readonly nativeEventsReceiver: NativeEventsReceiver;
  private readonly eventsRegistry: EventsRegistry;
  // private readonly nativeCommandsSender: NativeCommandsSender;

  constructor() {
    this.nativeEventsReceiver = new NativeEventsReceiver();
    // this.nativeCommandsSender = new NativeCommandsSender();
    this.eventsRegistry = new EventsRegistry(this.nativeEventsReceiver);
  }

  syncNativeInput() {
    this.eventsRegistry.syncNativeInput();
  }

  public events(): EventsRegistry {
    return this.eventsRegistry;
  }
}
