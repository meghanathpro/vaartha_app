import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaartha/data/providers/list_providers.dart';
import 'package:vaartha/data/providers/news_provider.dart';
import 'package:vaartha/ui/home.dart';
import 'package:vaartha/ui/screens/settings_dialog.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => OptionProvider()),
      ChangeNotifierProvider(create: (_) => ItemList()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      routes: {
        '/home': (context) => const Home(),
        '/dialog': (context) => const SettingsScreenDialog(),
      },
      home: const Home(),
    );
  }
}
