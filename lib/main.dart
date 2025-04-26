import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scenario_maker_app/redux/store.dart';

import 'package:scenario_maker_app/services/auth.dart';
import 'package:scenario_maker_app/ui/home_screen.dart';
import 'package:scenario_maker_app/ui/screens/%D0%B0uthorization/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Scenario Maker App',
        home: StreamBuilder<User?>(
            stream: Auth().getAuthStateChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const LoginScreen();
              }
            }),
      ),
    );
  }
} 