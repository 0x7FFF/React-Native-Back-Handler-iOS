# React-Native-Back-Handler-iOS
An app exit from react-native to native

You need to import NativeModules from react-native

Your closing logic should look like this
```
  _onClosePress() {
    if (Platform.OS === 'android') {
      BackHandler.exitApp();
    } else {
      let BackHandlerIOS = NativeModules.BackHandlerIOS;
      BackHandlerIOS.exitApp(null);
    }
  }
```
This is useful when you need to close the react native app integrated into the native app
