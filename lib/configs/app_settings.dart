import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Trabalhando com Shared_Preferences
class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;

  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };

  Map<String, String> theme = {
    'theme': 'light',
  };

  AppSettings() {
    _startSettings();
  }
  //Método para chamar a instancia e popular a localização
  _startSettings() async {
    await _startPreferences();
    await _readLocale();
    _readTheme();
  }

  //Método para fazer a instancia
  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Método para ler as preferencias da localização
  _readLocale() {
    final local = _prefs.getString('local') ?? 'pt_BR';
    final name = _prefs.getString('name') ?? 'R\$';
    locale = {
      'locale': local,
      'name': name,
    };
    notifyListeners();
  }

  //Método para ser preferencia de Tema
  _readTheme() {
    final themes = _prefs.getString('theme') ?? 'light';
    theme = {
      'theme': themes,
    };
    notifyListeners();
  }

  //Método para setar nova localização
  setLocale(String local, String name) async {
    await _prefs.setString('local', local);
    await _prefs.setString('name', name);
    await _readLocale();
  }

  setTheme(String theme) async {
    await _prefs.setString('theme', theme);
    await _readTheme();
  }
}
