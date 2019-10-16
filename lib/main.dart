import 'package:bloc/bloc.dart';
import 'package:creative_run/bloc/simple_bloc_delegate.dart';
import 'package:creative_run/generated/i18n.dart';
import 'package:creative_run/repo/network/network_client.dart';
import 'package:creative_run/repo/repository.dart';
import 'package:creative_run/ui/router/router.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final networkClient = NetworkClient();
  runApp(Provider(
    builder: (context) => Repository(networkClient),
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: router.splash,
      onGenerateRoute: router.generateRoute,
    );
  }
}
