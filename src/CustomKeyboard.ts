import { NativeCustomKeyboard } from './adapters/NativeCustomKeyboard';
import { NativeEventsReceiver } from './adapters/NativeEventsReceiver';
import { EventsRegistry } from './events/EventsRegistry';

export class CustomKeyboardRoot {
  private readonly nativeEventsReceiver: NativeEventsReceiver;
  private readonly eventsRegistry: EventsRegistry;
  private readonly nativeCustomKeyboard: NativeCustomKeyboard;

  constructor() {
    this.nativeEventsReceiver = new NativeEventsReceiver();
    this.nativeCustomKeyboard = new NativeCustomKeyboard();
    this.eventsRegistry = new EventsRegistry(this.nativeEventsReceiver);
  }

  syncNativeInput() {
    this.eventsRegistry.syncNativeInput();
  }

  public setBackground(backgroundFilePath: string, textColor: string = "#000000") {
    this.nativeCustomKeyboard.setBackground(backgroundFilePath, textColor);
  }

  public events(): EventsRegistry {
    return this.eventsRegistry;
  }

  public state(): NativeCustomKeyboard {
    return this.nativeCustomKeyboard;
  }
}
