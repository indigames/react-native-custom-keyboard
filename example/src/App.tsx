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
  Linking,
  Image,
} from 'react-native';
import { CustomKeyboard } from 'react-native-custom-keyboard';
import RNFetchBlob from 'rn-fetch-blob';

export default function App() {
  console.log("App Started");
  const [backgroundPath, setBackgroundPath] = useState('');
  const [backgroundUrl, setBackgroundUrl] = useState('https://wallpaperaccess.com/full/521004.jpg');
  const [isDownloading, setIsDownloading] = useState(false);
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

  const openKeyboardSettings = () => {
    if (Platform.OS === 'ios') {
      Linking.openURL('App-Prefs:root=General&path=Keyboard');
    } else {
      Linking.sendIntent('android.settings.INPUT_METHOD_SETTINGS');
    }
  }

  const downloadBackground = () => {
    if (isDownloading) return;
    setIsDownloading(true);
    RNFetchBlob
      .config({ fileCache: true })
      .fetch('GET', backgroundUrl)
      .then((res) => {
        console.log('The file saved to ', res.path());
        setBackgroundPath(`${Platform.OS === 'android' ? 'file://' : ''}${res.path()}`);
        setIsDownloading(false);
        CustomKeyboard.setBackground(res.path());
      });
  }

  function clearBackground(): void {
    RNFetchBlob.fs.unlink(backgroundPath).then(() => {
      setBackgroundPath('');
      CustomKeyboard.setBackground('');
    });
  }

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === "ios" ? "padding" : "height"}
      style={styles.container}>
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={styles.inner}>
          {backgroundPath ? <Image source={{ uri: backgroundPath }} style={{ width: '100%', height: 200 }} /> : null}
          <Text>Keyboard enable: {<Text style={{ color: isKeyboardEnabled ? '#0f0' : '#f00' }}>{isKeyboardEnabled ? "is enabled" : "disabled"}</Text>}</Text>
          <Text>Keyboard active: {<Text style={{ color: isKeyboardActive ? '#0f0' : '#f00' }}>{isKeyboardActive ? "activated" : "not active"}</Text>}</Text>
          <Text>Keyboard has full access: {<Text style={{ color: isKeyboardHasFullAccess ? '#0f0' : '#f00' }}>{isKeyboardHasFullAccess ? "has full access" : "hasn't have full access"}</Text>}</Text>
          <Text>Result: {input}</Text>
          <TextInput value={backgroundUrl} onChangeText={setBackgroundUrl} placeholder="Keyboard background Url" style={styles.input} />
          <TextInput placeholder="Input" style={styles.textInput} />
          {
            isDownloading ? <Text>Downloading...</Text> :
              backgroundPath == "" ?
                <Button title='Set background' onPress={downloadBackground} /> :
                <Button color={"#f00"} title='Clear background' onPress={clearBackground} />
          }
          <Button title='Open keyboard settings' onPress={openKeyboardSettings} />
          <Button title='Sync input' onPress={syncInput} />
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
