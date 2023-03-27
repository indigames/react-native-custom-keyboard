import React, { useEffect, useState } from 'react';
import {
  StyleSheet,
  View,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  TouchableWithoutFeedback,
  Keyboard,
  Text,
  Button,
} from 'react-native';
import { CustomKeyboard } from 'react-native-custom-keyboard';

export default function App() {
  console.log("App Started");
  const [input, setInput] = useState('');
  const [isKeyboardEnabled, setIsKeyboardEnabled] = useState(false);
  const [isKeyboardActive, setIsKeyboardActive] = useState(false);
  const [isKeyboardHasFullAccess, setIsKeyboardHasFullAccess] = useState(false);

  useEffect(() => {
    CustomKeyboard.state().getActiveState().then(setIsKeyboardActive);
    CustomKeyboard.state().getEnableState().then(setIsKeyboardEnabled);
    CustomKeyboard.state().getFullAccessState().then(setIsKeyboardHasFullAccess);

    var subscription = CustomKeyboard.events().characterEntered((character) => {
      console.log('character', character);
      setInput(input + character);
    });

    var keyboardHideSubscription = Keyboard.addListener('keyboardDidHide', () => {
      console.log('keyboardDidHide');
    });
    return () => {
      keyboardHideSubscription.remove();
      subscription.remove();
    }
  })

  const syncInput = () => {
    console.log('syncing input from native');
    CustomKeyboard.syncNativeInput();
  }

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === "ios" ? "padding" : "height"}
      style={styles.container}>
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={styles.inner}>
          <Text>Keyboard enable: {<Text style={{ color: isKeyboardEnabled ? '#0f0' : '#f00'}}>{isKeyboardEnabled ? "is enabled" : "disabled"}</Text>}</Text>
          <Text>Keyboard active: {<Text style={{ color: isKeyboardActive ? '#0f0' : '#f00'}}>{isKeyboardActive ? "activated" : "not active"}</Text>}</Text>
          <Text>Keyboard has full access: {<Text style={{ color: isKeyboardHasFullAccess ? '#0f0' : '#f00'}}>{isKeyboardHasFullAccess ? "has full access" : "hasn't have full access"}</Text>}</Text>
          <Text>Result: {input}</Text>
          <TextInput placeholder="Input" style={styles.textInput} />
          <Button title='Sync input' onPress={syncInput}/>
        </View>
      </TouchableWithoutFeedback>
    </KeyboardAvoidingView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  inner: {
    padding: 24,
    flex: 1,
    justifyContent: "space-around",
  },
  input: {
    height: 40,
    margin: 12,
    borderWidth: 1,
    padding: 10,
  },
  header: {
    fontSize: 36,
    marginBottom: 48,
  },
  textInput: {
    height: 40,
    borderColor: '#000000',
    borderBottomWidth: 1,
    marginBottom: 36,
  },
  btnContainer: {
    backgroundColor: 'white',
    marginTop: 12,
  },
});
