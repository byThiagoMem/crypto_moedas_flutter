import 'package:crypto/configs/app_settings.dart';
import 'package:crypto/repositories/conta_repository.dart';
import 'package:crypto/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: AppWidget(),
    ),
  );
}
