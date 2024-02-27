import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sonoreader2/redux/app_state.dart';
import 'package:sonoreader2/redux/reducer.dart';
import './screens/NavigateApp.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';



void main() {
  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
  );
  runApp( MyApp(store:store),);

}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({required this.store});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SONOREADER',

        home:NavScreen(),
      ),
    );
  }
}

