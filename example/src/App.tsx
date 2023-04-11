import React, { useCallback, useEffect, useState } from 'react';
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
import RNFetchBlob, { ReactNativeBlobUtilConfig } from 'react-native-blob-util';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Images from '../data/images.json';

export default function App() {
  console.log('App Started');
  const [backgroundPath, setBackgroundPath] = useState('');
  const [backgroundUrl, setBackgroundUrl] = useState('');
  const [isDownloading, setIsDownloading] = useState(false);
  const [input, setInput] = useState('');
  const [isKeyboardEnabled, setIsKeyboardEnabled] = useState(false);
  const [isKeyboardActive, setIsKeyboardActive] = useState(false);
  const [isKeyboardHasFullAccess, setIsKeyboardHasFullAccess] = useState(false);
  const [imageIndex, setImageIndex] = useState(0);

  let inputRef = React.useRef<TextInput>(null);

  const downloadBackground = async (url: string = ''): Promise<string> => {
    if (isDownloading || (backgroundUrl == '' && url == '')) return '';
    var finalUrl = url == '' ? backgroundUrl : url;
    console.log(`downloading (${isDownloading}) background url: ${finalUrl}`);
    setIsDownloading(true);

    // CustomKeyboard.setBackground already cached the image within app group container on iOS
    const appGroupPath = await CustomKeyboard.getPathForAppGroup();
    const fileName = url.substring(url.lastIndexOf('/') + 1);
    const overridePath = Platform.OS == 'ios' ? `${appGroupPath}/${fileName}` : undefined;
    console.log('override path', overridePath);
    const config: ReactNativeBlobUtilConfig = {
      fileCache: true,
      appendExt: 'jpg',
      path: overridePath,
    };
    var path = (await RNFetchBlob.config(config).fetch('GET', finalUrl)).path();

    setBackgroundUrl(finalUrl);
    return path;
  };

  const updateImageWithIndex = async (newIndex: number) => {
    var index = newIndex;
    if (index < 0) index = Images.data.length - 1;
    else if (newIndex >= Images.data.length) index = 0;

    setImageIndex(index);
    console.log('setting image index', index);
    await AsyncStorage.setItem('@imageIndex', index.toString());

    onSyncPressed(Images.root + Images.data[index]);
  };

  const onSyncPressed = (url = '') => {
    Keyboard.dismiss();
    downloadBackground(url).then((path) => {
      console.log('setting background path', path);
      CustomKeyboard.setBackground(path);
      setBackgroundPath(path);
      inputRef.current?.focus();
      setIsDownloading(false);
    });
  };

  useEffect(() => {
    CustomKeyboard.state().getActiveState().then(setIsKeyboardActive);
    CustomKeyboard.state().getEnableState().then(setIsKeyboardEnabled);
    CustomKeyboard.state()
      .getFullAccessState()
      .then(setIsKeyboardHasFullAccess);

    AsyncStorage.getItem('@imageIndex').then((indexStr) => {
      var index = indexStr ? parseInt(indexStr) : 0;

      updateImageWithIndex(index);
    });

    var subscription = CustomKeyboard.events().characterEntered((character) => {
      console.log('character', character);
      setInput((i) => i + character);
    });

    return () => {
      subscription.remove();
    };
  }, []);

  const openKeyboardSettings = useCallback(() => {
    if (Platform.OS === 'ios') {
      Linking.openURL('App-Prefs:root=General&path=Keyboard');
    } else {
      Linking.sendIntent('android.settings.INPUT_METHOD_SETTINGS');
    }
  }, []);

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      style={styles.container}
    >
      <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
        <View style={styles.inner}>
          <View>
            <Text>url: {backgroundUrl}</Text>
            <View
              style={{
                borderBottomColor: 'black',
                borderBottomWidth: StyleSheet.hairlineWidth,
              }}
            />
            <Text>path: {backgroundPath}</Text>
            <View
              style={{
                borderBottomColor: 'black',
                borderBottomWidth: StyleSheet.hairlineWidth,
                marginBottom: 5,
              }}
            />
            {backgroundPath ? (
              <Image
                source={{
                  uri: `${
                    Platform.OS === 'android' ? 'file://' : ''
                  }${backgroundPath}`,
                }}
                style={{ width: '100%', height: 150 }}
              />
            ) : null}
            {isDownloading ? (
              <Text
                style={{ alignContent: 'center', justifyContent: 'center' }}
              >
                Downloading...
              </Text>
            ) : (
              <View style={{ flexDirection: 'row' }}>
                <View style={{ flex: 1 }}>
                  <Button
                    title="◀"
                    onPress={() => updateImageWithIndex(imageIndex - 1)}
                  />
                </View>
                <View
                  style={{
                    flex: 1,
                    justifyContent: 'center',
                    flexDirection: 'row',
                  }}
                >
                  <Button title="Sync" onPress={() => onSyncPressed()} />
                </View>
                <View style={{ flex: 1 }}>
                  <Button
                    title="▶"
                    onPress={() => updateImageWithIndex(imageIndex + 1)}
                  />
                </View>
              </View>
            )}
          </View>

          <View>
            <Text>
              Keyboard enable:{' '}
              {
                <Text style={{ color: isKeyboardEnabled ? '#0f0' : '#f00' }}>
                  {isKeyboardEnabled ? 'is enabled' : 'disabled'}
                </Text>
              }
            </Text>
            <Text>
              Keyboard active:{' '}
              {
                <Text style={{ color: isKeyboardActive ? '#0f0' : '#f00' }}>
                  {isKeyboardActive ? 'activated' : 'not active'}
                </Text>
              }
            </Text>
            <Text>
              Keyboard has full access:{' '}
              {
                <Text
                  style={{ color: isKeyboardHasFullAccess ? '#0f0' : '#f00' }}
                >
                  {isKeyboardHasFullAccess
                    ? 'has full access'
                    : "hasn't have full access"}
                </Text>
              }
            </Text>
          </View>
          <View style={{ flexDirection: 'row' }}>
            <View style={{ flex: 1 }}>
              <TextInput
                placeholder="Input"
                style={styles.textInput}
                ref={inputRef}
              />
            </View>
            <View style={{ flex: 1 }}>
              <Text>Result: {input}</Text>
            </View>
          </View>
          <TextInput
            value={backgroundUrl}
            onChangeText={setBackgroundUrl}
            placeholder="Keyboard background Url"
            style={styles.textInput}
          />

          {!isKeyboardActive ? (
            <Button
              title="Open keyboard settings"
              onPress={openKeyboardSettings}
            />
          ) : null}
          <Button
            title="Sync input"
            onPress={() => CustomKeyboard.syncNativeInput()}
          />
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
    justifyContent: 'space-evenly',
  },
  textInput: {
    borderColor: '#000000',
    borderBottomWidth: 1,
  },
  btnContainer: {
    backgroundColor: 'white',
    marginTop: 12,
  },
});
