import 'package:crypto/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/app_settings.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<AppSettings>().theme;
    return MaterialApp(
      title: 'Crypto Moedas',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: prefs.containsValue('dark') ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(),
    );
  }
}
