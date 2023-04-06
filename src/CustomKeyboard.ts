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

  public setBackground(backgroundFilePath: string) {
    this.nativeCustomKeyboard.setBackground(backgroundFilePath);
  }

  setTheme(selectedItem: 'light' | 'dark' | string = 'dark') {
    this.nativeCustomKeyboard.setTheme(selectedItem);
  }

  public events(): EventsRegistry {
    return this.eventsRegistry;
  }

  public state(): NativeCustomKeyboard {
    return this.nativeCustomKeyboard;
  }
}
