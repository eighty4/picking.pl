# Picking.pl

[Install Flutter to contribute!](https://docs.flutter.dev/get-started/install)

## Flutter commands for development

### Reset cache storage on launch

Use this for `macos` development and use Chrome DevTools to delete localStorage for `web` development.

```shell
flutter run -d macos --dart-define RESET=true
```

### Develop for web in offline mode

```shell
flutter run -d chrome --wasm --no-web-resources-cdn
```
