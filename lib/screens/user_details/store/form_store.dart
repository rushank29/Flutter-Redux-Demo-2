import 'dart:io';
import 'package:flutter_redux_demo_2/screens/user_details/reducer/app_reducer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import '../states/app_state.dart';
import 'package:redux_persist/redux_persist.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/state.json');
}

Future<Store<AppState>> createStore() async {
  // Create Persistor
  final persistor = Persistor<AppState>(
    storage: FileStorage(await _localFile),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  // Loading initial state
  dynamic initialState;
  try {
    initialState = await persistor.load();
    print("Initial state ===========> $initialState");
    print("Local file =========> ${FileStorage(await _localFile).file}");
    print("File data =========> ${await FileStorage(await _localFile).file.readAsString()}");
  } catch (e) {
    initialState = null;
    print("Initial state is set to null and following error occurred ===========> $e");
  }

  return Store(
    appReducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [persistor.createMiddleware()],
  );
}

late Store<AppState> store;

Future<void> initStore() async {
  store = await createStore();
}

Store<AppState> getStore() {
  return store;
}
