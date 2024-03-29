import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_demo_2/screens/user_details/screen/update_user/update_user_screen.dart';
import 'package:flutter_redux_demo_2/screens/user_details/states/app_state.dart';
import 'constants/dimens.dart';
import 'screens/user_details/store/form_store.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  final Store<AppState> store = getStore();
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    avgScreenSize = screenHeight + screenWidth / 2;
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: const UpdateUserScreen(),
      ),
    );
  }
}
